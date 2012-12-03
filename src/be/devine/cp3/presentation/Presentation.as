/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 23/11/12
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.model.AppModel;
import be.devine.cp3.presentation.view.MenuControlView;
import be.devine.cp3.presentation.view.SlideView;

import flash.ui.Keyboard;

import org.gestouch.events.GestureEvent;
import org.gestouch.gestures.SwipeGesture;
import org.gestouch.gestures.SwipeGestureDirection;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

/**
 * Presentation
 *
 * Klasse die door Starling als root-class gebruikt zal worden.
 * Dit zal de container van de presentation engine zijn.
 */

public class Presentation extends Sprite implements IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _slideView:SlideView;
    private var _menuControlView:MenuControlView;

    //Constructor
    public function Presentation() {

        // Fontcontainer instantieren voor custom fonts (zie fonts.fla)
        var fc:FontContainer = new FontContainer();

        // Appmodel instantie opslaan in private var
        _appModel = AppModel.getInstance();

        // Slideview instantie aanmaken
        _slideView = new SlideView();

        // MenuControlView instantie aanmaken
        _menuControlView = new MenuControlView();

        addChild(_slideView);
        addChild(_menuControlView);

        // Initializeren van slideshow
        init();

        // We moeten de stage kunnen aanspreken voor keyboardEvents, dus ADDED_TO_STAGE event koppelen aan this
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    // stage is beschikbaar in deze functie
    private function addedToStageHandler(event:Event):void {

        // Resize functie oproepen
        resize(stage.stageWidth, stage.stageHeight);

        // KEY_UP KeyboardEvent koppelen aan stage
        stage.addEventListener(KeyboardEvent.KEY_UP, keyDownHandler);

        // Swipe gestures voor ipad (swipen naar links)
        var swipeLeft:SwipeGesture = new SwipeGesture(stage);
        swipeLeft.addEventListener(GestureEvent.GESTURE_RECOGNIZED, gestureHandler);
        swipeLeft.direction = SwipeGestureDirection.LEFT;

        // Swipe gestures voor ipad (swipen naar rechts)
        var swipeRight:SwipeGesture = new SwipeGesture(stage);
        swipeRight.addEventListener(GestureEvent.GESTURE_RECOGNIZED, gestureHandler);
        swipeRight.direction = SwipeGestureDirection.RIGHT;

        // Swipe gestures voor ipad (swipen naar omhoog met 2 vingers)
        var menuSwipe:SwipeGesture = new SwipeGesture(stage);
        menuSwipe.addEventListener(GestureEvent.GESTURE_RECOGNIZED, gestureHandler);
        menuSwipe.direction = SwipeGestureDirection.UP;
        menuSwipe.numTouchesRequired = 2;

        // Swipe gestures voor ipad (swipen naar omlaag met 2 vingers)
        var menuHideSwipe:SwipeGesture = new SwipeGesture(stage);
        menuHideSwipe.addEventListener(GestureEvent.GESTURE_RECOGNIZED, gestureHandler);
        menuHideSwipe.direction = SwipeGestureDirection.DOWN;
        menuHideSwipe.numTouchesRequired = 2;

    }

    // Checken welke gesture uitgevoerd werd
    private function gestureHandler(e:GestureEvent):void {
        var s:SwipeGesture = e.currentTarget as SwipeGesture;
        switch (s.direction){
            case SwipeGestureDirection.LEFT:
                    _appModel.goToNext();
                break;
            case SwipeGestureDirection.RIGHT:
                    _appModel.goToPrev();
                break;
            case SwipeGestureDirection.UP:
                _appModel.menuVisible = true;
                break;
            case SwipeGestureDirection.DOWN:
                _appModel.menuVisible = false;
                break;
        }
    }

    // Keydownhandler checkt welke toets de gebruiker heeft ingeduwd, en roept eventueel de nodige functies op uit de AppModel
    private function keyDownHandler(event:KeyboardEvent):void {
        switch (event.keyCode){
            case Keyboard.SPACE:
                    _appModel.menuVisible = !_appModel.menuVisible;
                break;
            case Keyboard.LEFT:
                    _appModel.goToPrev();
                break;
            case Keyboard.RIGHT:
                    _appModel.goToNext();
                break;
        }
    }

    // Initializeren van de applicatie => xml inladen
    private function init():void {
        var xmlClass:Class = Main.SlideXml;
        var xml:XML = new XML(new xmlClass());
        _appModel.parse(xml);
    }


    // Resize functionaliteit
    public function resize(w:Number, h:Number):void {

        _menuControlView.resize(w, h);
        _slideView.resize(w, h);

    }



    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
