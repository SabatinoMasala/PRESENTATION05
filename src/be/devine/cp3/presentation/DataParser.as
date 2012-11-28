/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:30
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {

import flash.events.Event;

import flash.net.URLLoader;
import flash.net.URLRequest;

public class DataParser {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _vectorSlides:Vector.<SlideVO>;
    private var _xml:XML;

    //Constructor
    public function DataParser() {
        trace("[DataParser] Construct");
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function parse(xml:String):void {
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.load(new URLRequest(xml));
        urlLoader.addEventListener(flash.events.Event.COMPLETE, loadedHandler);
        // XML inladen met URLLoader
        // XML parsen -> SlideVO's aanmaken
        // SlideVO's in Vector steken
        // SlideVO's naar appModel sturen
    }

    private function parseXML():void{
        for each(var slide:XML in _xml.slide){
            var slideType:String;
            //var slideVO:SlideVO = new SlideVO();
            trace("type", slide.@type);
            var type:String = slide.@type;

            switch (type){
                case SlideType.TITLE:
                default:
                    trace("enkel een titel");
                    slideType = SlideType.TITLE;
                    break;
                case SlideType.BULLETS:
                    slideType = SlideType.BULLETS;
                    break;
                case SlideType.IMAGE_ONLY:
                    slideType = SlideType.IMAGE_ONLY;
                    break;
                case SlideType.IMAGE_TITLE:
                    slideType = SlideType.IMAGE_TITLE;
                    break;
            }
            //slideVO.type = slideType;
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

    private function loadedHandler(event:flash.events.Event):void {
        var l:URLLoader = event.currentTarget as URLLoader;
        xml = XML(l.data);
    }

    public function get xml():XML {
        return _xml;
    }

    public function set xml(value:XML):void {
        if(_xml != value){
            _xml = value;
            parseXML();
        }
    }
}
}
