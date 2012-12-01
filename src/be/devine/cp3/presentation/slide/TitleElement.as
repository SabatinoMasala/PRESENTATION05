/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 01/12/12
 * Time: 14:18
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.slide {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;

import starling.display.Quad;

import starling.display.Sprite;

import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class TitleElement extends starling.display.Sprite implements ISlideElement, IResizable{

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _title:String;
    private var _textField:starling.text.TextField;
    private var _background:Quad;
    private var _big:Boolean;

    //Constructor
    public function TitleElement(title:String, backgroundColor:uint, textColor:uint, big:Boolean = false) {
        _big = big;
        _title = title;

        if(!_big){
            _background = new Quad(1, 60, backgroundColor);
            _textField = new starling.text.TextField(300, 60, _title, "Bebas Neue", 40, textColor);
        }
        else{
            _background = new Quad(1, 120, backgroundColor);
            _textField = new starling.text.TextField(300, 120, _title, "Bebas Neue", 60, textColor);
        }

        _textField.autoScale = true;
        _textField.vAlign = VAlign.CENTER;
        _textField.hAlign = HAlign.CENTER;

        addChild(_background);
        addChild(_textField);

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function build():void{

    }

    public function resize(w:Number, h:Number):void{
        if(_big){
            _background.y = (h>>1) - (_textField.height>>1);
            _textField.y = (h>>1) - (_textField.height>>1);
        }
        _textField.width = w;
        _textField.x = (w>>1) - (_textField.width>>1);
        _background.width = w;
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
