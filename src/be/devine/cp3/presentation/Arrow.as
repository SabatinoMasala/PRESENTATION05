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
        _arrowBitmapData = new BitmapData(arrow.width, arrow.height);

        switch (dir){
            default:
            case LEFT:
                    _arrowBitmapData.draw(arrow, new Matrix());
                    _arrow = Image.fromBitmap(new Bitmap(_arrowBitmapData));
                break;
            case RIGHT:
                    _arrow = Image.fromBitmap(new Bitmap(_arrowBitmapData));
                break;
        }
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
