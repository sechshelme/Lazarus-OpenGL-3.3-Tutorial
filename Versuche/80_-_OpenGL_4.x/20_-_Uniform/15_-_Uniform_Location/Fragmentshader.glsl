#version 450

layout(location = 20) uniform vec3 Color;  // Farbe von Uniform

out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Color, 1.0);
}
