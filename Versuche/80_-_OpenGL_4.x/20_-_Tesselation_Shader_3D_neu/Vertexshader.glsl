#version 400

layout (location = 0) in vec3 inPos; // Vertex-Koordinaten
layout (location = 1) in vec2 inTex; // Textur-Koordinaten

out vec2 TexCoord;
out vec2 UV0;

uniform mat4 Matrix;                  // Matrix für die Drehbewegung



void main(void)
{
  gl_Position = vec4(inPos, 1.0);
 //  gl_Position = Matrix * gl_Position;

  TexCoord = inTex;
  UV0 = inTex;
}
