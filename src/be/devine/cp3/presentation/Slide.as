/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 22:55
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {

import be.devine.cp3.presentation.interfaces.IResizable;

import flash.display.Bitmap;

import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Image;

import starling.display.Sprite;
import starling.textures.Texture;

public class Slide extends Sprite implements IResizable {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _slideVO:SlideVO;
    private var _image:Image;

    //Constructor
    public function Slide(slideVO:SlideVO) {

        trace("[slide] construct");

    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function resize(w:Number, h:Number):void{

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
