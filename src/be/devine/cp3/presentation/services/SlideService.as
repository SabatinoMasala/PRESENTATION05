/**
 * Created with IntelliJ IDEA.
 * User: Gilles
 * Date: 3/12/12
 * Time: 20:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.services {

import be.devine.cp3.presentation.SlideType;
import be.devine.cp3.presentation.SlideVO;
import be.devine.cp3.presentation.Utils;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.model.AppModel;
import be.devine.cp3.presentation.slide.BulletElement;
import be.devine.cp3.presentation.slide.ImageElement;
import be.devine.cp3.presentation.slide.TitleElement;

import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.events.EventDispatcher;

public class SlideService extends starling.events.EventDispatcher {
    public var _pathToXML:String;
    private var _tempVector:Vector.<SlideVO> = new Vector.<SlideVO>();

    public function SlideService(pathToXML:String) {
        _pathToXML = pathToXML;
    }

    public function load():void {
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.load(new URLRequest(_pathToXML));
        urlLoader.addEventListener(starling.events.Event.COMPLETE, sliderXMLLoadedHandler);
    }

    private function sliderXMLLoadedHandler(e:starling.events.Event):void{
        var l:URLLoader = e.currentTarget as URLLoader;
        var xml:XML = XML(l.data);
        parse(xml);
    }

    public function parse(xml:XML):void{
        for each(var slide:XML in xml.slide){
            /*  Hier moet een instantie van de SlideVO komen. Heb nog probleem met de tempvector.





            var slideVO:SlideVO = new SlideVO();
            var type:String = slide.@type;

            var elementVector:Vector.<ISlideElement> = new Vector.<ISlideElement>();

            switch (type){
                default:
                case SlideType.TITLE:
                    elementVector.push(new TitleElement(slide.title, Utils.str_to_uint(slide.title.@backgroundColor), Utils.str_to_uint(slide.title.@textColor), true));
                    break;
                case SlideType.BULLETS:
                    var vectorBullets:Vector.<String> = new Vector.<String>();
                    for each(var bullet:XML in slide.bullet){
                        vectorBullets.push(bullet);
                    }
                    elementVector.push(new BulletElement(vectorBullets));
                    break;
                case SlideType.IMAGE_ONLY:
                    elementVector.push(new ImageElement(slide.image.@src));
                    break;
                case SlideType.IMAGE_TITLE:
                    elementVector.push(new ImageElement(slide.image.@src));
                    elementVector.push(new TitleElement(slide.title, Utils.str_to_uint(slide.title.@backgroundColor), Utils.str_to_uint(slide.title.@textColor)));
                    break;
            }
            slideVO.arrElements = elementVector;
            slideVO.backgroundColor = Utils.str_to_uint(slide.@backgroundColor);
            tempVector.push(slideVO);

             */
        }
        AppModel.getInstance().vectorSlides = tempVector;
        AppModel.getInstance().currentSlide = AppModel.getInstance().vectorSlides[0];
    }

    public function get tempVector():Vector.<SlideVO> {
        return _tempVector;
    }

    public function set tempVector(value:Vector.<SlideVO>):void {
        _tempVector = value;
    }
}
}
