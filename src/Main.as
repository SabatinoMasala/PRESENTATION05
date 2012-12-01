package {

import be.devine.cp3.presentation.Presentation;
import be.devine.cp3.presentation.model.AppModel;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TransformGestureEvent;
import flash.geom.Rectangle;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;

import starling.core.Starling;

/**
 * Main
 *
 * Entry point voor applicatie
 */

public class Main extends Sprite {

    [Embed(source="/assets/slides.xml", mimeType="application/octet-stream")]
    public static const SlideXml:Class;

    private var _starling:Starling;
    private var _appModel:AppModel;

    /**
     * Zet de stage align en stage scalemode juist
     */
    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        init();

        stage.addEventListener(Event.RESIZE, resizeHandler);
    }

    private function swipeHandler(event:TransformGestureEvent):void {
        switch (event.offsetX){
            case 1:
                trace("rechts");
                break;
            case -1:
                trace("links");
                break;
        }
    }

    /**
     * Zal een nieuwe Starling instantie aanmaken & starten
     *
     * @private
     */
    private function init():void{
        _starling = new Starling(Presentation, stage);
        _starling.start();
    }

    /**
     * Verantwoordelijk voor de resize functionaliteit van de applicatie
     *
     * @param event flash.events.Event
     * @private
     */
    private function resizeHandler(event:Event = null):void {

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