package be.devine.cp3.presentation {
import be.devine.cp3.presentation.model.AppModel;

import flash.utils.Timer;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Quad;
import starling.display.Sprite;
import starling.extensions.pixelmask.PixelMaskDisplayObject;

public class Transition {

    public static const TIME:Number = .5;
    private static var tween_1:Tween;
    private static var tween_2:Tween;

    public static function transition(slide_1:Slide, slide_2:Slide):void{

        // Vorige tween(s) (eventueel) stoppen
        if(tween_1){
            tween_1.advanceTime(TIME);
        }
        if(tween_2){
            tween_2.advanceTime(TIME);
        }

        // Slides terug op 0,0 zetten
        if(slide_1){
            slide_1.x = 0;
            slide_1.y = 0;
        }
        if(slide_2){
            slide_2.x = 0;
            slide_2.y = 0;
        }

        // Als slide_1 null is (als de presentatie begint) zal deze gewoon zonder transitie getoond worden
        if(slide_1 == null){
            slide_2.visible = true;
        }
        else{
            switch (slide_2.transition){
                case "none": return none(slide_1, slide_2);
                case "fade": return fade(slide_1, slide_2);
                case "slide_horizontal": return zoomfade(slide_1, slide_2);
                case "slide_vertical": return slideV(slide_1, slide_2);
            }
        }
    }

    // Geen transitie
    private static function none(slide_1:Slide, slide_2:Slide):void{
        trace("none");
        slide_1.visible = false;
        slide_2.visible = true;
    }

    // Fade out transitie
    private static function fade(slide_1:Slide, slide_2:Slide):void{
        trace("fading");
        slide_1.visible = true;
        slide_1.alpha = 1;
        slide_2.alpha = 0;
        slide_2.visible = true;
        tween_1 = new Tween(slide_2, TIME, starling.animation.Transitions.EASE_OUT);
        tween_1.animate("alpha", 1);
        tween_1.onComplete = function():void{slide_1.visible = false; tween_1=null;}
        Starling.juggler.add(tween_1);
    }

    // Slide horizontaal
    private static function slideH(slide_1:Slide, slide_2:Slide):void {

        trace("horizontal slide");

        // Zichtbaar zetten beide slides
        slide_1.visible = true;
        slide_2.visible = true;

        // Tween voor slide die nu zichtbaar is
        tween_2 = new Tween(slide_1, TIME, starling.animation.Transitions.EASE_OUT);

        // Welke kant gaan we op?
        if(AppModel.getInstance().direction == AppModel.RIGHT){

            // Slide 2 staat rechts buiten scherm en animaart naar links
            slide_2.x = Starling.current.stage.stageWidth;

            // Slide 1 animeert naar links
            tween_2.animate("x", -200);
        }
        else{

            // Slide 2 staat links buiten scherm
            slide_2.x = -Starling.current.stage.stageWidth;

            // Slide 1 animeert naar rechts
            tween_2.animate("x", 200);
        }

        // Slide 2 moet op x-positie 0 komen in elk geval
        tween_1 = new Tween(slide_2, TIME, starling.animation.Transitions.EASE_OUT);
        tween_1.animate("x", 0);

        /// Bij oncomplete wordt de eerste slide terug onzichtbaar gezet en de x-positie terug naar 0
        tween_1.onComplete = function():void{slide_1.visible = false; tween_1 = null;}
        tween_2.onComplete = function():void{tween_2 = null}

        // toevoegen aan de juggler
        Starling.juggler.add(tween_1);
        Starling.juggler.add(tween_2);
    }

    private static function slideV(slide_1:Slide, slide_2:Slide):void{
        trace("vertical slide");

        // Zichtbaar zetten beide slides
        slide_1.visible = true;
        slide_2.visible = true;

        // Tween voor slide die nu zichtbaar is
        tween_2 = new Tween(slide_1, TIME, starling.animation.Transitions.EASE_OUT);

        // Welke kant gaan we op?
        if(AppModel.getInstance().direction == AppModel.RIGHT){

            // Slide 2 staat rechts buiten scherm en animaart naar links
            slide_2.y = Starling.current.stage.stageHeight;

            // Slide 1 animeert naar boven
            tween_2.animate("y", -200);
        }
        else{

            // Slide 2 staat links buiten scherm
            slide_2.y = -Starling.current.stage.stageHeight;

            // Slide 1 animeert naar onder
            tween_2.animate("y", 200);
        }

        // Slide 2 moet op x-positie 0 komen in elk geval
        tween_1 = new Tween(slide_2, TIME, starling.animation.Transitions.EASE_OUT);
        tween_1.animate("y", 0);

        /// Bij oncomplete wordt de eerste slide terug onzichtbaar gezet en de x-positie terug naar 0
        tween_1.onComplete = function():void{slide_1.visible = false; tween_1 = null;}
        tween_2.onComplete = function():void{tween_2 = null}

        // toevoegen aan de juggler
        Starling.juggler.add(tween_1);
        Starling.juggler.add(tween_2);
    }

    public static function zoomfade(slide_1:Slide, slide_2:Slide):void{

        slide_1.visible = true;
        slide_2.visible = true;

        slide_2.scaleX = slide_2.scaleY = 2.5;

        slide_2.x = -900;
        slide_2.y = -400;

        slide_2.alpha = 0;

        tween_1 = new Tween(slide_2, TIME, starling.animation.Transitions.EASE_OUT);
        tween_1.animate("x", 0);
        tween_1.animate("y", 0);
        tween_1.animate("alpha", 1);
        tween_1.animate("scaleX", 1);
        tween_1.animate("scaleY", 1);

        Starling.juggler.add(tween_1);

    }

}
}
