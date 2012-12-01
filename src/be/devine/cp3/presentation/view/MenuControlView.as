/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.model.AppModel;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.textures.Texture;

public class MenuControlView extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _container:Sprite = new Sprite();
    private var _tween:Tween;

    private var imageBoxTexture:BitmapData;
    private var texture:Texture;
    private var background:Image;

    private var _btnLeft:Image;
    private var _btnRight:Image;

    //Constructor
    public function MenuControlView() {
        trace("[MenuControlView] Construct");
        _appModel = AppModel.getInstance();

        _appModel.addEventListener(AppModel.MENU_STATE_CHANGED, display);

        texture = Texture.fromBitmap(new Bitmap(new ImageBox()));
        texture.repeat = true;

        background = new Image(texture);
        _container.addChild(background);

        var btnL:Bitmap = new Bitmap(new BtnLeft());
        _btnLeft = Image.fromBitmap(btnL);
        _btnLeft.y = (background.height>>1) - (_btnLeft.height>>1);
        _btnLeft.x = 50;
        _container.addChild(_btnLeft);

        var btnR:Bitmap = new Bitmap(new BtnRight());
        _btnRight = Image.fromBitmap(btnR);
        _btnRight.y = (background.height>>1) - (_btnRight.height>>1);
        _container.addChild(_btnRight);

        _btnLeft.addEventListener(TouchEvent.TOUCH, touchHandler);
        _btnRight.addEventListener(TouchEvent.TOUCH, touchHandler);

        addChild(_container);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function touchHandler(event:TouchEvent):void {
        var t:Touch = event.getTouch(stage);
        if(t.phase == starling.events.TouchPhase.ENDED){
            if(event.currentTarget == _btnLeft){
                _appModel.goToPrev();
            }
            else if(event.currentTarget == _btnRight){
                _appModel.goToNext();
            }
        }
    }

    public function display(event:Event):void{
        trace("[MenuControlView] Animating menu ", _appModel.menuVisible);

        if(_appModel.menuVisible){

            Starling.juggler.remove(_tween);

            _container.visible = true;
            _tween = new Tween(_container,.3, Transitions.EASE_OUT);
            _tween.animate("y", stage.stageHeight - _container.height);
            Starling.juggler.add(_tween);

        } else {

            Starling.juggler.remove(_tween);

            _tween = new Tween(_container,.3, Transitions.EASE_IN);
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

        public function resize(w:Number, h:Number):void{

            trace("[MenuController] resizing");

            background.width = w;
            background.setTexCoords(1,new Point(w/324,0));
            background.setTexCoords(2,new Point(0,1));
            background.setTexCoords(3,new Point(w/324,1));

            _btnRight.x = w - _btnRight.width - 50;

            if(_appModel.menuVisible){
                _container.y = h - _container.height;
            } else {
                _container.y = h;
            }
        }
}
}
