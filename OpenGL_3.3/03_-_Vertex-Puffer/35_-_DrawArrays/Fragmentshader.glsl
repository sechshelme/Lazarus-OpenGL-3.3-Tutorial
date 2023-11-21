#version 330

uniform vec3 Color;  // Farbe von Uniform
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Color, 1.0); // Das 1.0 ist der Alpha-Kanal, hat hier keine Bedeutung.
}
