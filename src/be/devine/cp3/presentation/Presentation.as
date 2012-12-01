/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 23/11/12
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.model.AppModel;
import be.devine.cp3.presentation.view.MenuControlView;
import be.devine.cp3.presentation.view.SlideView;

import flash.ui.Keyboard;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

/**
 * Presentation
 *
 * Klasse die door Starling als root-class gebruikt zal worden.
 * Dit zal de container van de presentation engine zijn.
 */

public class Presentation extends Sprite implements IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _slideView:SlideView;
    private var _menuControlView:MenuControlView;

    //Constructor

    /**
     * Instantieren van FontContainer, SlideView en MenuControlView
     */

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

    /**
     * Stage is beschikbaar dus koppelen we een KeyboardEvent aan de stage
     * @param event Event
     */

    private function addedToStageHandler(event:Event):void {

        resize(stage.stageWidth, stage.stageHeight);

        stage.addEventListener(KeyboardEvent.KEY_UP, keyDownHandler);
        // Touch event aan stage koppelen
    }

    /**
     * KeyDownHandler checkt op keyCode van de ingedrukte toets, en roept de nodige method op in de AppModel
     * @param event KeyboardEvent
     */

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

    /**
     * Initializeren van de applicatie -> xml inladen in AppModel
     */

    private function init():void {
        _appModel.load("assets/slides.xml");
    }

    /**
     * Resize functie zal in MenuControlView & SlideView de resize() functie oproepen
     * @param w Number (stage.stageWidth)
     * @param h Number (stage.StageHeight)
     */

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
