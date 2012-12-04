/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 01/12/12
 * Time: 14:18
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.slide {
import be.devine.cp3.presentation.Bullet;
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;

import starling.display.Sprite;

public class BulletElement extends starling.display.Sprite implements ISlideElement, IResizable{

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _vectorBullets:Vector.<String>;
    private var _vectorContainer:starling.display.Sprite;

    //Constructor
    public function BulletElement(bullets:Vector.<String>) {
        _vectorBullets = bullets;
        _vectorContainer = new starling.display.Sprite();
        addChild(_vectorContainer);
        var yPos:uint = 0;
        for each(var s:String in _vectorBullets){
            var b:Bullet = new Bullet(s);
            b.y = yPos;
            yPos += b.height + 15;
            _vectorContainer.addChild(b);
        }
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function build():void{

    }

    public function resize(w:Number, h:Number):void{
        _vectorContainer.x = (w>>1) - (_vectorContainer.width>>1);
        _vectorContainer.y = (h>>1) - (_vectorContainer.height>>1);
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
