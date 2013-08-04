/****
* 
****/

package flash.display3D.shaders.glsl;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.VertexBuffer3D;
import flash.display3D.textures.Texture;
import flash.geom.Matrix3D;
import flash.display3D.Program3D;
import flash.display3D.Context3D;
class GLSLProgram {

    private var context3D : Context3D;

    private var nativeProgram : Program3D;

    private var vertexShader : GLSLVertexShader;
    private var fragmentShader : GLSLFragmentShader;

    public function new(context3D : Context3D) {
        this.context3D = context3D;
        nativeProgram = context3D.createProgram();
    }

    public function upload(vertexShader : GLSLVertexShader, fragmentShader : GLSLFragmentShader) : Void{
        nativeProgram.upload(vertexShader.nativeShader, fragmentShader.nativeShader);
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;
    }

    public function dispose() : Void{
        nativeProgram.dispose();
    }

    public function attach() : Void{
        context3D.setProgram(nativeProgram);

        //pass necessary constants (in case of agal)
        vertexShader.setup(context3D);
        fragmentShader.setup(context3D);
    }

    public function detach() : Void{
        context3D.setProgram(null);
    }

    public function setVertexUniformFromMatrix(name : String , matrix : Matrix3D,transposedMatrix : Bool = false) : Void{
        vertexShader.setUniformFromMatrix(context3D,name,matrix, transposedMatrix);
    }

    public function setFragmentUniformFromMatrix(name : String , matrix : Matrix3D,transposedMatrix : Bool = false) : Void{
        fragmentShader.setUniformFromMatrix(context3D,name,matrix, transposedMatrix);
    }

    public function setVertexUniformFromVector(name : String , vector : Vector<Float>) : Void{
        vertexShader.setUniformFromVector(context3D,name,vector);
    }

    public function setFragmentUniformFromVector(name : String , vector : Vector<Float>) : Void{
        fragmentShader.setUniformFromVector(context3D,name,vector);
    }

    #if (cpp || js || flash11_2)
    public function setVertexUniformFromByteArray(name : String , data : flash.utils.ByteArray, byteArrayOffset : Int) : Void{
        vertexShader.setUniformFromByteArray(context3D,name,data,byteArrayOffset);
    }
    #end

    #if (cpp || js || flash11_2)
    public function setFragmentUniformFromByteArray(name : String , data : flash.utils.ByteArray, byteArrayOffset : Int) : Void{
        fragmentShader.setUniformFromByteArray(context3D,name,data, byteArrayOffset);
    }
    #end

    //AGAL only allow texture for fragment shader
    // TODO add a function in cpp to set texture and sampler params on vertex shader
    public function setTextureAt(name : String , texture : Texture) : Void{
        fragmentShader.setTextureAt(context3D,name,texture);
    }

    #if (cpp || js || flash11_6)
    public function setSamplerStateAt(name:String, wrap:Context3DWrapMode, filter:Context3DTextureFilter, mipfilter:Context3DMipFilter):Void{
        fragmentShader.setSamplerStateAt(context3D, name, wrap, filter, mipfilter);
    }
    #end

    public function setVertexBufferAt(name : String, vertexBuffer : VertexBuffer3D, bufferOffset : Int, format : Context3DVertexBufferFormat) : Void{
        vertexShader.setVertexBufferAt(context3D,name,vertexBuffer,bufferOffset,format);
    }
}
