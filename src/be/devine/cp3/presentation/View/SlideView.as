/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:28
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.View {
import be.devine.cp3.presentation.SlideVO;
import be.devine.cp3.presentation.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;

public class SlideView extends Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _slides:Vector.<Slide>;

    //Constructor
    public function SlideView() {
        trace("[SlideView] Construct");

        _slides = new Vector.<Slide>();

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.DATA_CHANGED, dataChangedHandler);
        _appModel.addEventListener(AppModel.SLIDE_CHANGED, slideChangeHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function reset():void{

    }

    private function dataChangedHandler(event:starling.events.Event):void {
        reset();
        makeSlides();
    }

    private function slideChangeHandler(event:AppModel):void {

    }


    private function makeSlides():void {
        var tempVector:Vector.<Slide> = new Vector.<Slide>();
        for each(var slideVO:SlideVO in _appModel.vectorSlides){
            var s:Slide = new Slide(slideVO);
            tempVector.push(s);
        }
        _slides = tempVector;
        goToSlide(1);
    }

    private function goToSlide(slideNum:uint):void {
        if(slideNum < 1) slideNum = 1;
        if(slideNum > _slides.length) slideNum = _slides.length;
        var index = slideNum - 1;
        addChild(_slides[index]);
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
