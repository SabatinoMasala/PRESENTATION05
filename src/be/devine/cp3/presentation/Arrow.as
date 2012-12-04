/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 04/12/12
 * Time: 11:08
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;

public class Arrow extends starling.display.Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public static const LEFT:String = "left";
    public static const RIGHT:String = "right";

    private var _arrowBitmapData:BitmapData;

    private var _arrow:Image;

    //Constructor
    public function Arrow(dir:String = "right") {
        trace("[Arrow] Construct");

        var arrow:ArrowRight = new ArrowRight();
        _arrowBitmapData = new BitmapData(arrow.width, arrow.height, true, 0xFF0000);

        switch (dir){
            default:
            case LEFT:
                    var matrix:Matrix = new Matrix();
                    matrix.scale(-1, 1);
                    matrix.translate(arrow.width, 0);
                    _arrowBitmapData.draw(arrow, matrix);
                break;
            case RIGHT:
                    _arrowBitmapData.draw(arrow);
                break;
        }
        _arrow = Image.fromBitmap(new Bitmap(_arrowBitmapData));
        addChild(_arrow);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
