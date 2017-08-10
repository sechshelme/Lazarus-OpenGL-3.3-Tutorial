#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
layout (location = 11) in vec3 inCol; // Farbe

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

uniform mat4 mat;                     // Matrix von Uniform

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  Color = vec4(inCol, 1.0);
}
