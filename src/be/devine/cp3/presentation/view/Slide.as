package be.devine.cp3.presentation.view {

import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.interfaces.ISlideVO;
import be.devine.cp3.presentation.slide.BulletElement;
import be.devine.cp3.presentation.slide.ImageElement;
import be.devine.cp3.presentation.slide.TitleElement;
import be.devine.cp3.presentation.slideVO.BulletVO;
import be.devine.cp3.presentation.slideVO.ImageVO;
import be.devine.cp3.presentation.slideVO.SlideVO;
import be.devine.cp3.presentation.slideVO.TitleVO;
import be.devine.cp3.presentation.utils.Utils;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.TouchEvent;

public class Slide extends Sprite implements IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _slideVO:SlideVO;
    private var _elements:Vector.<Sprite>;
    private var _background:Quad;

    //Constructor
    public function Slide(slideVO:SlideVO) {
        _slideVO = slideVO;

        //Achtergrond van 1x1 pixels tekenen (in resize functie zal deze de breedte en hoogte van de stage krijgen)
        _background = new Quad(1, 1, _slideVO.backgroundColor);
        addChild(_background);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function thandler(e:starling.events.TouchEvent):void {
        trace( (e.currentTarget as ImageElement).id );
    }

    // Slide opbouwen
    public function construct():void{

        _elements = new Vector.<Sprite>();

        if(!contains(_background)){
            addChild(_background);
        }
        for each(var s:ISlideVO in _slideVO.arrElements){
            var element:ISlideElement;
            if(s is ImageVO){
                element = new ImageElement(s as ImageVO, Utils.num());
                (element as Sprite).addEventListener(starling.events.TouchEvent.TOUCH, thandler);
            }
            if(s is TitleVO){
                element = new TitleElement(s as TitleVO);
            }
            if(s is BulletVO){
                element = new BulletElement(s as BulletVO);
            }
            addChild(element as starling.display.Sprite);
            _elements.push(element);
        }
    }

    // Destruct functie
    public function destruct():void{
        for each(var s:ISlideElement in _elements){
            s.destruct();
            removeChild((s as Sprite));
            (s as Sprite).dispose();
            s = null;
        }
        _elements = null;
        removeChild(_background);
        _background.dispose();

    }

    // Resize functie
    public function resize(w:Number, h:Number):void{
        _background.width = w;
        _background.height = h;
        for each(var s:Sprite in _elements){
            (s as IResizable).resize(w, h);
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

    public function get transition():String{
        return _slideVO.transition;
    }
}
}
