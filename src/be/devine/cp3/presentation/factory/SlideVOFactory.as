package be.devine.cp3.presentation.factory {
import be.devine.cp3.presentation.interfaces.ISlideVO;
import be.devine.cp3.presentation.slideVO.SlideVO;
import be.devine.cp3.presentation.utils.Utils;

public class SlideVOFactory {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    //Constructor
    public function SlideVOFactory() {
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public static function createSlideVOFromXML(xmlNode:XML):SlideVO{
        var slideVO:SlideVO = new SlideVO();
        var elementVector:Vector.<ISlideVO> = new Vector.<ISlideVO>();
        slideVO.backgroundColor = Utils.str_to_uint(String(xmlNode.@backgroundColor));
        slideVO.transition = (String(xmlNode.@transition) !== "") ? String(xmlNode.@transition) : "none";

        var num:uint = 0;
        var length:uint = xmlNode.element.length();

        for each(var x:XML in xmlNode.element){
            // 2e argument is een boolean die checkt of dit het enige element is of niet
            elementVector.push( ElementVOFactory.createElement(x, (length==1) ) );
        }

        slideVO.arrElements = elementVector;

        return slideVO;
    }

}
}
