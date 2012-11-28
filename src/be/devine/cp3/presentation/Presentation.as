/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 23/11/12
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import be.devine.cp3.presentation.model.AppModel;

import flash.events.Event;
import flash.ui.Keyboard;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

public class Presentation extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;

    //Constructor
    public function Presentation() {
        trace("[Presentation] Construct");
        _appModel = AppModel.getInstance();
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
        
        _appModel.addEventListener(AppModel.XML_CHANGED, xmlChangedHandler);

        init();
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function addedToStageHandler(event:starling.events.Event):void {
        stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, keyDownHandler);
    }

    private function keyDownHandler(event:starling.events.KeyboardEvent):void {
        if(event.keyCode == Keyboard.SPACE)
        {
            _appModel.menuVisible = !_appModel.menuVisible;
        }
    }

    private function init():void {

    }

    private function xmlChangedHandler(event:starling.events.Event):void {
    }

    public function resize(w:Number, h:Number):void{

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
