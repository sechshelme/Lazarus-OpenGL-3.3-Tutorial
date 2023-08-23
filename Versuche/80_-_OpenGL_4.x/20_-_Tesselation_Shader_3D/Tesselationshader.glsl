#version 400

layout(triangles) in;

uniform mat4 Matrix;                  // Matrix für die Drehbewegung

uniform sampler2D heightMap;  // the texture corresponding to our height map

out vec3 color;

// varying input from vertex shader
in vec2 TexCoord[];
// varying output to evaluation shader
//out vec2 TextureCoord[];

void main() {
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

  vec2 tex  = (gl_TessCoord.x * TexCoord[0]) +
              (gl_TessCoord.y * TexCoord[1]) +
              (gl_TessCoord.z * TexCoord[2]);

//  float Height = texture(heightMap, tex).r;
  float Height = texture(heightMap, TexCoord[0]).g;

//  Height=0.5;
  Height*=1;

 gl_Position.z += Height;

 gl_Position = Matrix * gl_Position;

  color = gl_TessCoord;
}
