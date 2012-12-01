/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.model.AppModel;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.textures.Texture;

public class MenuControlView extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _container:Sprite = new Sprite();
    private var _tween:Tween;

    //Constructor
    public function MenuControlView() {
        trace("[MenuControlView] Construct");
        _appModel = AppModel.getInstance();

        _appModel.addEventListener(AppModel.MENU_STATE_CHANGED, display);

        addChild(_container);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function display(event:Event):void{
        trace("[MenuControlView] Animating menu ", _appModel.menuVisible);

        if(_appModel.menuVisible){

            Starling.juggler.remove(_tween);

            _container.visible = true;
            _tween = new Tween(_container,.3, Transitions.EASE_OUT);
            _tween.animate("y", stage.stageHeight - _container.height);
            Starling.juggler.add(_tween);

        } else {

            Starling.juggler.remove(_tween);

            _tween = new Tween(_container,.3, Transitions.EASE_IN);
            _tween.animate("y", stage.stageHeight);
            _tween.onComplete = hide;
            Starling.juggler.add(_tween);

        }
    }

    private function hide():void {
        _container.visible = false;
    }

    public function resize(w:Number, h:Number):void{

        trace("[MenuController] resizing");

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
