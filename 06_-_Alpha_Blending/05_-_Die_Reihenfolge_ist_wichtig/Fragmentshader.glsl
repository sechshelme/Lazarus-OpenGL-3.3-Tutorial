#version 330

uniform vec4 Color;
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = Color;
}
