/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 30/11/12
 * Time: 09:26
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import flash.display.Bitmap;
import flash.display.BitmapData;

import starling.display.Image;

import starling.display.Sprite;
import starling.text.TextField;

public class Titel extends starling.display.Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _basisTitel:Image;
    private var _textField:starling.text.TextField;

    //Constructor
    public function Titel(str:String) {
        trace("[Titel] Construct");

        var flashTitel:BasisTitel = new BasisTitel();

        var bmd:BitmapData = new BitmapData(flashTitel.width, flashTitel.height, true, 0x00FFFF);
        bmd.draw(flashTitel);

        var b:Bitmap = new Bitmap(bmd);

        _basisTitel = Image.fromBitmap(b);

        addChild(_basisTitel);

        _textField = new starling.text.TextField(width, height, str, "Pecita", 40);
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
