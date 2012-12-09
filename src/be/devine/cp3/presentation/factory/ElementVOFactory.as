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

    // Element creeeren die beschreven wordt in de xml
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

    // Titel element
    public static function createTitle(xmlNode:XML, only:Boolean):ISlideElement{
        var title:TitleElement = new TitleElement(
                xmlNode,
                Utils.str_to_uint(String(xmlNode.@backgroundColor)),
                Utils.str_to_uint(String(xmlNode.@textColor)),
                only
        );
        return title;
    }

    // Bullet element
    public static function createBullets(xmlNode:XML, only:Boolean):ISlideElement{
        var vectorString:Vector.<String> = new Vector.<String>();
        for each(var x:XML in xmlNode.bullet){
            vectorString.push(x);
        }
        var b:BulletElement = new BulletElement(vectorString);
        return b;
    }

    // Image element
    public static function createImage(xmlNode:XML, only:Boolean):ISlideElement{
        var i:ImageElement = new ImageElement(xmlNode.@src);
        return i;
    }


    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/
}
}
