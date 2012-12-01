/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 22:55
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {

import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;

import starling.display.Quad;

import starling.display.Sprite;

public class Slide extends Sprite implements IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _slideVO:SlideVO;
    private var _elements:Vector.<starling.display.Sprite>;
    private var _background:Quad;

    //Constructor
    public function Slide(slideVO:SlideVO) {
        _slideVO = slideVO;
        _elements = new Vector.<Sprite>();

        _background = new Quad(1, 1, _slideVO.backgroundColor);
        addChild(_background);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function construct():void{
        for each(var s:ISlideElement in _slideVO.arrElements){
            var slide:starling.display.Sprite = s as starling.display.Sprite;
            addChild(slide);
            _elements.push(slide);
        }
    }

    public function resize(w:Number, h:Number):void{
        _background.width = w;
        _background.height = h;
        for each(var s:starling.display.Sprite in _elements){
            (s as IResizable).resize(w, h);
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
