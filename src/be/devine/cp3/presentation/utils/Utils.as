package be.devine.cp3.presentation.utils {
import flash.display.BitmapData;
import flash.display3D.Context3D;
import flash.geom.Rectangle;

import starling.core.RenderSupport;

import starling.core.Starling;

import starling.display.DisplayObject;

public class Utils {

    public static const IPAD:String = "iPad";

    public static var multiplicationFactor:uint = 1;
    public static var device:String;

    // Converteer een string naar een uint ("#FF0000" naar 0xFF0000)
    public static function str_to_uint(str:String):uint{
        if(str == "") return 0xFFFFFF;
        return uint("0x"+str.substr(1));
    }

    // Bitmapdata van starling object maken
    public static function copyAsBitmapData(sprite:starling.display.DisplayObject):BitmapData {
        if (sprite == null) return null;
        var resultRect:Rectangle = new Rectangle();
        sprite.getBounds(sprite, resultRect);
        var context:Context3D = Starling.context;
        var support:RenderSupport = new RenderSupport();
        RenderSupport.clear();
        support.setOrthographicProjection(0,0,Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);
        //support.transformMatrix(sprite.root);
        support.translateMatrix( -resultRect.x, -resultRect.y);
        var result:BitmapData = new BitmapData(resultRect.width, resultRect.height, true, 0x00000000);
        support.pushMatrix();
        support.transformMatrix(sprite);
        sprite.render(support, 1.0);
        support.popMatrix();
        support.finishQuadBatch();
        context.drawToBitmapData(result);
        return result;
    }

}
}
