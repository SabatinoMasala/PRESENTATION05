/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:30
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation {
import be.devine.cp3.presentation.model.AppModel;

public class DataParser {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    private var _vectorSlides:Vector.<SlideVO>;
    private var _appModel:AppModel;

    //Constructor
    public function DataParser() {
        trace("[DataParser] Construct");
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public function parse(xml:String):void {
        // XML inladen met URLLoader
        // XML parsen -> SlideVO's aanmaken
        // SlideVO's in Vector steken
        // SlideVO's naar appModel sturen
    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
