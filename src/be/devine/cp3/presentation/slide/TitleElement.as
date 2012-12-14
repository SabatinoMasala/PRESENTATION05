package be.devine.cp3.presentation.slide {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.slideVO.TitleVO;
import be.devine.cp3.presentation.utils.Utils;

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

    private var _slideVO:TitleVO;

    //Constructor
    public function TitleElement(titleVO:TitleVO) {

        this._slideVO = titleVO;

        // Is het een grote titel?
        _big = this._slideVO.big;
        _title = this._slideVO.title;
        _backgroundColor = this._slideVO.backgroundColor;
        _textColor = this._slideVO.textColor;

        // Als de titel klein is
        if(!_big){
            // quad van 1x60 met backgroundcolor uit VO aanmaken (breedte past aan met stage.stageWidth)
            _background = new Quad(1, 60*Utils.multiplicationFactor, _backgroundColor);
            _textField = new starling.text.TextField(300*Utils.multiplicationFactor, 60*Utils.multiplicationFactor, _title, "Bebas Neue", 40*Utils.multiplicationFactor, _textColor);
        }
        // Als de titel groot is
        else{
            // quad van 1x120 met backgroundcolor uit VO aanmaken (breedte past aan met stage.stageWidth)
            _background = new Quad(1, 120*Utils.multiplicationFactor, _backgroundColor);
            _textField = new starling.text.TextField(300*Utils.multiplicationFactor, 120*Utils.multiplicationFactor, _title, "Bebas Neue", 60*Utils.multiplicationFactor, _textColor);
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

    public function destruct():void{
        removeChild(_background);
        _background.dispose();
        _background = null;

        removeChild(_textField);
        _textField.dispose();
        _textField = null;

        this._slideVO = null;
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
