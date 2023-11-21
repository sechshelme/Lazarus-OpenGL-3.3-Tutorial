#version 330

layout (location = 10) in vec2 inPos; // Vertex-Koordinaten in 2D
uniform float x;                      // Richtung von Uniform
uniform float y;
 
void main(void)
{
  vec2 pos = inPos;
  pos.x = pos.x + x;
  pos.y = pos.y + y;
  gl_Position = vec4(pos, 0.0, 1.0);  // Der zweiter Parameter (Z) auf 0.0
}
