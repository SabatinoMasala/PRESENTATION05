/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 09/12/12
 * Time: 16:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.Slide;
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.model.AppModel;
import be.devine.cp3.presentation.slideVO.SlideVO;

import flash.events.TimerEvent;

import flash.geom.Rectangle;
import flash.utils.Timer;

import starling.core.RenderSupport;
import starling.core.Starling;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class ThumbnailView extends Sprite implements IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _vectorThumbs:Vector.<Slide>;

    public var dimensions:Rectangle;

    //Constructor
    public function ThumbnailView(width:Number, height:Number) {

        dimensions = new Rectangle(0, 0, width, height);

        _vectorThumbs = new Vector.<Slide>();

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.DATA_CHANGED, dataChangedHandler);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function dataChangedHandler(event:Event):void {
        // Even uitstellen van aanmaken thumbs voor performance
        var t:Timer = new Timer(500, 1);
        t.start();
        t.addEventListener(TimerEvent.TIMER_COMPLETE, create);
    }

    private function create(e:TimerEvent):void {
        _appModel.removeEventListener(AppModel.SLIDE_CHANGED, create);
        var tempVector:Vector.<Slide> = new Vector.<Slide>();
        // Door de Vectors in AppModel lussen en slides aanmaken
        var xPos:uint = 0;
        for each(var slideVO:SlideVO in _appModel.vectorSlides){
            var s:Slide = new Slide(slideVO);
            tempVector.push(s);
            s.construct();
            s.x = xPos;
            addChild(s);
            s.resize(stage.stageWidth, stage.stageHeight);
            s.width = dimensions.width;
            s.height = dimensions.height;
            xPos += s.width + 10;
            s.addEventListener(TouchEvent.TOUCH, touchHandler);
            s.useHandCursor = true;
        }
        _vectorThumbs = tempVector;
        _appModel.addEventListener(AppModel.SLIDE_CHANGED, slideChangedHandler);
        slideChangedHandler();
    }

    private function touchHandler(event:TouchEvent):void {
        var t:Touch = event.getTouch(stage) as Touch;
        if(t.phase == TouchPhase.ENDED){
            _appModel.currentSlide = _appModel.vectorSlides[(getChildIndex(event.currentTarget as Sprite))];
        }
    }

    public function resize(w:Number, h:Number):void{
    }

    private function slideChangedHandler(event:Event = null):void {
        for each(var s:Slide in _vectorThumbs){
            if(getChildIndex(s) == _appModel.currentIndex){
                s.alpha = 1;
            }
            else{
                s.alpha = .4;
            }
        }
    }


    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
