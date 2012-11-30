/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.View {
import be.devine.cp3.presentation.model.AppModel;

import flash.events.Event;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;

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

        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function display(event:starling.events.Event):void{
        trace("[MenuControlView] Animating menu ", _appModel.menuVisible);

        if(_appModel.menuVisible){

            Starling.juggler.remove(_tween);

            _container.visible = true;
            _tween = new Tween(_container,.3, starling.animation.Transitions.EASE_OUT);
            _tween.animate("y", stage.stageHeight - _container.height);
            Starling.juggler.add(_tween);

        } else {

            Starling.juggler.remove(_tween);

            _tween = new Tween(_container,.3, starling.animation.Transitions.EASE_IN);
            _tween.animate("y", stage.stageHeight);
            _tween.onComplete = hide;
            Starling.juggler.add(_tween);

        }
    }

    private function hide():void {
        _container.visible = false;
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
    private function addedToStageHandler(e:starling.events.Event):void {
        _appModel.addEventListener(AppModel.MENU_STATE_CHANGED, display);

        var background:Quad = new Quad(stage.stageWidth, 100);
        background.color = 0x000000;

        _container.addChild(background);
        stage.addChild(_container);

        _container.y = stage.stageHeight;
    }
}
}
