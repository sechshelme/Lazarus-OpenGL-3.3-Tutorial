#version 420

in vec3 Color;      // Farbe vom Geometrie-Shader.
out vec4 outColor;  // Ausgegebene Farbe.

void main(void)
{
  outColor = vec4(Color, 0.1);
}
