/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 23/11/12
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import be.devine.cp3.presentation.model.AppModel;
import be.devine.cp3.presentation.view.MenuControlView;
import be.devine.cp3.presentation.view.SlideView;

import flash.ui.Keyboard;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

public class Presentation extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _slideView:SlideView;
    private var _menuControlView:MenuControlView;

    //Constructor
    public function Presentation() {

        trace("[Presentation] Construct");

        var fc:FontContainer = new FontContainer();
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

    private function addedToStageHandler(event:Event):void {

        resize(stage.stageWidth, stage.stageHeight);

        stage.addEventListener(KeyboardEvent.KEY_UP, keyDownHandler);
        // Touch event aan stage koppelen
    }

    private function keyDownHandler(event:KeyboardEvent):void {
        switch (event.keyCode){
            case Keyboard.SPACE:
                    _appModel.menuVisible = !_appModel.menuVisible;
                break;
            case Keyboard.LEFT:
                    _appModel.goToPrev();
                break;
            case Keyboard.RIGHT:
                    _appModel.goToNext();
                break;
        }
    }

    private function init():void {
        _appModel.load("assets/slides.xml");
    }

    public function resize(w:Number, h:Number):void {
        trace("[Presentation] resizing");
        _menuControlView.resize(w, h);
        _slideView.resize(w, h);
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
