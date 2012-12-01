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
import be.devine.cp3.presentation.Utils;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.slide.BulletElement;
import be.devine.cp3.presentation.slide.ImageElement;
import be.devine.cp3.presentation.slide.TitleElement;

import flash.events.Event;

import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.display.Image;

import starling.events.Event;

import starling.events.EventDispatcher;

/**
 * AppModel
 *
 * AppModel voor de applicatie. Deze klasse is een singleton, instanties worden via getInstance() aangemaakt.
 */

public class AppModel extends starling.events.EventDispatcher {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public static const DATA_CHANGED:String = "dataChanged";
    public static const MENU_STATE_CHANGED:String = "menuStringChanged";
    public static const SLIDE_CHANGED:String = "slideChanged";

    private var _vectorSlides:Vector.<SlideVO>;
    private var _menuVisible:Boolean = false;
    private var _currentIndex:uint;
    private var _currentSlide:SlideVO;

    private static var _instance:AppModel;

    /**
     * Instantieren van AppModel. Door een Enforcer te vragen als argument kan deze klasse niet van buitenaf worden aangemaakt.
     * @param e Enforcer (interne klasse in AppModel)
     */

    //Constructor
    public function AppModel(e:Enforcer) {
        if(e == null){
            throw new Error("Use .getInstance()");
        }
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    /**
     * Maakt een nieuwe instantie aan van AppModel als er nog geen bestaat en returnt hem.
     * @return AppModel instantie
     */

    public static function getInstance():AppModel{
        if(_instance == null){
            _instance = new AppModel(new Enforcer());
        }
        return _instance;
    }

    /**
     * Checkt of er een volgende slide is en er naartoe gaat.
     */

    public function goToNext():void{
        if(this.currentIndex < _vectorSlides.length - 1){
            currentSlide = _vectorSlides[this.currentIndex+1];
        }
    }

    /**
     * Checkt of er een vorige slide is en er naartoe gaat.
     */

    public function goToPrev():void{

        if(this.currentIndex > 0){
            currentSlide = _vectorSlides[this.currentIndex-1];
        }
    }

    /**
     * Zal een XML beginnen inladen
     * @param pathToXml path naar XML bestand
     */

    public function load(pathToXml:String):void{
        _vectorSlides = new Vector.<SlideVO>();
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.load(new URLRequest(pathToXml));
        urlLoader.addEventListener(flash.events.Event.COMPLETE, loadedHandler);
    }

    /**
     * Als de XML ingeladen is zal de XML geparsed worden
     * @param e flash.events.Event
     */

    private function loadedHandler(e:flash.events.Event):void {
        var l:URLLoader = e.currentTarget as URLLoader;
        var xml:XML = XML(l.data);
        parse(xml);
    }

    public function parse(xml:XML):void{
        var tempVector:Vector.<SlideVO> = new Vector.<SlideVO>();
        for each(var slide:XML in xml.slide){

            var slideVO:SlideVO = new SlideVO();
            var type:String = slide.@type;

            var elementVector:Vector.<ISlideElement> = new Vector.<ISlideElement>();

            switch (type){
                default:
                case SlideType.TITLE:
                    elementVector.push(new TitleElement(slide.title, Utils.str_to_uint(slide.title.@backgroundColor), Utils.str_to_uint(slide.title.@textColor), true));
                    break;
                case SlideType.BULLETS:
                    var vectorBullets:Vector.<String> = new Vector.<String>();
                    for each(var bullet:XML in slide.bullet){
                        vectorBullets.push(bullet);
                    }
                    elementVector.push(new BulletElement(vectorBullets));
                    break;
                case SlideType.IMAGE_ONLY:
                    elementVector.push(new ImageElement(slide.image.@src));
                    break;
                case SlideType.IMAGE_TITLE:
                    elementVector.push(new ImageElement(slide.image.@src));
                    elementVector.push(new TitleElement(slide.title, Utils.str_to_uint(slide.title.@backgroundColor), Utils.str_to_uint(slide.title.@textColor)));
                    break;
            }
            slideVO.arrElements = elementVector;
            slideVO.backgroundColor = Utils.str_to_uint(slide.@backgroundColor);
            tempVector.push(slideVO);
        }
        this.vectorSlides = tempVector;
        this.currentSlide = this.vectorSlides[0];
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

    /**
     * Getter en Setter voor zichtbaarheid van menu
     *
     * @param value Boolean
     * @return Boolean
     */

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

    /**
     * Getter & Setter voor de Vector met slides
     *
     * @param value Vector
     * @return Vector met slides
     */

    public function get vectorSlides():Vector.<SlideVO> {
        return _vectorSlides;
    }

    public function set vectorSlides(value:Vector.<SlideVO>):void {
        if(_vectorSlides != value){
            _vectorSlides = value;
            dispatchEvent(new starling.events.Event(DATA_CHANGED));
        }
    }

    /**
     * Getter / Setter voor huidige slide
     *
     * @param value SlideVO
     * @return Huidige slide
     */

    public function get currentSlide():SlideVO {
        return _currentSlide;
    }

    public function set currentSlide(value:SlideVO):void {
        if(_currentSlide != value){
            _currentSlide = value;
            dispatchEvent(new starling.events.Event(SLIDE_CHANGED));
        }
    }

    /**
     * Huidige slide index opvragen
     *
     * @return uint
     */

    public function get currentIndex():uint {
        return _vectorSlides.indexOf(_currentSlide);
    }
}
}

/**
 * Internal klasse die gebruikt wordt om instantiering van de AppModel van buitenaf te vermijden
 */
internal class Enforcer{}