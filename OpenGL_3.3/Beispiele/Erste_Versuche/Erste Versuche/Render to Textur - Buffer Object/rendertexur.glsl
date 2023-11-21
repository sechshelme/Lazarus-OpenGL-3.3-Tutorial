$vertex
#version 330

layout (location = 0) in vec3 inPos;
layout (location = 2) in vec3 inColor;

out vec4 Color;

uniform mat4 Matrix;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  Color = vec4(inColor, 1.0);
}


$fragment
#version 330
in vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = Color;
}
