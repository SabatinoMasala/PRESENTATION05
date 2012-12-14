package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.view.Slide;
import be.devine.cp3.presentation.utils.Transition;
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.model.AppModel;
import be.devine.cp3.presentation.slideVO.SlideVO;

import starling.display.Sprite;
import starling.events.Event;

public class SlideView extends Sprite implements IResizable{

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _slides:Vector.<Slide>;
    private var _currentSlideDisplayObject:Slide;
    private var _renderedSlides:Vector.<Slide>;

    //Constructor
    public function SlideView() {

        _slides = new Vector.<Slide>();

        _renderedSlides = new Vector.<Slide>();

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.DATA_CHANGED, dataChangedHandler);
        _appModel.addEventListener(AppModel.SLIDE_CHANGED, slideChangeHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    // Data in AppModel is veranderd
    private function dataChangedHandler(event:Event):void {
        makeSlides();
    }

    // Slide is aangepast
    private function slideChangeHandler(event:Event):void {

        /*if((Math.floor(_appModel.currentIndex/3) * 3) != Math.floor(_slides.indexOf(_currentSlideDisplayObject)/3)*3){
            renderSlides(Math.floor(_appModel.currentIndex/3) * 3);
        };*/

        // Vorige slide instellen op null voor als er geen bestaat
        var prevObj:Slide = null;

        // Bestaat de vorige slide?
        if(_currentSlideDisplayObject){

            // Stel andere variabele in, want _currentSlideDisplayObject wordt overschreven
            prevObj = _currentSlideDisplayObject;
        }


        // instellen op huidige slide
        _currentSlideDisplayObject = _slides[_appModel.currentIndex];

        _currentSlideDisplayObject.construct();

        // Bovenaan plaatsen (voor transitions)
        setChildIndex(_currentSlideDisplayObject, numChildren-1);

        // Transitie oproepen
        Transition.transition(prevObj, _currentSlideDisplayObject);

        if(stage){
            resize(stage.stageWidth, stage.stageHeight);
        }
    }

    // Maak slides van VO's
    private function makeSlides():void {
        var tempVector:Vector.<Slide> = new Vector.<Slide>();
        // Door de Vectors in AppModel lussen en slides aanmaken
        for each(var slideVO:SlideVO in _appModel.vectorSlides){
            var s:Slide = new Slide(slideVO);
            tempVector.push(s);
            //s.construct();
            addChild(s);
            s.visible = false;
        }
        _slides = tempVector;
    }

    private function renderSlides(startIndex:uint = 0):void {
        for each(var s:Slide in _renderedSlides){
            s.destruct();
            _renderedSlides.splice(_renderedSlides.indexOf(s), 1);
        }
        for(var i=startIndex;i<startIndex+3;i++){
            var s:Slide = _slides[i];
            s.construct();
            _renderedSlides.push(s);
        }
    }

    // Resize functie
    public function resize(w:Number, h:Number):void {
        var current:Slide = _currentSlideDisplayObject as Slide;
        if(current){
            current.resize(w, h);
        }
    }
}
}
