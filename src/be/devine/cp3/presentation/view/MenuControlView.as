/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.model.AppModel;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.text.TextField;

public class MenuControlView extends Sprite implements IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _container:Sprite;
    private var _tween:Tween;
    private var _menuStateChanged:Boolean;
    private var _menuBg:Quad;
    private var _buttonContainer;

    //Constructor
    public function MenuControlView() {
        _appModel = AppModel.getInstance();

        _container = new Sprite();
        addChild(_container);

        _menuBg = new Quad(100, 200, 0x444444);
        _container.addChild(_menuBg);

        _buttonContainer = new Sprite();
        _container.addChild(_buttonContainer);
        var q:Quad = new Quad(100, 35, 0x444444);
        _buttonContainer.addChild(q);
        var tf:TextField = new TextField(q.width, q.height, "Menu", "Bebas Neue", 20, 0xFFFFFF);
        _buttonContainer.addChild(tf);
        _buttonContainer.y = -_buttonContainer.height;
        _buttonContainer.addEventListener(TouchEvent.TOUCH, buttonTouch);

        _appModel.addEventListener(AppModel.MENU_STATE_CHANGED, menuStateChangedHandler);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function display():void{

        if(_menuStateChanged){
            _menuStateChanged = false;

            if(_appModel.menuVisible){

                Starling.juggler.remove(_tween);

                _tween = new Tween(_container, .3, Transitions.EASE_OUT);
                _tween.animate("y", stage.stageHeight - (_container.height - _buttonContainer.height));
                Starling.juggler.add(_tween);

            } else {

                Starling.juggler.remove(_tween);

                _tween = new Tween(_container, .3, Transitions.EASE_OUT);
                _tween.animate("y", stage.stageHeight);
                Starling.juggler.add(_tween);

            }
        }

    }

    private function buttonTouch(event:starling.events.TouchEvent):void {
        var t:Touch = event.getTouch(stage);
        if(t.phase == starling.events.TouchPhase.ENDED){
            _appModel.menuVisible = !_appModel.menuVisible;
        }
    }

    public function resize(w:Number, h:Number):void{

        _menuBg.width = w;
        _container.y = h;

        _buttonContainer.x = w - _buttonContainer.width - 35;

    }

    private function menuStateChangedHandler(event:Event):void {
        _menuStateChanged = true;
        display();
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
