/**
 * Created with IntelliJ IDEA.
 * User: Sabatino
 * Date: 01/12/12
 * Time: 09:21
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation.interfaces {
/**
 * Voor klasses waar resize functionaliteit verplicht is
 */
public interface IResizable {
    /**
     * Resize funcionaliteit
     * @param w Number (stage.stageWidth)
     * @param h Number (stage.stageHeight)
     */
    function resize(w:Number, h:Number):void;
}
}
