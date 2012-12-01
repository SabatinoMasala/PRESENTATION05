/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:26
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.model {
import be.devine.cp3.presentation.SlideType;
import be.devine.cp3.presentation.SlideVO;

import flash.events.Event;

import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.display.Image;

import starling.events.Event;

import starling.events.EventDispatcher;

public class AppModel extends starling.events.EventDispatcher {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public static const DATA_CHANGED:String = "dataChanged";
    public static const MENU_STATE_CHANGED:String = "menuStringChanged";
    public static const XML_CHANGED:String = "xmlChanged";
    public static const SLIDE_CHANGED:String = "slideChanged";

    private var _vectorSlides:Vector.<SlideVO>;
    private var _menuVisible:Boolean = false;
    private var _currentIndex:uint;
    private var _currentSlide:SlideVO;

    private static var _instance:AppModel;

    //Constructor
    public function AppModel(e:Enforcer) {
        if(e == null){
            throw new Error("Use .getInstance()");
        }
        trace("[AppModel] Construct");
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public static function getInstance():AppModel{
        if(_instance == null){
            _instance = new AppModel(new Enforcer());
        }
        return _instance;
    }

    public function goToNext():void{
        if(this.currentIndex < _vectorSlides.length - 1){
            currentSlide = _vectorSlides[this.currentIndex+1];
        }
    }

    public function goToPrev():void{

        if(this.currentIndex > 0){
            currentSlide = _vectorSlides[this.currentIndex-1];
        }
    }

    public function load(pathToXml:String):void{
        trace("loading xml at path ", pathToXml);
        _vectorSlides = new Vector.<SlideVO>();
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.load(new URLRequest(pathToXml));
        urlLoader.addEventListener(flash.events.Event.COMPLETE, loadedHandler);
    }

    private function loadedHandler(e:flash.events.Event):void {
        trace("xml loaded");
        var l:URLLoader = e.currentTarget as URLLoader;
        var xml:XML = XML(l.data);
        var tempVector:Vector.<SlideVO> = new Vector.<SlideVO>();
        for each(var slide:XML in xml.slide){
            var slideType:String;
            var slideVO:SlideVO = new SlideVO();
            var type:String = slide.@type;

            switch (type){
                default:
                case SlideType.TITLE:
                    slideType = SlideType.TITLE;
                    slideVO.title = slide.title;
                    break;
                case SlideType.BULLETS:
                    var vectorBullets:Vector.<String> = new Vector.<String>();
                    for each(var bullet:XML in slide.bullet){
                        vectorBullets.push(bullet);
                    }
                    slideVO.bullets = vectorBullets;
                    slideType = SlideType.BULLETS;
                    break;
                case SlideType.IMAGE_ONLY:
                    slideVO.imagePath = slide.image.@src;
                    slideType = SlideType.IMAGE_ONLY;
                    break;
                case SlideType.IMAGE_TITLE:
                    slideVO.title = slide.title;
                    slideVO.imagePath = slide.image.@src;
                    slideType = SlideType.IMAGE_TITLE;
                    break;
            }
            slideVO.type = slideType;
            tempVector.push(slideVO);
        }
        this.vectorSlides = tempVector;
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
    public function get menuVisible():Boolean {
        return _menuVisible;
    }

    public function set menuVisible(value:Boolean):void {
        if(_menuVisible != value){
            _menuVisible = value;

            //dispatchen
            dispatchEvent(new starling.events.Event(MENU_STATE_CHANGED));
        }
    }

    public function get vectorSlides():Vector.<SlideVO> {
        return _vectorSlides;
    }

    public function set vectorSlides(value:Vector.<SlideVO>):void {
        if(_vectorSlides != value){
            _vectorSlides = value;
            dispatchEvent(new starling.events.Event(DATA_CHANGED));
            trace("dispatching data_changed");
        }
    }

    public function get currentSlide():SlideVO {
        return _currentSlide;
    }

    public function set currentSlide(value:SlideVO):void {
        if(_currentSlide != value){
            _currentSlide = value;
            dispatchEvent(new starling.events.Event(SLIDE_CHANGED));
            trace("dispatching slide_changed");
        }
    }

    public function get currentIndex():uint {
        return _vectorSlides.indexOf(_currentSlide);
    }
}
}

// Singleton enforcer
internal class Enforcer{}