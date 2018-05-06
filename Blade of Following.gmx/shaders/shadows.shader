//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D mask;
uniform float bright_x;
uniform float bright_y;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
    
    
    gl_FragColor.rgb += vec3(
                        (texture2D( mask, vec2(v_vTexcoord.x, v_vTexcoord.y + 0.0005)).r - texture2D( mask, vec2(v_vTexcoord.x, v_vTexcoord.y - 0.0005)).r) * bright_y +
                        (texture2D( mask, vec2(v_vTexcoord.x + 0.0005, v_vTexcoord.y)).r - texture2D( mask, vec2(v_vTexcoord.x - 0.0005, v_vTexcoord.y)).r) * bright_x
                            );
}

