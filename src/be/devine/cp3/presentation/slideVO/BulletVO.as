package be.devine.cp3.presentation.slideVO {
import be.devine.cp3.presentation.interfaces.ISlideVO;

public class BulletVO implements ISlideVO {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public var bullets:Vector.<String>;
    public var textColor:uint;

    //Constructor
    public function BulletVO(bullets:Vector.<String>, textColor:uint) {
        this.bullets = bullets;
        this.textColor = textColor;
    }

}
}
