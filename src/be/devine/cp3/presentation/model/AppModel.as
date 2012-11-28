/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 28/11/12
 * Time: 00:26
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.model {
import be.devine.cp3.presentation.SlideVO;

import starling.events.Event;

import starling.events.EventDispatcher;

public class AppModel extends EventDispatcher{

    /**************************************************************************************************************************************
     ************************************* PROPERTIES *************************************************************************************
     **************************************************************************************************************************************/

    public static const DATA_CHANGED:String = "dataChanged";
    public static const MENU_STATE_CHANGED:String = "menuStringChanged";
    public static const XML_CHANGED:String = "xmlChanged";

    private var _vectorSlides:Vector.<SlideVO>;
    private var _menuVisible:Boolean = false;
    private var _xmlPath:String;

    private static var _instance:AppModel;

    //Constructor
    public function AppModel(e:Enforcer) {
        if(e == null){
            throw new Error("Use .getInstance()");
        }
        trace("[AppModel] Construct");
    }

    /**************************************************************************************************************************************
     ************************************* METHODS ****************************************************************************************
     **************************************************************************************************************************************/

    public static function getInstance():AppModel{
        if(_instance == null){
            _instance = new AppModel(new Enforcer());
        }
        return _instance;
    }

    public function goToNext():void{

    }

    public function goToPrev():void{

    }

    /**************************************************************************************************************************************
     ************************************* GETTERS - SETTERS ******************************************************************************
     **************************************************************************************************************************************/

    public function get xmlPath():String {
        return _xmlPath;
    }

    public function set xmlPath(value:String):void {
        if(_xmlPath != value){
            _xmlPath = value;
            dispatchEvent(new Event(XML_CHANGED));
        }
    }
}
}

// Singleton enforcer
internal class Enforcer{}