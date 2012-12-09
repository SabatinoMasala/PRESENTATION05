package be.devine.cp3.presentation {
public class Utils {

    // Converteer een string naar een uint ("#FF0000" naar 0xFF0000)
    public static function str_to_uint(str:String):uint{
        if(str == "") return 0xFFFFFF;
        return uint("0x"+str.substr(1));
    }
}
}
