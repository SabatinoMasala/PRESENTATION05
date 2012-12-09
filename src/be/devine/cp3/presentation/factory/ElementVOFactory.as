/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 09/12/12
 * Time: 14:13
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.factory {
import be.devine.cp3.presentation.Utils;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.slide.BulletElement;
import be.devine.cp3.presentation.slide.ImageElement;
import be.devine.cp3.presentation.slide.TitleElement;

public class ElementVOFactory {

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    //Constructor
    public function ElementVOFactory() {
        trace("[ElementVOFactory] Construct");
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public static function createElement(xmlNode:XML, only:Boolean = false):ISlideElement {
        var type:String = String(xmlNode.@type);
        switch (type){
            case "title": return createTitle(xmlNode, only);
            case "bullets": return createBullets(xmlNode, only);
            case "image": return createImage(xmlNode, only);
        }
        // Geen van bovenstaande cases -> fout in xml
        throw new Error("The XML contains an element which is not recognized");
    }

    public static function createTitle(xmlNode:XML, only:Boolean):ISlideElement{
        var title:TitleElement = new TitleElement(
                xmlNode,
                Utils.str_to_uint(String(xmlNode.@backgroundColor)),
                Utils.str_to_uint(String(xmlNode.@textColor)),
                only
        );
        return title;
    }

    public static function createBullets(xmlNode:XML, only:Boolean):ISlideElement{
        var vectorString:Vector.<String> = new Vector.<String>();
        for each(var x:XML in xmlNode.bullet){
            vectorString.push(x);
        }
        var b:BulletElement = new BulletElement(vectorString);
        return b;
    }

    public static function createImage(xmlNode:XML, only:Boolean):ISlideElement{
        var i:ImageElement = new ImageElement(xmlNode.@src);
        return i;
    }


    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
