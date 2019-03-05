-- date:2017/9/26
-- author:looyer
-- purpose:3D搓牌效果层, 
local gt = cc.exports.gt
-- 顶点着色器
local _vs = 
[[
attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec4 a_color;
                    

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
                                
void main()    
{                            
    gl_Position = CC_PMatrix * a_position;
    v_fragmentColor = a_color;
    v_texCoord = a_texCoord;
}
]]
---------------------------------------------------------
-- 片段着色器

local _ps = 
[[
varying vec4 v_fragmentColor;   
varying vec2 v_texCoord;    
         
void main()         
{
    vec4 v_orColor = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
    gl_FragColor = vec4(v_orColor.r, v_orColor.g, v_orColor.b, v_orColor.a);
}       
]]

local darken_ps = 
[[
varying vec4 v_fragmentColor;   
varying vec2 v_texCoord;    
         
void main()         
{
    vec4 c = texture2D(CC_Texture0, v_texCoord);  
    float greyNum = 0.65;  
    vec4 final = c;  
    final.r = c.r * greyNum;  
    final.g = c.g * greyNum;  
    final.b = c.b * greyNum;  
      
    gl_FragColor = final;  
}       
]]

local gray_ps = 
[[
varying vec4 v_fragmentColor;   
varying vec2 v_texCoord;    
         
void main()         
{
    vec4 v_orColor = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
    float gray = dot(v_orColor.rgb, vec3(0.299, 0.587, 0.114));
    gl_FragColor = vec4(gray, gray, gray, v_orColor.a);
}       
]]

local outline_ps = [[
    varying vec4 v_fragmentColor; // vertex shader传入，setColor设置的颜色
varying vec2 v_texCoord; // 纹理坐标
uniform float outlineSize; // 描边宽度，以像素为单位
uniform vec3 outlineColor; // 描边颜色
uniform vec2 textureSize; // 纹理大小（宽和高），为了计算周围各点的纹理坐标，必须传入它，因为纹理坐标范围是0~1

// 判断在这个角度上距离为outlineSize那一点是不是透明
int getIsStrokeWithAngel(float angel)
{
    int stroke = 0;
    float rad = angel * 0.01745329252; // 这个浮点数是 pi / 180，角度转弧度
    vec2 unit = 1.0 / textureSize.xy;//单位坐标
    vec2 offset = vec2(outlineSize * cos(rad) * unit.x, outlineSize * sin(rad) * unit.y); //偏移量
    float a = texture2D(CC_Texture0, v_texCoord + offset).a;
    if (a >= 0.5)// 我把alpha值大于0.5都视为不透明，小于0.5都视为透明
    {
        stroke = 1;
    }
    return stroke;
}

void main()
{
    vec4 myC = texture2D(CC_Texture0, v_texCoord); // 正在处理的这个像素点的颜色
    if (myC.a >= 0.5) // 不透明，不管，直接返回
    {
        gl_FragColor = v_fragmentColor * myC;
        return;
    }
    // 这里肯定有朋友会问，一个for循环就搞定啦，怎么这么麻烦！其实我一开始也是用for的，但后来在安卓某些机型（如小米4）会直接崩溃，查找资料发现OpenGL es并不是很支持循环，while和for都不要用
    int strokeCount = 0;
    strokeCount += getIsStrokeWithAngel(0.0);
    strokeCount += getIsStrokeWithAngel(30.0);
    strokeCount += getIsStrokeWithAngel(60.0);
    strokeCount += getIsStrokeWithAngel(90.0);
    strokeCount += getIsStrokeWithAngel(120.0);
    strokeCount += getIsStrokeWithAngel(150.0);
    strokeCount += getIsStrokeWithAngel(180.0);
    strokeCount += getIsStrokeWithAngel(210.0);
    strokeCount += getIsStrokeWithAngel(240.0);
    strokeCount += getIsStrokeWithAngel(270.0);
    strokeCount += getIsStrokeWithAngel(300.0);
    strokeCount += getIsStrokeWithAngel(330.0);

    if (strokeCount > 0) // 四周围至少有一个点是不透明的，这个点要设成描边颜色
    {
        myC.rgb = outlineColor;
        myC.a = 1.0;
    }

    gl_FragColor = v_fragmentColor * myC;
}
]]

 gt.MyShader = {}

local GLProgram_VERTEX = 
    {
        VERTEX_ATTRIB_POSITION = 0,
        VERTEX_ATTRIB_COLOR = 1 ,
        VERTEX_ATTRIB_TEX_COORD = 2 ,
        VERTEX_ATTRIB_TEX_COORD1 = 3 ,
        VERTEX_ATTRIB_TEX_COORD2 = 4 ,
        VERTEX_ATTRIB_TEX_COORD3 = 5 ,
        VERTEX_ATTRIB_NORMAL = 6 ,
        VERTEX_ATTRIB_BLEND_WEIGHT = 7 ,
        VERTEX_ATTRIB_BLEND_INDEX = 8 ,
        VERTEX_ATTRIB_MAX = 9 ,

        --// backward compatibility
        VERTEX_ATTRIB_TEX_COORDS = 2,
    }


-- 通过图片取得纹理id，和该纹理在plist图中的纹理坐标范围
 function gt.MyShader.setNodeDarken(node)
	if node then
    print(type(node))
        local p =  cc.GLProgram:createWithByteArrays(_vs, darken_ps)
		p:updateUniforms()
        p:bindAttribLocation("a_position", GLProgram_VERTEX.VERTEX_ATTRIB_POSITION)
		p:bindAttribLocation("a_color", GLProgram_VERTEX.VERTEX_ATTRIB_COLOR)
		p:bindAttribLocation("a_texCoord", GLProgram_VERTEX.VERTEX_ATTRIB_TEX_COORDS)
        tolua.cast(node,"cc.Node")
		node:setGLProgram(p)

    end
end


 function gt.MyShader.setNodeGray(node)
	if node then
    print(type(node))
        local p =  cc.GLProgram:createWithByteArrays(_vs, gray_ps)
		p:updateUniforms()
        p:bindAttribLocation("a_position", GLProgram_VERTEX.VERTEX_ATTRIB_POSITION)
		p:bindAttribLocation("a_color", GLProgram_VERTEX.VERTEX_ATTRIB_COLOR)
		p:bindAttribLocation("a_texCoord", GLProgram_VERTEX.VERTEX_ATTRIB_TEX_COORDS)
        tolua.cast(node,"cc.Node")
		node:setGLProgram(p)

    end
end


 function gt.MyShader.setNodeRestore(node)
	if node then
    print(type(node))
        local p =  cc.GLProgram:createWithByteArrays(_vs, _ps)
		p:updateUniforms()
        p:bindAttribLocation("a_position", GLProgram_VERTEX.VERTEX_ATTRIB_POSITION)
		p:bindAttribLocation("a_color", GLProgram_VERTEX.VERTEX_ATTRIB_COLOR)
		p:bindAttribLocation("a_texCoord", GLProgram_VERTEX.VERTEX_ATTRIB_TEX_COORDS)
        tolua.cast(node,"cc.Node")
		node:setGLProgram(p)

    end
end


function gt.MyShader.setNodeRestore(node)
	if node then
    print(type(node))
        local p =  cc.GLProgram:createWithByteArrays(_vs, _ps)
		p:updateUniforms()
        p:bindAttribLocation("a_position", GLProgram_VERTEX.VERTEX_ATTRIB_POSITION)
		p:bindAttribLocation("a_color", GLProgram_VERTEX.VERTEX_ATTRIB_COLOR)
		p:bindAttribLocation("a_texCoord", GLProgram_VERTEX.VERTEX_ATTRIB_TEX_COORDS)
        tolua.cast(node,"cc.Node")
		node:setGLProgram(p)

    end
end


