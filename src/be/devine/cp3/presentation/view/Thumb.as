/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 18/12/12
 * Time: 21:18
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.textures.Texture;

public class Thumb extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _dimensions:Rectangle;
    private var _selected:Boolean = false;
    private var _border:Quad;
    private var _loader:Loader;

    //Constructor
    public function Thumb(dimensions:Rectangle,n:Number) {
        _dimensions = dimensions;

        _border = new Quad(_dimensions.width+10, _dimensions.height+10, 0xFF0000);
        _border.x -= 5;
        _border.y -= 5;
        addChild(_border);
        _border.alpha = .8;
        _border.visible = false;

        //var q:Quad = new Quad(_dimensions.width, _dimensions.height, 0x333333);
        //addChild(q);

        _loader = new Loader();
        _loader.load(new URLRequest("assets/thumbnails/"+n+".png"));
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedHandler, false, 0, true);


        //var tf:TextField = new TextField(q.width, q.height, ""+n, "Bebas Neue", 30, 0xFFFFFF);
        //tf.autoScale = true;
        //addChild(tf);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function loadedHandler(e:Event):void {
        var i:Image = new Image(Texture.fromBitmap(_loader.content as Bitmap));
        addChild(i);
        i.width = _dimensions.width;
        i.height = _dimensions.height;
    }

    private function display():void {
        if(_selected){
            _border.visible = true;
        }
        else{
            _border.visible = false;
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

    public function get selected():Boolean{
        return _selected;
    }
    public function set selected(value:Boolean):void{
        if(_selected != value){
            _selected = value;
            display();
        }
    }
}
}