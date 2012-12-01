package {

import be.devine.cp3.presentation.Presentation;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;

[SWF(width=800, height=600, frameRate=60)]

public class Main extends Sprite {

    private var _starling:Starling;

    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        init();

        stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
    }

    private function init():void{
        _starling = new Starling(Presentation, stage);
        _starling.start();
    }

    private function resizeHandler(event:flash.events.Event = null):void {

        trace("[Main] resizing");

        var rect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _starling.viewPort = rect;

        _starling.stage.stageWidth = stage.stageWidth;
        _starling.stage.stageHeight = stage.stageHeight;

        if(Starling.current.stage.numChildren !== 0){
            var p:Presentation = Starling.current.stage.getChildAt(0) as Presentation;
            p.resize(stage.stageWidth, stage.stageHeight);
        };
    }
}
}