/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 09/12/12
 * Time: 14:08
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.factory {
import be.devine.cp3.presentation.SlideVO;
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
        slideVO.backgroundColor =
        trace(xmlNode.@backgroundColor);
        return null;
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
