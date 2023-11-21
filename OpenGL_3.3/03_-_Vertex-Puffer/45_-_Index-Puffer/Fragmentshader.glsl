#version 330

out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  vec3 col = vec3(0.0, 1.0, 1.0); // Mint
  outColor = vec4(col, 1.0);
}
