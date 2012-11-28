/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:30
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {

import be.devine.cp3.presentation.model.AppModel;

import flash.events.Event;

import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.animation.Tween;

import starling.events.Event;

public class DataParser {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _vectorSlides:Vector.<SlideVO>;
    private var _xml:XML;
    private var _appModel:AppModel;

    //Constructor
    public function DataParser() {
        trace("[DataParser] Construct");
        _vectorSlides = new Vector.<SlideVO>();
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.XML_CHANGED, xmlChangedHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function parse():void {
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.load(new URLRequest(_appModel.xmlPath));
        urlLoader.addEventListener(flash.events.Event.COMPLETE, loadedHandler);
    }

    private function parseXML():void{
        for each(var slide:XML in _xml.slide){
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
            _vectorSlides.push(slideVO);
        }
        _appModel.vectorSlides = _vectorSlides;
    }

    private function xmlChangedHandler(event:starling.events.Event):void {
        this.parse();
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

    private function loadedHandler(event:flash.events.Event):void {
        var l:URLLoader = event.currentTarget as URLLoader;
        xml = XML(l.data);
    }

    public function get xml():XML {
        return _xml;
    }

    public function set xml(value:XML):void {
        if(_xml != value){
            _xml = value;
            parseXML();
        }
    }
}
}
