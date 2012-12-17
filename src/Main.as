package {

import be.devine.cp3.presentation.utils.Utils;
import be.devine.cp3.presentation.view.Presentation;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.system.Capabilities;

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
    private var _debugMode:Boolean = false;
    private var _stats:Stats;

    public static var instance:Main;

    // Constructor
    public function Main() {

        debugMode = true;

        instance = this;

        // Stage juist alignen en scalen
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        // iPad met retina
        if(Capabilities.screenDPI == 264){
            Utils.device = Utils.IPAD;
            Utils.multiplicationFactor = 2;
        }

        // iPad zonder retina
        if(Capabilities.screenResolutionY == 1024){
            Utils.device = Utils.IPAD;
        }

        // Initializeren van applicatie
        init();

        // Resize event koppelen aan stage
        stage.addEventListener(Event.RESIZE, resizeHandler);
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

    public function get debugMode():Boolean{
        return _debugMode;
    }

    public function set debugMode(val:Boolean):void{
        if(val != _debugMode){
            _debugMode = val;
            if(_debugMode){
                _stats = new Stats();
                addChild(_stats);
            }
            else{
                removeChild(_stats);
                _stats = null;
            }
        }
    }
}
}