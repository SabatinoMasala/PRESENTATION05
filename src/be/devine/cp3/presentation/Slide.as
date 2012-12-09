package be.devine.cp3.presentation {

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

import starling.display.Quad;
import starling.display.Sprite;

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
        _elements = new Vector.<Sprite>();

        //Achtergrond van 1x1 pixels tekenen (in resize functie zal deze de breedte en hoogte van de stage krijgen)
        _background = new Quad(1, 1, _slideVO.backgroundColor);
        addChild(_background);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    // Slide opbouwen
    public function construct():void{
        for each(var s:ISlideVO in _slideVO.arrElements){
            var element:ISlideElement;
            if(s is ImageVO){
                element = new ImageElement(s as ImageVO);
            }
            if(s is TitleVO){
                element = new TitleElement(s as TitleVO);
            }
            if(s is BulletVO){
                element = new BulletElement(s as BulletVO);
            }
            element.build();
            addChild(element as starling.display.Sprite);
            _elements.push(element);
        }
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
