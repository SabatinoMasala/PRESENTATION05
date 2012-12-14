package be.devine.cp3.presentation.view {

import be.devine.cp3.presentation.utils.Utils;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

import starling.display.Image;
import starling.display.Sprite;

public class Arrow extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public static const LEFT:String = "left";
    public static const RIGHT:String = "right";

    private var _arrowBitmapData:BitmapData;
    private var _arrow:Image;

    //Constructor
    public function Arrow(dir:String = "right") {
        // Flash asset in SWC aanmaken
        var arrow:ArrowRight = new ArrowRight();

        // Bitmapdata aanmaken voor pijltje
        _arrowBitmapData = new BitmapData(arrow.width, arrow.height, true, 0xFF0000);

        // Switchen op direction
        switch (dir){
            default:
            case LEFT:
                    // Matrix om hem te spiegelen
                    var matrix:Matrix = new Matrix();
                    matrix.scale(-1, 1);
                    matrix.translate(arrow.width, 0);
                    _arrowBitmapData.draw(arrow, matrix);
                break;
            case RIGHT:
                    _arrowBitmapData.draw(arrow);
                    _arrowBitmapData.draw(arrow);
                break;
        }
        _arrow = Image.fromBitmap(new Bitmap(_arrowBitmapData));
        _arrowBitmapData.dispose();
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
