#version 330

layout (location = 10) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 11) in vec4 inCol;    // Farbe inklusive Alpha
uniform mat4 mat;                        // Matrix von Uniform

out vec4 Color;                          // Farbe, an Fragment-Shader übergeben


void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);  // Vektoren mit der Matrix multiplizieren.
  Color = inCol;
}
