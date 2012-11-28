/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 22:55
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.View {
import be.devine.cp3.presentation.SlideType;
import be.devine.cp3.presentation.SlideVO;

import starling.display.Sprite;
import starling.text.TextField;

public class Slide extends starling.display.Sprite {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _slideVO:SlideVO;

    //Constructor
    public function Slide(slideVO:SlideVO) {
        trace("[slide] construct");
        this._slideVO = slideVO;
        switch(this._slideVO.type){
            case SlideType.BULLETS:
                    bullets();
                break;
            case SlideType.IMAGE_ONLY:
                    image();
                break;
            case SlideType.IMAGE_TITLE:
                    image_with_title();
                break;
            case SlideType.TITLE:
                    title();
                break;
        }
        var tf:starling.text.TextField = new starling.text.TextField(200, 100, this._slideVO.title);
        tf.color = 0x000000;
        addChild(tf);
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    private function image():void {
        trace(_slideVO.imagePath);
    }

    private function bullets():void {

    }

    private function image_with_title():void {

    }

    private function title():void {

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
