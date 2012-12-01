/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:28
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.Slide;
import be.devine.cp3.presentation.SlideVO;
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
    private var _currentSlideDisplayObject:starling.display.Sprite;

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

    private function reset():void{

    }

    private function dataChangedHandler(event:starling.events.Event):void {
        reset();
        makeSlides();
    }

    private function slideChangeHandler(event:starling.events.Event):void {
        if(_currentSlideDisplayObject != null){
            _currentSlideDisplayObject.visible = false;
        }
        _currentSlideDisplayObject = _slides[_appModel.currentIndex];
        _currentSlideDisplayObject.visible = true;
        if(stage){
            resize(stage.stageWidth, stage.stageHeight);
        }
    }


    private function makeSlides():void {
        var tempVector:Vector.<Slide> = new Vector.<Slide>();
        for each(var slideVO:SlideVO in _appModel.vectorSlides){
            var s:Slide = new Slide(slideVO);
            tempVector.push(s);
            s.construct();
            addChild(s);
            s.visible = false;
        }
        _slides = tempVector;
    }

    public function resize(w:Number, h:Number):void {
        var current:Slide = _currentSlideDisplayObject as Slide;
        if(current){
            current.resize(w, h);
        }
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
