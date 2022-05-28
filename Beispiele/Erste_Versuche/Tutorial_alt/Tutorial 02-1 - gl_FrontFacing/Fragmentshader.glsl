#version 330

in vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  if  (gl_FrontFacing)
  {
    outColor = Color;
  }
  else
  {
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
  }
}
