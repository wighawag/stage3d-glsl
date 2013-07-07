/****
* 
****/

package flash.display3D;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.display3D.Context3D;
class Context3DUtils {

    /**
    * Common API for both cpp and flash to set the render callback
    **/
    inline static public function setRenderCallback(context3D : Context3D, func : Event -> Void) : Void{
        #if flash
        flash.Lib.current.addEventListener(flash.events.Event.ENTER_FRAME, func);
        #elseif (cpp || neko || js)
        context3D.setRenderMethod(func);
        #end
    }


    /**
    * Common API for both cpp and flash to remove the render callback
    **/
    inline static public function removeRenderCallback(context3D : Context3D, func : Event -> Void) : Void{
        #if flash
        flash.Lib.current.removeEventListener(flash.events.Event.ENTER_FRAME, func);
        #elseif (cpp || neko || js)
        context3D.removeRenderMethod(func);
        #end
    }
}

