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

import starling.display.Sprite;

public class MenuControlView extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;

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

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
    private function addedToStageHandler(e:flash.events.Event):void {
        stage.addEventListener(AppModel.MENU_STATE_CHANGED, display);
    }
}
}
