#version 330

layout (location = 10) in vec2 inPos;     // Vertex-Koordinaten, nur XY.
layout (location = 11) in float inCol;    // Farbe, es kommt nur Rot.

out vec4 Color;                           // Farbe, an Fragment-Shader übergeben.

void main(void)
{
  gl_Position = vec4(inPos, 0.0, 1.0);    // Z ist immer 0.0
  Color = vec4(inCol, 0.0, 0.0, 1.0);     // Der Rot- und Grün - Teil, ist 0.0
}
