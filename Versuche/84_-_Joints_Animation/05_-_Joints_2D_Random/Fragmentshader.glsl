#version 330

in vec3 vCol;

out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(vCol, 1.0);
}
