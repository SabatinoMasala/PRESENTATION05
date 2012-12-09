package be.devine.cp3.presentation.services {

import be.devine.cp3.presentation.SlideVO;

import be.devine.cp3.presentation.factory.SlideVOFactory;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class SlideService {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public var arrSlides:Vector.<SlideVO>;

    //Constructor
    public function SlideService() {
        trace("[SlideService] Construct");
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function load():void{
        var slideLoader:URLLoader = new URLLoader();
        slideLoader.addEventListener(Event.COMPLETE, completeHandler);
        slideLoader.load(new URLRequest("assets/slides.xml"));
    }

    private function completeHandler(event:Event):void {
        var xmlObject:XML = new XML(event.currentTarget.data);
        var tempSlides:Vector.<SlideVO> = new Vector.<SlideVO>();
        for each(var slide:XML in xmlObject.slide){
            tempSlides.push(SlideVOFactory.createSlideVOFromXML(slide));
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

}
}
