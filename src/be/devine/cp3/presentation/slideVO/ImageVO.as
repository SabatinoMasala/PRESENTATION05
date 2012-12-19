package be.devine.cp3.presentation.slideVO {
import be.devine.cp3.presentation.interfaces.ISlideVO;

public class ImageVO implements ISlideVO {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public var path:String;

    //Constructor
    public function ImageVO(path:String) {
        this.path = path;
    }

}
}
