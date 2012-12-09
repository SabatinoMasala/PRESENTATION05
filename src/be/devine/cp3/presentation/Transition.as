package be.devine.cp3.presentation {
import be.devine.cp3.presentation.model.AppModel;

import starling.animation.Tween;
import starling.core.Starling;

public class Transition {

    public static const TIME:Number = .5;
    private static var t:Tween;

    public static function transition(slide_1:Slide, slide_2:Slide):void{

        // Vorige tween (eventueel) stoppen
        if(t){
            t.advanceTime(TIME);
        }

        if(slide_1 == null){
            slide_2.visible = true;
        }
        else{
            switch (slide_2.transition){
                case "none": return none(slide_1, slide_2);
                case "fade": return fade(slide_1, slide_2);
            }
        }
    }

    public static function none(slide_1, slide_2):void{
        trace("none");
        slide_1.visible = false;
        slide_2.visible = true;
    }

    public static function fade(slide_1:Slide, slide_2:Slide):void{
        trace("fading");
        slide_1.visible = true;
        slide_1.alpha = 1;
        slide_2.alpha = 0;
        slide_2.visible = true;
        t = new Tween(slide_2, TIME);
        t.animate("alpha", 1);
        t.onComplete = function():void{slide_1.visible = false;t=null;}
        Starling.juggler.add(t);
    }
}
}
