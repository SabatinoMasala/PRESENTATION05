/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 03/12/12
 * Time: 21:42
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Bullet extends starling.display.Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _str:String;
    private var _square:Quad;
    private var _textField:starling.text.TextField;

    //Constructor
    public function Bullet(string:String) {
        trace("[Bullet] Construct");
        _str = string;
        _square = new Quad(10, 10, 0x444444);
        addChild(_square);
        _textField = new starling.text.TextField(300, 20, _str, "Bebas Neue", 20, 0xFF0000);
        _textField.hAlign = HAlign.LEFT;
        _textField.vAlign = VAlign.CENTER;
        _textField.x = _square.width + 5;
        _textField.y -= _square.height>>1;
        addChild(_textField);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
