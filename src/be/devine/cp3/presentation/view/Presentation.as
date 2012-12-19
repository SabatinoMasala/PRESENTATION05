package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.model.AppModel;
import be.devine.cp3.presentation.services.SlideService;
import be.devine.cp3.presentation.utils.Transition;
import be.devine.cp3.presentation.utils.Utils;

import com.adobe.images.PNGEncoder;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.StageDisplayState;
import flash.events.TimerEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Matrix;
import flash.ui.Keyboard;
import flash.utils.ByteArray;
import flash.utils.Timer;

import org.gestouch.events.GestureEvent;
import org.gestouch.gestures.SwipeGesture;
import org.gestouch.gestures.SwipeGestureDirection;
import org.gestouch.gestures.TapGesture;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.textures.Texture;

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
    private var _slideCounter:SlideCounter;

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

        if(Main.GENERATE_THUMBS){
            Transition.TIME = 0;
            _slideView.visible  = false;
            _appModel.addEventListener(AppModel.SLIDE_CHANGED, slideChangedHandler);
            return;
        }

        // We moeten de stage kunnen aanspreken voor keyboardEvents, dus ADDED_TO_STAGE event koppelen aan this
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        _slideCounter = new SlideCounter();
        addChild(_slideCounter);

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

        // Double tap
        var tap:TapGesture = new TapGesture(_slideView);
        tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, tapHandler);
        tap.numTapsRequired = 2;

        // Swipe gestures voor ipad (swipen naar links)
        var swipeLeft:SwipeGesture = new SwipeGesture(_slideView);
        swipeLeft.addEventListener(GestureEvent.GESTURE_RECOGNIZED, gestureHandler);
        swipeLeft.direction = SwipeGestureDirection.LEFT;

        // Swipe gestures voor ipad (swipen naar rechts)
        var swipeRight:SwipeGesture = new SwipeGesture(_slideView);
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
            case Keyboard.F:
                    Main.instance.fullScreen = (Main.instance.stage.displayState == StageDisplayState.NORMAL);
                break;
            case Keyboard.D:
                    Main.instance.debugMode = !Main.instance.debugMode;
                break;
        }
    }

    // Initializeren van de applicatie => xml inladen
    private function init():void {
        var service:SlideService = new SlideService();
        service.load();
    }

    private function tapHandler(event:GestureEvent):void {
        var t:TapGesture = event.currentTarget as TapGesture;
        _appModel.goToNext();
    }

    // Resize functionaliteit
    public function resize(w:Number, h:Number):void {

        _slideCounter.x = w - _slideCounter.width - 20;
        _slideCounter.y = 20;

        _menuControlView.resize(w, h);

        _slideView.resize(w, h);

    }

    private function slideChangedHandler(event:Event):void {

        var t:Timer = new Timer(100,1);
        t.start();
        t.addEventListener(TimerEvent.TIMER_COMPLETE, tHandler);

        trace("Converting slide "+(_appModel.currentIndex+1)+" from "+_appModel.vectorSlides.length)

    }

    private function tHandler(e:flash.events.TimerEvent):void {

        var bd:BitmapData = Utils.copyAsBitmapData(_slideView.currentSlideDisplayObject);
        var bitmap:Bitmap = new Bitmap(bd);

        var bd:BitmapData = new BitmapData(200, 150, false);
        var m:Matrix = new Matrix();
        m.scale(.195, .195);
        bd.draw(bitmap, m);

        var bA:ByteArray = PNGEncoder.encode(bd);

        var f:File = File.desktopDirectory.resolvePath("presentation-files/"+_appModel.currentIndex+".png");
        var fs:FileStream = new FileStream();
        fs.open(f, FileMode.WRITE);
        fs.writeBytes(bA);
        fs.close();

        bitmap = null;
        bd.dispose();
        bd = null;

        _appModel.goToNext();
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
