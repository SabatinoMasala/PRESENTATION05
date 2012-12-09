package be.devine.cp3.presentation {
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

    //Constructor
    public function Bullet(string:String) {
        // String instellen
        _str = string;

        // Vierkantje tekenen
        _square = new Quad(10, 10, 0x444444);
        addChild(_square);

        // Tekstveldje aanmaken
        _textField = new TextField(300, 20, _str, "Bebas Neue", 20, 0xFF0000);
        _textField.hAlign = HAlign.LEFT; // Horizontaal links alignen
        _textField.vAlign = VAlign.CENTER; // Verticaal in het midden alignen
        _textField.x = _square.width + 5;
        _textField.y -= _square.height>>1;
        addChild(_textField);
    }

}
}
