#version 330

out vec4 outColor;  // Ausgegebene Farbe.

in vec3 color;

void main(void)
{
  outColor = vec4(color, 1.0);
}
