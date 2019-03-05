--region *.lua
--Date 2018/1/18
--Creator Wenliang_Hu
--Change node to gray or remove gray

local ShaderGrayEff = {
        vertDefaultSource = [[
        attribute vec4 a_position; 
        attribute vec2 a_texCoord; 
        attribute vec4 a_color; 
        #ifdef GL_ES  
        varying lowp vec4 v_fragmentColor;
        varying mediump vec2 v_texCoord;
        #else                     
        varying vec4 v_fragmentColor; 
        varying vec2 v_texCoord; 
        #endif
        void main() 
        {
        gl_Position = CC_PMatrix * a_position; 
        v_fragmentColor = a_color;
        v_texCoord = a_texCoord;
        }]],
        pszFragSource2 = [[
        #ifdef GL_ES 
        precision mediump float; 
        #endif
        uniform sampler2D u_texture; 
        varying vec2 v_texCoord; 
        varying vec4 v_fragmentColor;
        uniform vec2 pix_size;
        void main(void) 
        { 
        vec4 sum = vec4(0, 0, 0, 0); 
        sum += texture2D(u_texture, v_texCoord - 4.0 * pix_size) * 0.05;
        sum += texture2D(u_texture, v_texCoord - 3.0 * pix_size) * 0.09;
        sum += texture2D(u_texture, v_texCoord - 2.0 * pix_size) * 0.12;
        sum += texture2D(u_texture, v_texCoord - 1.0 * pix_size) * 0.15;
        sum += texture2D(u_texture, v_texCoord                 ) * 0.16;
        sum += texture2D(u_texture, v_texCoord + 1.0 * pix_size) * 0.15;
        sum += texture2D(u_texture, v_texCoord + 2.0 * pix_size) * 0.12;
        sum += texture2D(u_texture, v_texCoord + 3.0 * pix_size) * 0.09;
        sum += texture2D(u_texture, v_texCoord + 4.0 * pix_size) * 0.05;
        gl_FragColor = sum;
        } ]],
 
        --变灰
        psGrayShader = [[
        #ifdef GL_ES 
        precision mediump float; 
        #endif 
        varying vec4 v_fragmentColor; 
        varying vec2 v_texCoord; 
        void main(void) 
        { 
        vec4 c = texture2D(CC_Texture0, v_texCoord); 
        gl_FragColor.xyz = vec3(0.3*c.r + 0.15*c.g +0.11*c.b); 
        gl_FragColor.w = c.w; 
        } ]],
 
        --移除变灰
        psRemoveGrayShader = [[
        #ifdef GL_ES 
        precision mediump float; 
        #endif 
        varying vec4 v_fragmentColor; 
        varying vec2 v_texCoord; 
        void main(void) 
        { 
        gl_FragColor = texture2D(CC_Texture0, v_texCoord); 
        } ]],
 
        pszFragSource1 = [[
        #ifdef GL_ES 
        precision mediump float; 
        #endif 
        varying vec4 v_fragmentColor; 
        varying vec2 v_texCoord; 
        void main(void) 
        { 
        vec4 c = texture2D(CC_Texture0, v_texCoord);
        gl_FragColor.xyz = vec3(0.3*c.r + 0.15*c.g +0.11*c.b); 
        gl_FragColor.w = c.w; 
        } ]],
}
 
function ShaderGrayEff:init()
    local pGrayProgram = cc.GLProgram:createWithByteArrays(self.vertDefaultSource,self.psGrayShader)
    pGrayProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    pGrayProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    pGrayProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pGrayProgram:link()
    pGrayProgram:use()
    pGrayProgram:updateUniforms()
    cc.GLProgramCache:getInstance():addGLProgram(pGrayProgram,"pGrayProgram")
 
 
    local pRemoveGrayProgram = cc.GLProgram:createWithByteArrays(self.vertDefaultSource,self.psRemoveGrayShader)
    pRemoveGrayProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    pRemoveGrayProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    pRemoveGrayProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pRemoveGrayProgram:link()
    pRemoveGrayProgram:use()
    pRemoveGrayProgram:updateUniforms()
    cc.GLProgramCache:getInstance():addGLProgram(pRemoveGrayProgram,"pRemoveGrayProgram")
end
 
 --变灰的
function ShaderGrayEff:addGrayNode(node)
    local pProgram = cc.GLProgram:createWithByteArrays(self.vertDefaultSource,self.psGrayShader)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pProgram:link()
    pProgram:use()
    pProgram:updateUniforms()
    node:setGLProgram(pProgram)
end
 
function ShaderGrayEff:removeGrayNode(node)
    local pProgram = cc.GLProgram:createWithByteArrays(self.vertDefaultSource,self.psRemoveGrayShader)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pProgram:link()
    pProgram:use()
    pProgram:updateUniforms()
    node:setGLProgram(pProgram)
end
 
--遍历变灰
function ShaderGrayEff:setGrayAndChild(node,isNotRecursive)
    if node == nil then
        return
    end
    local array = node:getChildren()
    for key, var in pairs(array) do
        if var.setGLProgram then
            var:setGLProgram(cc.GLProgramCache:getInstance():getGLProgram("pGrayProgram"))
        end
    end
    if isNotRecursive ~= true then
        --children
        local array = node:getChildren()
        for key, var in pairs(array) do
            self:setGrayAndChild(var)
        end
    end
end
 
--遍历取消变灰
function ShaderGrayEff:setRemoveGrayAndChild(node,isNotRecursive)
    if node == nil then
        return
    end
    local array = node:getChildren()
    for key, var in pairs(array) do
        if var.setGLProgram then
            var:setGLProgram(cc.GLProgramCache:getInstance():getGLProgram("pRemoveGrayProgram"))
        end
    end
    if isNotRecursive ~= true then
        --children
        local array = node:getChildren()
        for key, var in pairs(array) do
            self:setRemoveGrayAndChild(var)
        end
    end
 
end
 
ShaderGrayEff:init()
 
return ShaderGrayEff

--endregion
