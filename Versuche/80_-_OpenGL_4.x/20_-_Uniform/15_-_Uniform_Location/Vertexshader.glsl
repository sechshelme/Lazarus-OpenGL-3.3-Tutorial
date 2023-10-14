#version 450

layout (location =  0) in vec3 inPos;

layout (location =  0) uniform mat4x4 matrix;
layout (location =  1) uniform float x;
layout (location =  2) uniform float y;
 
void main(void)
{
  vec3 pos;
  pos.x = inPos.x + x;
  pos.y = inPos.y + y;
  pos.z = inPos.z;
  gl_Position = matrix * vec4(pos, 1.0);
}
