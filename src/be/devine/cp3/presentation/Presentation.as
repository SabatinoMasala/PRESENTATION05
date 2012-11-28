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

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import starling.display.Sprite;

public class Presentation extends starling.display.Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;

    //Constructor
    public function Presentation() {
        trace("[Presentation] Construct");
        _appModel = AppModel.getInstance();
        this.addEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:flash.events.Event):void {
        stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, key_down);
    }

    private function key_down(event:KeyboardEvent):void {
        if(event.keyCode == Keyboard.SPACE){
            //Appmodel aanpassen
        }
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function resize(w:Number, h:Number):void{

    }


    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
