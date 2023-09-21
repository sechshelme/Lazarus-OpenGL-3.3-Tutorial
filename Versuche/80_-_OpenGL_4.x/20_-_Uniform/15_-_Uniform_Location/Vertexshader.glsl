#version 330
#extension GL_ARB_explicit_uniform_location : require

layout (location =  0) in vec3 inPos;    // Vertex-Koordinaten
layout (location =  8) uniform mat4x4 matrix;  // Richtung von Uniform
layout (location = 10) uniform float x;  // Richtung von Uniform
layout (location = 11) uniform float y;
 
void main(void)
{
  vec3 pos;
  pos.x = inPos.x + x;
  pos.y = inPos.y + y;
  pos.z = inPos.z;
  gl_Position = matrix * vec4(pos, 1.0);
}
