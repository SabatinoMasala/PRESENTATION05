/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 23/11/12
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import be.devine.cp3.presentation.View.MenuControlView;
import be.devine.cp3.presentation.View.SlideView;
import be.devine.cp3.presentation.model.AppModel;

import flash.ui.Keyboard;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

public class Presentation extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _dataParser:DataParser;
    private var _slideView:SlideView;
    private var _menuControlView:MenuControlView;

    //Constructor
    public function Presentation() {
        trace("[Presentation] Construct");
        _appModel = AppModel.getInstance();
        _slideView = new SlideView();
        _menuControlView = new MenuControlView();

        addChild(_slideView);
        addChild(_menuControlView);

        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        init();
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function addedToStageHandler(event:starling.events.Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
    }

    private function keyDownHandler(event:KeyboardEvent):void {
        if(event.keyCode == Keyboard.SPACE)
        {
            _appModel.menuVisible = !_appModel.menuVisible;
        } else if (event.keyCode == Keyboard.RIGHT){
            _appModel.goToNext();
        } else if (event.keyCode == Keyboard.LEFT){
           _appModel.goToPrev();
        }
    }

    private function init():void {
        _dataParser = new DataParser();
        _appModel.xmlPath = "assets/slides.xml";
    }

    private function startPresentation():void{
        trace("starting presentation");
    }

    public function resize(w:Number, h:Number):void{

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
