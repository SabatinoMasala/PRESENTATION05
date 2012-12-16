package {

import be.devine.cp3.presentation.utils.Utils;
import be.devine.cp3.presentation.view.Presentation;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Rectangle;
import flash.system.Capabilities;
import flash.ui.Keyboard;

import net.hires.debug.Stats;

import org.gestouch.core.Gestouch;

import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
import org.gestouch.extensions.starling.StarlingTouchHitTester;
import org.gestouch.input.NativeInputAdapter;

import starling.core.Starling;
import starling.display.DisplayObject;

[SWF(width="1024", height="768", frameRate="60")]

public class Main extends Sprite {

    private var _starling:Starling;
    private var _fullScreen:Boolean = false;

    public static var instance:Main;

    // Constructor
    public function Main() {

        instance = this;

        // Stage juist alignen en scalen
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        if(Capabilities.screenDPI == 264){
            Utils.multiplicationFactor = 2;
        }

        // Initializeren van applicatie
        init();

        // Resize event koppelen aan stage
        stage.addEventListener(Event.RESIZE, resizeHandler);

        addChild(new Stats());
    }

    private function init():void{
        // Starling instantie aanmaken
        _starling = new Starling(Presentation, stage);

        // Gestures voor iPad
        Gestouch.inputAdapter ||= new NativeInputAdapter(stage);
        Gestouch.addDisplayListAdapter(DisplayObject, new StarlingDisplayListAdapter());
        Gestouch.addTouchHitTester(new StarlingTouchHitTester(_starling), -1);

        // Starling starten
        _starling.start();
    }

    private function resizeHandler(event:Event = null):void {

        // Rectangle aanmaken voor viewport van starling
        var rect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _starling.viewPort = rect;

        // Starling stage width en height juist instellen
        _starling.stage.stageWidth = stage.stageWidth;
        _starling.stage.stageHeight = stage.stageHeight;

        // Als Starling de rootklasse heeft aangemaakt, zullen we deze ook resizen
        if(Starling.current.stage.numChildren !== 0){
            var p:Presentation = Starling.current.stage.getChildAt(0) as Presentation;
            p.resize(stage.stageWidth, stage.stageHeight);
        };
    }

    public function get fullScreen():Boolean {
        return _fullScreen;
    }

    public function set fullScreen(value:Boolean):void {
        if(value){
            stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        }
        else{
            stage.displayState = StageDisplayState.NORMAL;
        }
        _fullScreen = value;
    }
}
}