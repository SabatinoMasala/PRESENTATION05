package be.devine.cp3.presentation.factory {
import be.devine.cp3.presentation.interfaces.ISlideVO;
import be.devine.cp3.presentation.slideVO.BulletVO;
import be.devine.cp3.presentation.slideVO.ImageVO;
import be.devine.cp3.presentation.slideVO.TitleVO;
import be.devine.cp3.presentation.utils.Utils;

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

    /*
    Element creeeren die beschreven wordt in de xml
    We creeeren enkel value objecten (geen visuele dingen) opdat we meerdere slides kunnen aanmaken met 1 value object (thumbnails)
    Aangezien visuele objecten kunnen niet meerdere keren kunnen worden getoond
    */
    public static function createElement(xmlNode:XML, only:Boolean = false):ISlideVO {
        var type:String = String(xmlNode.@type);
        switch (type){
            case "title": return titleVO(xmlNode, only);
            case "bullets": return bulletVO(xmlNode, only);
            case "image": return imageVO(xmlNode, only);
        }
        // Geen van bovenstaande cases -> fout in xml
        throw new Error("The XML contains an element which is not recognized");
    }

    public static function titleVO(xmlNode:XML, only:Boolean):ISlideVO {
        var titleVO:TitleVO = new TitleVO(
                xmlNode,
                Utils.str_to_uint(String(xmlNode.@backgroundColor)),
                Utils.str_to_uint(String(xmlNode.@textColor)),
                only
        );
        return titleVO;
    }

    public static function imageVO(xmlNode:XML, only:Boolean):ISlideVO {
        var imageVO:ImageVO = new ImageVO(
                xmlNode.@src
        );
        return imageVO;
    }

    public static function bulletVO(xmlNode:XML, only:Boolean):ISlideVO {
        var vectorString:Vector.<String> = new Vector.<String>();
        for each(var x:XML in xmlNode.bullet){
            vectorString.push(x);
        }
        var bulletVO:BulletVO = new BulletVO(
                vectorString, Utils.str_to_uint(xmlNode.@textColor)
        );
        return bulletVO;
    }
}
}
