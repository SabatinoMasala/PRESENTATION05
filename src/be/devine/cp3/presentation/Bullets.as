/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 30/11/12
 * Time: 10:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import flash.display.Bitmap;

import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;

public class Bullets extends starling.display.Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _arrBullets:Vector.<String>;
    private var _background:Image;

    //Constructor
    public function Bullets(arrBullets:Vector.<String>) {
        trace("[Bullets] Construct");
        _arrBullets = arrBullets;

        var bitmap:Bitmap = new Bitmap(new BasisBullet());
        _background = Image.fromBitmap(bitmap);
        addChild(_background);

        makeBullets();
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function makeBullets():void {
        var maxNum:uint = (_arrBullets.length-1 < 9) ? _arrBullets.length : 9;
        var yPos:Number = 10;
        for(var i:uint = 0; i<maxNum; i++){
            var tf:starling.text.TextField = new starling.text.TextField(_background.width, 40, _arrBullets[i], "Pecita", 40);
            addChild(tf);
            tf.y = yPos;
            yPos += tf.height + 10;
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
