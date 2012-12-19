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

        renderSlides(_appModel.currentIndex);

        // Vorige slide instellen op null voor als er geen bestaat
        var prevObj:Slide = null;

        // Bestaat de vorige slide?
        if(_currentSlideDisplayObject){

            // Stel andere variabele in, want _currentSlideDisplayObject wordt overschreven
            prevObj = _currentSlideDisplayObject;
        }


        // instellen op huidige slide
        _currentSlideDisplayObject = _slides[_appModel.currentIndex];


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
            addChild(s);
            s.visible = false;
        }
        _slides = tempVector;
    }

    private function renderSlides(startIndex:uint = 0):void {

        var minus:uint = (startIndex == 0) ? 0 : 1;

        var disposeArray:Vector.<Slide> = new Vector.<Slide>();

        for each(var sl:Slide in _renderedSlides){

            if(isDisposable(_slides.indexOf(sl), startIndex)){
                disposeArray.push(sl);
            };

        }

        for each(var s:Slide in disposeArray){
            if(_currentSlideDisplayObject != s){
                _renderedSlides.splice(_renderedSlides.indexOf(s), 1);
                s.destruct();
            }
        }

        for(var i:uint = startIndex - minus; i < startIndex + (3 - minus); i++){
            if(i > _slides.length-1){
                break;
            }
            if(_renderedSlides.indexOf(_slides[i]) == -1){
                _renderedSlides.push(_slides[i]);
                (_slides[i]).construct();
            }
        }

    }

    private function isDisposable(index:uint, startIndex:uint):Boolean {

        var renders:Vector.<uint> = new Vector.<uint>();
        if(startIndex == 0){
            renders.push(startIndex, startIndex+1, startIndex+2);
        }
        else{
            renders.push(startIndex-1, startIndex, startIndex+1);
        }

        if(renders.indexOf(index) == -1){
            renders = null;
            return true;
        }
        renders = null;

        return false;

    }

    // Resize functie
    public function resize(w:Number, h:Number):void {
        var current:Slide = _currentSlideDisplayObject as Slide;
        if(current){
            current.resize(w, h);
        }
    }

    public function get currentSlideDisplayObject():Slide {
        return _currentSlideDisplayObject;
    }
}
}
