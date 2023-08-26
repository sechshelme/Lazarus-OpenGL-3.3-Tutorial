#version 400

layout(triangles) in;

uniform mat4 Matrix;

uniform sampler2D heightMap;

out vec3 color;

// varying input from vertex shader
in vec2 TexCoord[32];
// varying output to evaluation shader
out vec2 TextureCoord[4];

void main() {
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

//  float Height = texture(heightMap, tex).r;
//  float Height = texture(heightMap, TexCoord[0]).g;

  float Height = 0.5;

//  Height=0.5;
  Height*=1;

 gl_Position.z += Height;

 gl_Position = Matrix * gl_Position;

  color = gl_TessCoord;

    TextureCoord[0] = TexCoord[0];
    TextureCoord[1] = TexCoord[1];
    TextureCoord[2] = TexCoord[2];
    TextureCoord[3] = TexCoord[3];
}
