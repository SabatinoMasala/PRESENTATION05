package be.devine.cp3.presentation.slideVO {
import be.devine.cp3.presentation.interfaces.ISlideVO;

public class TitleVO implements ISlideVO {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public var title:String;
    public var backgroundColor:uint;
    public var textColor:uint;
    public var big:Boolean;

    //Constructor
    public function TitleVO(str:String, backgroundColor:uint, textColor:uint, only:Boolean) {
        this.title = str;
        this.backgroundColor = backgroundColor;
        this.textColor = textColor;
        this.big = only;
    }

}
}
