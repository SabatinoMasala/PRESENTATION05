package be.devine.cp3.presentation.slide {
import be.devine.cp3.presentation.view.Bullet;
import be.devine.cp3.presentation.interfaces.IResizable;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.slideVO.BulletVO;

import starling.display.Sprite;

public class BulletElement extends Sprite implements ISlideElement, IResizable{

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _vectorBullets:Vector.<String>;
    private var _vectorContainer:Sprite;

    private var bulletVO:BulletVO;

    //Constructor
    public function BulletElement(bulletVO:BulletVO) {
        _vectorBullets = bulletVO.bullets;
        _vectorContainer = new Sprite();
        addChild(_vectorContainer);
        var yPos:uint = 0;
        // Voor iedere String in de Vector gaan we een Bullet object aanmaken
        for each(var s:String in _vectorBullets){
            var b:Bullet = new Bullet(s, bulletVO.textColor);
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

}
}
