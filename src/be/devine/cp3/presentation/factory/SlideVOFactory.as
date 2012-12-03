/**
 * Created with IntelliJ IDEA.
 * User: Gilles
 * Date: 3/12/12
 * Time: 20:15
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.factory {
import be.devine.cp3.presentation.SlideType;
import be.devine.cp3.presentation.SlideVO;
import be.devine.cp3.presentation.Utils;
import be.devine.cp3.presentation.interfaces.ISlideElement;
import be.devine.cp3.presentation.slide.BulletElement;
import be.devine.cp3.presentation.slide.ImageElement;
import be.devine.cp3.presentation.slide.TitleElement;

public class SlideVOFactory {
    public static function createFromXML(slideXML:XML):SlideVO
    {
        switch("" + slideXML.@type)
        {
            case SlideType.IMAGE_ONLY: return createImageSlideVO(slideXML);
            case SlideType.IMAGE_TITLE: return createImageTitleSlideVO(slideXML);
            case SlideType.BULLETS: return createBulletsSlideVO(slideXML);
            case SlideType.TITLE: return createTitleSlideVO(slideXML);
        }
        return null;
    }

    public static function createImageSlideVO(slideXML:XML):SlideVO
    {
        var slide:XML = slideXML;
        var slideVO:SlideVO = new SlideVO();
        var type:String = slide.@type;
        var elementVector:Vector.<ISlideElement> = new Vector.<ISlideElement>();

        elementVector.push(new ImageElement(slide.image.@src));

        slideVO.arrElements = elementVector;
        slideVO.backgroundColor = Utils.str_to_uint(slide.@backgroundColor);
   
        return slideVO;
    }

    public static function createImageTitleSlideVO(slideXML:XML):SlideVO
    {
        var slide:XML = slideXML;
        var slideVO:SlideVO = new SlideVO();
        var type:String = slide.@type;
        var elementVector:Vector.<ISlideElement> = new Vector.<ISlideElement>();

        elementVector.push(new ImageElement(slide.image.@src));
        elementVector.push(new TitleElement(slide.title, Utils.str_to_uint(slide.title.@backgroundColor), Utils.str_to_uint(slide.title.@textColor)));
                
        slideVO.arrElements = elementVector;
        slideVO.backgroundColor = Utils.str_to_uint(slide.@backgroundColor);

        return slideVO;
    }

    public static function createBulletsSlideVO(slideXML:XML):SlideVO
    {
        var slide:XML = slideXML;
        var slideVO:SlideVO = new SlideVO();
        var type:String = slide.@type;
        var elementVector:Vector.<ISlideElement> = new Vector.<ISlideElement>();
        var elementVector:Vector.<ISlideElement> = new Vector.<ISlideElement>();

        var vectorBullets:Vector.<String> = new Vector.<String>();
        for each(var bullet:XML in slide.bullet){
            vectorBullets.push(bullet);
        }
        elementVector.push(new BulletElement(vectorBullets));
        
        
        slideVO.arrElements = elementVector;
        slideVO.backgroundColor = Utils.str_to_uint(slide.@backgroundColor);

        return slideVO;
    }

    public static function createTitleSlideVO(slideXML:XML):SlideVO
    {
        var slide:XML = slideXML;
        var slideVO:SlideVO = new SlideVO();
        var type:String = slide.@type;
        var elementVector:Vector.<ISlideElement> = new Vector.<ISlideElement>();

        elementVector.push(new TitleElement(slide.title, Utils.str_to_uint(slide.title.@backgroundColor), Utils.str_to_uint(slide.title.@textColor), true));
        
        slideVO.arrElements = elementVector;
        slideVO.backgroundColor = Utils.str_to_uint(slide.@backgroundColor);

        return slideVO;
    }
}
}
