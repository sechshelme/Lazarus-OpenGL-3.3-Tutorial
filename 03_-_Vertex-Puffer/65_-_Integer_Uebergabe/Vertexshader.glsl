#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
layout (location = 11) in int  inCol; // Farb-Index

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  vec3 c;

  switch (inCol)
  {
    case 0:  c = vec3(1.0, 0.0, 0.0);
             break;
    case 1:  c = vec3(0.0, 1.0, 0.0);
             break;
    case 2:  c = vec3(0.0, 0.0, 1.0);
             break;
  }

  Color = vec4(c, 1.0);
}
