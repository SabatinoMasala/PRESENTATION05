package be.devine.cp3.presentation.utils {
public class Utils {

    public static const IPAD:String = "iPad";

    public static var multiplicationFactor:uint = 1;
    public static var device:String;

    // Converteer een string naar een uint ("#FF0000" naar 0xFF0000)
    public static function str_to_uint(str:String):uint{
        if(str == "") return 0xFFFFFF;
        return uint("0x"+str.substr(1));
    }
}
}
