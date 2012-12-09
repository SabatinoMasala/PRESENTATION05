/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 09/12/12
 * Time: 16:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.view {
import be.devine.cp3.presentation.Slide;
import be.devine.cp3.presentation.SlideVO;
import be.devine.cp3.presentation.model.AppModel;

import starling.display.Sprite;

import starling.events.Event;

public class ThumbnailView extends starling.display.Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _appModel:AppModel;
    private var _vectorThumbs:Vector.<Slide>;

    //Constructor
    public function ThumbnailView() {
        trace("[ThumbnailView] Construct");

        _vectorThumbs = new Vector.<Slide>();

        _appModel = AppModel.getInstance();
        //_appModel.addEventListener(AppModel.DATA_CHANGED, dataChangedHandler);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function dataChangedHandler(event:Event):void {
        trace("data changed");
        var tempVector:Vector.<Slide> = new Vector.<Slide>();
        // Door de Vectors in AppModel lussen en slides aanmaken
        var xPos:uint = 0;
        for each(var slideVO:SlideVO in _appModel.vectorSlides){
            var s:Slide = new Slide(slideVO);
            tempVector.push(s);
            s.construct();
            s.x = xPos;
            xPos += 110;
            addChild(s);
            s.resize(stage.stageWidth, stage.stageHeight);
            s.width = 150;
            s.scaleY = s.scaleX;
        }
        _vectorThumbs= tempVector;
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
