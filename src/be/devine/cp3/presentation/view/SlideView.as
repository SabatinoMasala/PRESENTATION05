package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.Slide;
import be.devine.cp3.presentation.SlideVO;
import be.devine.cp3.presentation.Transition;
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;

public class SlideView extends Sprite implements IResizable{

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _slides:Vector.<Slide>;
    private var _currentSlideDisplayObject:Slide;

    //Constructor
    public function SlideView() {

        _slides = new Vector.<Slide>();

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
            s.construct();
            addChild(s);
            s.visible = false;
        }
        _slides = tempVector;
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
