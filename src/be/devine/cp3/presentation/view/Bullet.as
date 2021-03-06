package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.utils.Utils;

import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Bullet extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _str:String;
    private var _square:Quad;
    private var _textField:TextField;
    private var _textColor:uint;

    //Constructor
    public function Bullet(string:String, textColor:uint) {
        // String instellen
        _str = string;
        _textColor = textColor;

        // Vierkantje tekenen
        _square = new Quad(20*Utils.multiplicationFactor, 20*Utils.multiplicationFactor, textColor);
        addChild(_square);

        // Tekstveldje aanmaken
        _textField = new TextField(500*Utils.multiplicationFactor, 40*Utils.multiplicationFactor, _str, "Bebas Neue", 30*Utils.multiplicationFactor, textColor);
        _textField.autoScale = true;
        _textField.hAlign = HAlign.LEFT; // Horizontaal links alignen
        _textField.vAlign = VAlign.CENTER; // Verticaal in het midden alignen
        _textField.x = _square.width + 5;
        _textField.y = (_square.height>>1) - (_textField.height>>1);
        addChild(_textField);
    }

    public function destroy():void{
        removeChild(_textField);
        _textField.dispose();
        _textField = null;

        removeChild(_square);
        _square.dispose();
        _square = null;
    }

}
}
