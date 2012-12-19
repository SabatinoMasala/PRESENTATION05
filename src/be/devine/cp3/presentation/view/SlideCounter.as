/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 16/12/12
 * Time: 14:21
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.model.AppModel;
import be.devine.cp3.presentation.utils.Utils;

import flash.sampler.getSavedThis;

import starling.animation.Tween;
import starling.core.Starling;

import starling.events.Touch;

import starling.events.TouchEvent;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class SlideCounter extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _bg:Quad;
    private var _tf:TextField;
    private var _appModel:AppModel;
    private var _container:Sprite;
    private var _transparantNum:Number = .3;

    //Constructor
    public function SlideCounter() {

        _container = new Sprite();

        // Achtergrondje
        _bg = new Quad(100*Utils.multiplicationFactor, 50*Utils.multiplicationFactor, 0x444444);
        _container.addChild(_bg);

        // Tekstveldje
        _tf = new TextField(_bg.width - 10, _bg.height, "", "Bebas Neue", 24 * Utils.multiplicationFactor, 0xFFFFFF);
        _tf.hAlign = HAlign.CENTER;
        _tf.vAlign = VAlign.CENTER;
        _tf.x = 5;
        _tf.autoScale = true;
        _container.addChild(_tf);

        addChild(_container);

        _container.alpha = _transparantNum;

        _container.addEventListener(TouchEvent.TOUCH, touchHandler);

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.SLIDE_CHANGED, slideChangedHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function slideChangedHandler(event:Event):void {
        _tf.text = (_appModel.currentIndex+1)+" van "+_appModel.vectorSlides.length;
    }

    // Infaden bij hover
    private function touchHandler(event:starling.events.TouchEvent):void {
        var t:Touch = event.getTouch(stage);
        var tw:Tween = new Tween(_container, .5);
        if(event.getTouch(_container, TouchPhase.HOVER) || event.getTouch(_container, TouchPhase.BEGAN) || event.getTouch(_container, TouchPhase.ENDED)){
            if(t.phase == TouchPhase.ENDED && Utils.device == Utils.IPAD){
                tw.animate("alpha", _transparantNum);
                Starling.juggler.add(tw);
            }
            else{
                tw.animate("alpha", 1)
                Starling.juggler.add(tw);
            }
        }
        else{
            tw.animate("alpha", _transparantNum);
            Starling.juggler.add(tw);
        }
    }
}
}
