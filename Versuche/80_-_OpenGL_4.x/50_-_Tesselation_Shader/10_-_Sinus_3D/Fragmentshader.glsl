#version 330

out vec4 outColor;  // Ausgegebene Farbe.

in vec3 col;

void main(void)
{
  outColor = vec4(col, 1.0);
//  outColor = vec4(0,0,0, 1.0);
}
