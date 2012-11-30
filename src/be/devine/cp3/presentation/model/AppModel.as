/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:26
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.model {
import be.devine.cp3.presentation.SlideVO;

import starling.events.Event;

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
    private var _xmlPath:String;

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
            // Er is een volgende
            currentSlide = _vectorSlides[this.currentIndex+1];
            dispatchEvent(new Event(SLIDE_CHANGED));
        }
    }

    public function goToPrev():void{

        if(this.currentIndex > 0){
            //er is een vorige
            currentSlide = _vectorSlides[this.currentIndex-1];
            dispatchEvent(new Event(SLIDE_CHANGED));
        }
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

    public function get xmlPath():String {
        return _xmlPath;
    }

    public function set xmlPath(value:String):void {
        if(_xmlPath != value){
            _xmlPath = value;
            dispatchEvent(new starling.events.Event(XML_CHANGED));
        }
    }

    public function get vectorSlides():Vector.<SlideVO> {
        return _vectorSlides;
    }

    public function set vectorSlides(value:Vector.<SlideVO>):void {
        if(_vectorSlides != value){
            _vectorSlides = value;
            dispatchEvent(new Event(DATA_CHANGED));
        }
    }

    public function get currentSlide():SlideVO {
        return _currentSlide;
    }

    public function set currentSlide(value:SlideVO):void {
        if(_currentSlide != value){
            _currentSlide = value;
            dispatchEvent(new Event(SLIDE_CHANGED));
        }
    }

    public function get currentIndex():uint {
        return _vectorSlides.indexOf(_currentSlide);
    }
}
}

// Singleton enforcer
internal class Enforcer{}