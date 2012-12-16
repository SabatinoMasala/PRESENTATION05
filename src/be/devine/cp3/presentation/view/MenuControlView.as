package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.utils.Utils;
import be.devine.cp3.presentation.view.Arrow;
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.model.AppModel;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.pixelmask.PixelMaskDisplayObject;
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
    private var _buttonContainer:starling.display.Sprite;
    private var _btnLeft:Arrow;
    private var _btnRight:Arrow;
    private var _thumbnailViewMaskDisplayObject:PixelMaskDisplayObject;
    private var _thumbnailViewMask:Quad;
    private var _arrowUnderlayLeft:Quad;
    private var _arrowUnderlayRight:Quad;

    //Constructor
    public function MenuControlView() {
        _appModel = AppModel.getInstance();

        // Container aanmaken die menu zal bevatten
        _container = new Sprite();
        addChild(_container);

        // Menu background tekenen (200 pixels hoog, breedte verandert met stageWidth)
        _menuBg = new Quad(1, 200*Utils.multiplicationFactor, 0x444444);
        _container.addChild(_menuBg);

        // Thumbnails aanmaken
        var thumbnailView:ThumbnailView = new ThumbnailView(200, 150);
        thumbnailView.y = (_menuBg.height>>1) - (thumbnailView.dimensions.height >> 1);

        _thumbnailViewMask = new Quad(1, 200*Utils.multiplicationFactor, 0xFF0000);

        _thumbnailViewMaskDisplayObject = new PixelMaskDisplayObject();
        _thumbnailViewMaskDisplayObject.addChild(thumbnailView);
        _thumbnailViewMaskDisplayObject.mask = _thumbnailViewMask;
        _thumbnailViewMaskDisplayObject.x = 100;
        _container.addChild(_thumbnailViewMaskDisplayObject);

        // Onzichtbare delen van mask blokkeren
        _arrowUnderlayLeft = new Quad(90*Utils.multiplicationFactor, 200*Utils.multiplicationFactor, 0xFFFFFF);
        _arrowUnderlayLeft.alpha = .1;
        _container.addChild(_arrowUnderlayLeft);

        _arrowUnderlayRight = new Quad(90*Utils.multiplicationFactor, 200*Utils.multiplicationFactor, 0xFFFFFF);
        _arrowUnderlayRight.alpha = .1;
        _container.addChild(_arrowUnderlayRight);

        // Handje als de gebruiker erover hovert
        _arrowUnderlayLeft.useHandCursor = true;
        _arrowUnderlayRight.useHandCursor = true;

        // Pijltjes
        _btnLeft = new Arrow(Arrow.LEFT);
        _btnRight = new Arrow(Arrow.RIGHT);

        // Addchilden & positioneren
        _container.addChild(_btnLeft);
        _container.addChild(_btnRight);
        _btnLeft.x = 20 * Utils.multiplicationFactor;
        _btnLeft.y = (_menuBg.height>>1) - (_btnLeft.height>>1);
        _btnRight.y = (_menuBg.height>>1) - (_btnRight.height>>1);

        _btnLeft.alpha = .5;
        _btnRight.alpha = .5;

        // Element non-touchable maken
        _btnLeft.touchable = false;
        _btnRight.touchable = false;

        // Event listeners
        _arrowUnderlayLeft.addEventListener(TouchEvent.TOUCH, leftButton);
        _arrowUnderlayRight.addEventListener(TouchEvent.TOUCH, rightButton);

        // ButtonContainer aanmaken (knopje waar "menu" op staat)
        _buttonContainer = new Sprite();
        _buttonContainer.useHandCursor = true;
        _container.addChild(_buttonContainer);

        // Blokje van 100x35 tekenen
        var q:Quad = new Quad(100*Utils.multiplicationFactor, 35*Utils.multiplicationFactor, 0x444444);
        _buttonContainer.addChild(q);
        // Tekstveldje toevoegen
        var tf:TextField = new TextField(q.width, q.height, "Menu", "Bebas Neue", 20*Utils.multiplicationFactor, 0xFFFFFF);
        _buttonContainer.addChild(tf);
        _buttonContainer.y = -_buttonContainer.height;
        _buttonContainer.addEventListener(TouchEvent.TOUCH, buttonTouch);

        _appModel.addEventListener(AppModel.MENU_STATE_CHANGED, menuStateChangedHandler);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    // Display functie
    public function display():void{

        // Menu state is veranderd
        if(_menuStateChanged){
            _menuStateChanged = false;

            // Het menu moet getoond worden
            if(_appModel.menuVisible){

                Starling.juggler.remove(_tween);

                _tween = new Tween(_container, .6, Transitions.EASE_OUT);
                _tween.animate("y", stage.stageHeight - (_container.height - _buttonContainer.height));
                Starling.juggler.add(_tween);

            }

            // Het menu moet moet verborgen worden
            else {

                Starling.juggler.remove(_tween);

                _tween = new Tween(_container, .6, Transitions.EASE_OUT);
                _tween.animate("y", stage.stageHeight);
                Starling.juggler.add(_tween);

            }
        }

    }

    // Geduwd op de menu knop
    private function buttonTouch(event:TouchEvent):void {
        var t:Touch = event.getTouch(stage);
        // Vergelijkbaar met MOUSE_UP
        if(t.phase == TouchPhase.ENDED){
            _appModel.menuVisible = !_appModel.menuVisible;
        }
    }

    // Resize functionaliteit
    public function resize(w:Number, h:Number):void{

        Starling.juggler.remove(_tween);

        _arrowUnderlayRight.x = w - _arrowUnderlayRight.width;

        _thumbnailViewMask.width = w-200;
        _thumbnailViewMaskDisplayObject.mask = _thumbnailViewMask;

        _btnRight.x = w - (_btnRight.width) - 20 * Utils.multiplicationFactor;

        // Breedte van menu moet stage.stageWidth worden
        _menuBg.width = w;
        // _container onderaan buiten scherm plaatsen
        if(!_appModel.menuVisible){
            _container.y = h;
        }
        else{
            _container.y = h - (_container.height - _buttonContainer.height);
        }

        _buttonContainer.x = w - _buttonContainer.width - 35;

    }

    // Geduwd op de rechterknop
    private function rightButton(event:starling.events.TouchEvent):void {
        var t:Touch = event.getTouch(stage);
        var dO:DisplayObject = event.target as starling.display.DisplayObject;
        var tw:Tween = new Tween(_btnRight, .3);
        if(event.getTouch(dO, TouchPhase.HOVER) || event.getTouch(dO, TouchPhase.BEGAN) || event.getTouch(dO, TouchPhase.ENDED)){
            if(t.phase == TouchPhase.ENDED && Utils.device == Utils.IPAD){
                tw.animate("alpha", .5)
                Starling.juggler.add(tw);
            }
            else{
                tw.animate("alpha", 1)
                Starling.juggler.add(tw);
            }
        }
        else{
            tw.animate("alpha", .5)
            Starling.juggler.add(tw);
        }
        switch (t.phase){
            case TouchPhase.ENDED:
                    _appModel.goToNext();
                break;
        }
    }

    // Geduwd op de linkerknop
    private function leftButton(event:starling.events.TouchEvent):void {
        var t:Touch = event.getTouch(stage);
        var dO:DisplayObject = event.target as starling.display.DisplayObject;
        var tw:Tween = new Tween(_btnLeft, .3);
        if(event.getTouch(dO, TouchPhase.HOVER) || event.getTouch(dO, TouchPhase.BEGAN) || event.getTouch(dO, TouchPhase.ENDED)){
            if(t.phase == TouchPhase.ENDED && Utils.multiplicationFactor == 2){
                tw.animate("alpha", .5)
                Starling.juggler.add(tw);
            }
            else{
                tw.animate("alpha", 1)
                Starling.juggler.add(tw);
            }
        }
        else{
            tw.animate("alpha", .5)
            Starling.juggler.add(tw);
        }
        switch (t.phase){
            case TouchPhase.ENDED:
                _appModel.goToPrev();
                break;
        }
    }

    // EventHandler
    private function menuStateChangedHandler(event:Event):void {
        _menuStateChanged = true;
        display();
    }

}
}
