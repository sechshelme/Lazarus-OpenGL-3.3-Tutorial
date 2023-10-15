#version 330

layout (location = 0) in vec3 inPos; // Vertex-Koordinaten
layout (location = 1) in vec3 inCol; // Farbe

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  Color = vec4(inCol, 1.0);
}
