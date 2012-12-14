package be.devine.cp3.presentation.slide {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.slideVO.ImageVO;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import flash.system.ImageDecodingPolicy;
import flash.system.LoaderContext;

import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

public class ImageElement extends Sprite implements ISlideElement, IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _imagePath:String;
    private var _loader:Loader;
    private var _image:Image;
    private var _delayResize:Boolean = false;
    private var _prevPoint:Rectangle;

    private var _texture:Texture;

    private var _slideVO:ImageVO;

    //Constructor
    public function ImageElement(slideVO:ImageVO) {
        this._slideVO = slideVO;

        var lc:LoaderContext = new LoaderContext();
        lc.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;

        _imagePath = slideVO.path;
        _loader = new Loader();
        _loader.load(new URLRequest(_imagePath), lc);
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function completeHandler(event:Event):void {
        var b:Bitmap = _loader.content as Bitmap;
        _texture = Texture.fromBitmap(b);
        _image = new Image(_texture);
        addChild(_image);
        // Als de image nog niet bestond bij de positionering ( zie resize ), werd deze uitgesteld naar hier.
        // De width en height zijn opgeslaan in de Point _prevPoint
        if(_delayResize){
            resize(_prevPoint.width, _prevPoint.height);
        }
    }

    public function destruct():void{
        if(_loader){
            _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
            _loader = null;
        }
        if(_texture){
            _texture.dispose();
        }
        if(_image){
            _image.dispose();
            _image = null;
        }
    }

    public function build():void{

    }

    public function resize(w:Number, h:Number):void{
        // Als we te snel klikken zou de image nog niet zijn ingeladen, vandaar checken we of hij al bestaat of niet.
        // Als hij niet bestaat gaan we de resize uitstellen tot hij wel bestaat ( zie completeHandler )
        if(_image){
            _image.width = (w>>1);
            _image.scaleY = _image.scaleX;
            _image.x = (w>>1) - (_image.width>>1);
            _image.y = (h>>1) - (_image.height>>1);
        }
        else{
            _delayResize = true;
            _prevPoint = new Rectangle(0, 0, w, h);
        }
    }
}
}
