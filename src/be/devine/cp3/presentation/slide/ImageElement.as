package be.devine.cp3.presentation.slide {
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.interfaces.ISlideVO;
import be.devine.cp3.presentation.slideVO.ImageVO;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.Point;
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
    private var _delayResize:Boolean = false;
    private var _prevPoint:Point;

    private var _slideVO:ImageVO;

    //Constructor
    public function ImageElement(slideVO:ImageVO) {
        this._slideVO = slideVO;
        _imagePath = slideVO.path;
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
        // Als de image nog niet bestond bij de positionering ( zie resize ), werd deze uitgesteld naar hier.
        // De width en height zijn opgeslaan in de Point _prevPoint
        if(_delayResize){
            resize(_prevPoint.x, _prevPoint.y);
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
            _prevPoint = new Point(w, h);
        }
    }
}
}
