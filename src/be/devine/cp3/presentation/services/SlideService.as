package be.devine.cp3.presentation.services {

import be.devine.cp3.presentation.slideVO.SlideVO;

import be.devine.cp3.presentation.factory.SlideVOFactory;
import be.devine.cp3.presentation.model.AppModel;

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
        // Voor elk slide object in de xml gaan we de Factory aanspreken die alles zal regelen
        for each(var slide:XML in xmlObject.slide){
            tempSlides.push(SlideVOFactory.createSlideVOFromXML(slide));
        }
        // De Vector in AppModel instellen
        var appModel:AppModel = AppModel.getInstance();
        appModel.vectorSlides = tempSlides;

        // De huidige slide op 1 zetten
        appModel.currentSlide = appModel.vectorSlides[0];
    }

}
}
