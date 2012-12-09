package be.devine.cp3.presentation.model {
import be.devine.cp3.presentation.SlideVO;

import starling.events.Event;
import starling.events.EventDispatcher;

public class AppModel extends EventDispatcher {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public static const DATA_CHANGED:String = "dataChanged";
    public static const MENU_STATE_CHANGED:String = "menuStringChanged";
    public static const SLIDE_CHANGED:String = "slideChanged";
    public static const LEFT:String = "left";
    public static const RIGHT:String = "right";

    private var _vectorSlides:Vector.<SlideVO>;
    private var _menuVisible:Boolean = false;
    private var _currentIndex:uint;
    private var _currentSlide:SlideVO;
    private var _direction:String;

    private static var _instance:AppModel;

    // Instantieren van AppModel. Door een Enforcer te vragen als argument kan deze klasse niet van buitenaf worden aangemaakt.

    //Constructor
    public function AppModel(e:Enforcer) {
        if(e == null){
            throw new Error("Use .getInstance()");
        }
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    // Maakt een nieuwe instantie aan van AppModel als er nog geen bestaat en returnt hem.
    public static function getInstance():AppModel{
        if(_instance == null){
            _instance = new AppModel(new Enforcer());
        }
        return _instance;
    }

    // Checkt of er een volgende slide is en er naartoe gaat.
    public function goToNext():void{
        if(this.currentIndex < _vectorSlides.length - 1){
            direction = RIGHT;
            currentSlide = _vectorSlides[this.currentIndex+1];
        }
    }

    // Checkt of er een vorige slide is en er naartoe gaat.
    public function goToPrev():void{

        if(this.currentIndex > 0){
            direction = LEFT;
            currentSlide = _vectorSlides[this.currentIndex-1];
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

    // Getter en Setter voor zichtbaarheid van menu
    public function get menuVisible():Boolean {
        return _menuVisible;
    }

    // Zichtbaarheid van menu instellen
    public function set menuVisible(value:Boolean):void {
        if(_menuVisible != value){
            _menuVisible = value;

            //dispatchen
            dispatchEvent(new Event(MENU_STATE_CHANGED));
        }
    }

    // Getter & Setter voor de Vector met slides
    public function get vectorSlides():Vector.<SlideVO> {
        return _vectorSlides;
    }

    // TODO Slide objecten aanmaken ipv slidevo's

    public function set vectorSlides(value:Vector.<SlideVO>):void {
        if(_vectorSlides != value){
            _vectorSlides = value;
            dispatchEvent(new Event(DATA_CHANGED));
        }
    }

    // Getter / Setter voor huidige slide
    public function get currentSlide():SlideVO {
        return _currentSlide;
    }

    public function set currentSlide(value:SlideVO):void {
        if(_currentSlide != value){
            _currentSlide = value;
            dispatchEvent(new Event(SLIDE_CHANGED));
        }
    }

    // Huidige slide index opvragen
    public function get currentIndex():uint {
        return _vectorSlides.indexOf(_currentSlide);
    }

    // Richting ophalen & instellen ( voor transitions )
    public function get direction():String {
        return _direction;
    }

    public function set direction(value:String):void {
        _direction = value;
    }
}
}

/**
 * Internal klasse die gebruikt wordt om instantiering van de AppModel van buitenaf te vermijden
 */
internal class Enforcer{}