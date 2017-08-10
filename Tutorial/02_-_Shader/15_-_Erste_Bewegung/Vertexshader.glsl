#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
uniform float x;                      // Richtung von Uniform
uniform float y;
 
void main(void)
{
  vec3 pos;
  pos.x = inPos.x + x;
  pos.y = inPos.y + y;
  pos.z = inPos.z;
  gl_Position = vec4(pos, 1.0);
}
