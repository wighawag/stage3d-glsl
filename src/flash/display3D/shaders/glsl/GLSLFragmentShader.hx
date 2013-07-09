/****
* 
****/

package flash.display3D.shaders.glsl;

import flash.Vector;
import flash.display3D.textures.Texture;
import flash.geom.Matrix3D;
import flash.display3D.Context3D;
import flash.display3D.Context3DProgramType;

class GLSLFragmentShader extends GLSLShader{

    #if (cpp || neko || js)
    private var textureCounter : Int;
    #end


    public function new(glslSource : String,
        #if (cpp || neko || js)
        ?
        #elseif glsl2agal
        ?
        #end
        agalInfo : String){
        super(Context3DProgramType.FRAGMENT, glslSource, agalInfo);
    }

    #if (cpp || neko || js)
    override public function setup(context3D : Context3D) : Void{
        super.setup(context3D);
        textureCounter = 0;
    }
    #end


    public function setTextureAt(context3D : Context3D, name : String , texture : Texture){
        #if flash
        var registerIndex = getRegisterIndexForSampler(name);
        context3D.setTextureAt( registerIndex, texture);
        #elseif (cpp || neko || js)
        context3D.setGLSLTextureAt(name, texture, textureCounter);
        textureCounter ++; // TODO improve
        #end
    }


    public function setSamplerStateAt(context3D : Context3D, name : String, wrap:Context3DWrapMode, filter:Context3DTextureFilter, mipfilter:Context3DMipFilter){
        //TODO support flash  < 11.6
        #if flash
        var registerIndex = getRegisterIndexForSampler(name);
        context3D.setSamplerStateAt( registerIndex, wrap, filter, mipfilter);
        #elseif (cpp || neko || js)
        context3D.setGLSLSamplerStateAt(name, wrap, filter, mipfilter);
        #end
    }

    override private function getRegisterIndexForUniform(name : String) : Int{
        var registerName = agalInfo.varnames.get(name);
        if(registerName == null){
            registerName = name;
        }
        return Std.parseInt(registerName.substr(2)); //fc
    }

    private function getRegisterIndexForSampler(name : String) : Int{
        var registerName = agalInfo.varnames.get(name);
        return Std.parseInt(registerName.substr(2)); //fs
    }

}
