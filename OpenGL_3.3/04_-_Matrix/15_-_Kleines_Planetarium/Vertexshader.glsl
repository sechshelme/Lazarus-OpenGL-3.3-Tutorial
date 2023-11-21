#version 330

layout (location = 10) in vec2 inPos; // Vertex-Koordinaten in 2D.
layout (location = 11) in vec3 inCol; // Farbe

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben.

uniform mat3 mat;                     // Matrix von Uniform.


void main(void)
{
  gl_Position.xyw = mat * vec3(inPos, 1.0);
  gl_Position.z   = 0.0;
  Color = vec4(inCol, 1.0);
}
