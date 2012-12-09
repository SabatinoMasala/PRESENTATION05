/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 09/12/12
 * Time: 14:08
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.factory {
import be.devine.cp3.presentation.SlideVO;
import be.devine.cp3.presentation.Utils;
import be.devine.cp3.presentation.interfaces.ISlideElement;

public class SlideVOFactory {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    //Constructor
    public function SlideVOFactory() {
        trace("[SlideVOFactory] Construct");
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public static function createSlideVOFromXML(xmlNode:XML):SlideVO{
        var slideVO:SlideVO = new SlideVO();
        var elementVector:Vector.<ISlideElement> = new Vector.<ISlideElement>();
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

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
