#version 330

layout (location =  0) in vec3 inPos;
layout (location =  1) in vec2 inUV;

out vec2 UV0;

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  UV0 = inUV;
}
