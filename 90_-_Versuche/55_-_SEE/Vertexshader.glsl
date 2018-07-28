#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
layout (location = 11) in vec3 inCol; // Farbe

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Frustum.
uniform vec4 Rot;                  // Rot für die Drehbewegung und Frustum.

void main(void)
{
///vec4 rot=vec4(1.0, 0.0, 0.0, 1.0);
  gl_Position = vec4(inPos, 0.0) + Rot;
  Color = vec4(inCol, 1.0);
}
