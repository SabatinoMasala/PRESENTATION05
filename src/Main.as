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

        stage.addEventListener(Event.RESIZE, resizeHandler);
    }

    private function init():void{
        _starling = new Starling(Presentation, stage);
        _starling.start();
    }

    private function resizeHandler(event:Event):void {
        var rect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _starling.viewPort = rect;

        _starling.stage.stageWidth = stage.stageWidth;
        _starling.stage.stageHeight = stage.stageHeight;
    }
}
}