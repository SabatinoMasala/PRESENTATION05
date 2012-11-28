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

public class Presentation extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _dataParser:DataParser;

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
        _dataParser = new DataParser();
        _appModel.xmlPath = "assets/slides.xml";
    }

    private function xmlChangedHandler(event:starling.events.Event):void {
        _dataParser.parse(_appModel.xmlPath);
    }

    public function resize(w:Number, h:Number):void{

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
