/****
* 
****/

package flash.display3D.shaders;

#if flash
typedef Shader = flash.utils.ByteArray;
#elseif (cpp || neko)
import openfl.gl.GL;
typedef Shader = openfl.gl.GLShader;
#elseif js
import browser.gl.GL;
typedef Shader = browser.gl.GLShader;
 #end
