#version 330

// Vektor-Daten
layout (location = 0) in vec2 inPos;

void main(void)
{
  gl_Position = vec4(inPos, 0.0, 1.0);
}
