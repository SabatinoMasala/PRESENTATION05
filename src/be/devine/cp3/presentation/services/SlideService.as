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
import be.devine.cp3.presentation.factory.SlideVOFactory;
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
            tempVector.push(SlideVOFactory.createFromXML(slide));
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
