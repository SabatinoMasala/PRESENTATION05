/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 19/12/12
 * Time: 15:02
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class Slider extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public static const SLIDER_VALUE_CHANGED:String = "sliderValueChanged";

    private var _handle:Quad;
    private var _track:Quad;
    private var _percentage:Number = 0;
    private var _handleTween:Tween;

    //Constructor
    public function Slider() {
        // Track tekenen
        _track = new Quad(1, 6, 0xFFFFFF);
        _track.alpha = .3;
        _track.y = 4;
        addChild(_track);

        // Handle tekenen
        _handle = new Quad(16, 16, 0xFFFFFF);
        _handle.useHandCursor = true;
        addChild(_handle);
        _handle.pivotX = 8;

        _handle.addEventListener(TouchEvent.TOUCH, touchHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    // Checken of de muis wordt losgelaten of ingeduwd
    private function touchHandler(e:TouchEvent):void {
        var t:Touch = e.getTouch(stage);
        if(t.phase == TouchPhase.BEGAN){
            stage.addEventListener(TouchEvent.TOUCH, dragHandler);
        }
        else if(t.phase == TouchPhase.ENDED){
            stage.removeEventListener(TouchEvent.TOUCH, dragHandler);
        }
    }

    // Drag functionaliteit
    private function dragHandler(e:TouchEvent):void {
        var t:Touch = e.getTouch(stage);
        var newXpos:Number = t.globalX - this.x;
        if(newXpos > _track.width){
            _handle.x = _track.width;
        }
        else if(newXpos < 0){
            _handle.x = 0;
        }
        else{
            _handle.x = newXpos;
        }
        pct = _handle.x / (_track.width);
    }

    // Dispatchen
    private function dispatch():void{
        dispatchEvent(new Event(Slider.SLIDER_VALUE_CHANGED));
    }

    // Value updaten zonder te dispatchen
    public function updateValue(value:Number):void{
        _percentage = value;
        _handleTween = new Tween(_handle, .3, Transitions.EASE_OUT);
        _handleTween.animate("x", _percentage * _track.width);
        Starling.juggler.add(_handleTween);
    }

    public function resize(w:Number, h:Number):void{
        _track.width = w;
        _handle.x = _percentage * _track.width;
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

    public function get pct():Number{
        return _percentage;
    }

    public function set pct(value:Number):void{
        if(value != _percentage){
            _percentage = value;
            dispatch();
        }
    }
}
}
