/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 22:55
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.View {
import be.devine.cp3.presentation.SlideType;
import be.devine.cp3.presentation.SlideVO;

import flash.display.Bitmap;

import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;

public class Slide extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _slideVO:SlideVO;
    private var _image:Image;

    //Constructor
    public function Slide(slideVO:SlideVO) {

        var q:Quad = new Quad(100, 100, 0xFFFFFF*Math.random());
        addChild(q);
        trace("[slide] construct");
        this._slideVO = slideVO;
        switch(this._slideVO.type){
            case SlideType.BULLETS:
                    bullets();
                break;
            case SlideType.IMAGE_ONLY:
                    image();
                break;
            case SlideType.IMAGE_TITLE:
                    image_with_title();
                break;
            case SlideType.TITLE:
                    title();
                break;
        }

        var tf:TextField = new TextField(200, 100, this._slideVO.title);
        tf.color = 0x000000;
        addChild(tf);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function image():void {
        loadImage();
    }

    private function loadImage():void {
        var l:Loader = new Loader();
        l.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadedHandler);
        l.load(new URLRequest(_slideVO.imagePath));
    }

    private function imageLoadedHandler(event:flash.events.Event):void {
        var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
        _image = new Image(starling.textures.Texture.fromBitmap(loadedBitmap));
        addChild(_image);
    }

    private function bullets():void {

    }

    private function image_with_title():void {
        loadImage();
    }

    private function title():void {

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
