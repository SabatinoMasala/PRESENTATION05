/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 09/12/12
 * Time: 16:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.view.Slide;
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
    private var _vectorThumbs:Vector.<Thumb>;
    private var _currentSelected:int = -1;

    public var dimensions:Rectangle;

    //Constructor
    public function ThumbnailView(width:Number, height:Number) {

        dimensions = new Rectangle(0, 0, width, height);

        _vectorThumbs = new Vector.<Thumb>();

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.SLIDE_CHANGED, slideChangedHandler)
        _appModel.addEventListener(AppModel.DATA_CHANGED, generateThumbs);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function slideChangedHandler(e:Event):void {
        if(_currentSelected != -1){
            _vectorThumbs[_currentSelected].selected = false;
        }
        _currentSelected = _appModel.currentIndex;
        select();
    }

    private function select():void {
        _vectorThumbs[_currentSelected].selected = true;
    }

    private function generateThumbs(e:Event):void {
        //var xPos:uint = (stage.stageWidth>>1) - (dimensions.width+10);
        var xPos:uint = 5;
        var num:uint = 0;
        for(var i:uint = 0; i<_appModel.vectorSlides.length; i++){
            var t:Thumb = new Thumb(dimensions, num++);
            t.x = xPos;
            xPos += t.width + 10;
            addChild(t);
            t.useHandCursor = true;
            _vectorThumbs.push(t);
            t.addEventListener(TouchEvent.TOUCH, touchHandler);
        }
    }

    private function touchHandler(e:TouchEvent):void {
        var t:Touch = e.getTouch(stage);
        if(t){
            if(t.phase == TouchPhase.ENDED){
                var thumb:Thumb = e.currentTarget as Thumb;
                var index:uint = _vectorThumbs.indexOf(thumb);
                _appModel.currentSlide = _appModel.vectorSlides[index];
            }
        }
    }

    public function resize(w:Number, h:Number):void {

    }


    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}