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

public class MenuControlView extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _container:Sprite = new Sprite();

    //Constructor
    public function MenuControlView() {
        trace("[MenuControlView] Construct");
        _appModel = AppModel.getInstance();

        this.addEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function display(event:flash.events.Event):void{
        if(_appModel.menuVisible == true){
            var t:Tween = new Tween(_container, 1);
            t.animate("y", stage.stageHeight);
            Starling.juggler.add(t);
        } else {
            var t:Tween = new Tween(_container, 1);
            t.animate("y", stage.stageHeight - 100);
            Starling.juggler.add(t);
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
    private function addedToStageHandler(e:flash.events.Event):void {
        stage.addEventListener(AppModel.MENU_STATE_CHANGED, display);

        var background:Quad = new Quad(stage.stageWidth, 100);
        background.color = 0x000000;

        _container.addChild(background);
        stage.addChild(_container);

        _container.y = stage.stageHeight;
    }
}
}
