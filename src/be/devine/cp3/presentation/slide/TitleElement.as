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
    private var _backgroundColor:uint;
    private var _textColor:uint;

    //Constructor
    public function TitleElement(title:String, backgroundColor:uint, textColor:uint, big:Boolean = false) {
        // Is het een grote titel?
        _big = big;
        _title = title;
        _backgroundColor = backgroundColor;
        _textColor = textColor;

        // Als de titel klein is
        if(!_big){
            // quad van 1x60 met backgroundcolor uit VO aanmaken (breedte past aan met stage.stageWidth)
            _background = new Quad(1, 60, _backgroundColor);
            _textField = new starling.text.TextField(300, 60, _title, "Bebas Neue", 40, _textColor);
        }
        // Als de titel groot is
        else{
            // quad van 1x120 met backgroundcolor uit VO aanmaken (breedte past aan met stage.stageWidth)
            _background = new Quad(1, 120, _backgroundColor);
            _textField = new starling.text.TextField(300, 120, _title, "Bebas Neue", 60, _textColor);
        }

        // Autoscale & verticaal / horizontaal in het midden plaatsen
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

    // Resize functie
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
