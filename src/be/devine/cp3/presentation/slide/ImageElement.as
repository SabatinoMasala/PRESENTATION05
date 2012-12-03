/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 01/12/12
 * Time: 14:18
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.slide {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;

import flash.display.Bitmap;

import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Image;

import starling.display.Sprite;

public class ImageElement extends Sprite implements ISlideElement, IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _imagePath:String;
    private var _loader:Loader;
    private var _image:Image;

    //Constructor
    public function ImageElement(path:String) {
        _imagePath = path;
        _loader = new Loader();
        _loader.load(new URLRequest(_imagePath));
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function completeHandler(event:Event):void {
        _image = Image.fromBitmap(Bitmap(_loader.content));
        addChild(_image);
    }

    public function build():void{

    }

    public function resize(w:Number, h:Number):void{
        _image.width = (w>>1);
        _image.scaleY = _image.scaleX;
        _image.x = (w>>1) - (_image.width>>1);
        _image.y = (h>>1) - (_image.height>>1);
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
