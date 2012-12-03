package {

import be.devine.cp3.presentation.Presentation;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import org.gestouch.core.Gestouch;

import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
import org.gestouch.extensions.starling.StarlingTouchHitTester;
import org.gestouch.input.NativeInputAdapter;

import starling.core.Starling;
import starling.display.DisplayObject;

public class Main extends Sprite {

    [Embed(source="/assets/slides.xml", mimeType="application/octet-stream")]
    public static const SlideXml:Class;

    private var _starling:Starling;

    // Constructor
    public function Main() {

        // Stage juist alignen en scalen
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

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
        Gestouch.addDisplayListAdapter(starling.display.DisplayObject, new StarlingDisplayListAdapter());
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

}
}