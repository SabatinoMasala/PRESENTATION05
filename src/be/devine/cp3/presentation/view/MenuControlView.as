package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.Arrow;
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
import starling.events.TouchPhase;
import starling.text.TextField;

public class MenuControlView extends Sprite implements IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _thumbnailView:ThumbnailView;
    private var _container:Sprite;
    private var _tween:Tween;
    private var _menuStateChanged:Boolean;
    private var _menuBg:Quad;
    private var _buttonContainer:starling.display.Sprite;
    private var _btnLeft:Arrow;
    private var _btnRight:Arrow;

    //Constructor
    public function MenuControlView() {
        _appModel = AppModel.getInstance();

        // Container aanmaken die menu zal bevatten
        _container = new Sprite();
        addChild(_container);

        // Menu background tekenen (200 pixels hoog, breedte verandert met stageWidth)
        _menuBg = new Quad(1, 200, 0x444444);
        _container.addChild(_menuBg);

        // Thumbnails aanmaken
        _thumbnailView = new ThumbnailView(200, 150);
        _thumbnailView.y = (_menuBg.height>>1) - 75;
        _container.addChild(_thumbnailView);

        // Pijltjes
        _btnLeft = new Arrow(Arrow.LEFT);
        _btnRight = new Arrow(Arrow.RIGHT);

        // Addchilden & positioneren
        _container.addChild(_btnLeft);
        _container.addChild(_btnRight);
        _btnLeft.x = 20;
        _btnLeft.y = (_menuBg.height>>1) - (_btnLeft.height>>1);
        _btnRight.y = (_menuBg.height>>1) - (_btnRight.height>>1);

        // Event listeners
        _btnLeft.addEventListener(TouchEvent.TOUCH, leftButton);
        _btnRight.addEventListener(TouchEvent.TOUCH, rightButton);
        // Handje als de gebruiker erover hovert
        _btnLeft.useHandCursor = true;
        _btnRight.useHandCursor = true;

        // ButtonContainer aanmaken (knopje waar "menu" op staat)
        _buttonContainer = new Sprite();
        _buttonContainer.useHandCursor = true;
        _container.addChild(_buttonContainer);

        // Blokje van 100x35 tekenen
        var q:Quad = new Quad(100, 35, 0x444444);
        _buttonContainer.addChild(q);
        // Tekstveldje toevoegen
        var tf:TextField = new TextField(q.width, q.height, "Menu", "Bebas Neue", 20, 0xFFFFFF);
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

        // Thumbnailview resizen
        _thumbnailView.resize(w, h);

        _btnRight.x = w - (_btnRight.width) - 20;

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
        switch (t.phase){
            case TouchPhase.ENDED:
                    _appModel.goToNext();
                break;
        }
    }

    // Geduwd op de linkerknop
    private function leftButton(event:starling.events.TouchEvent):void {
        var t:Touch = event.getTouch(stage);
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

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
