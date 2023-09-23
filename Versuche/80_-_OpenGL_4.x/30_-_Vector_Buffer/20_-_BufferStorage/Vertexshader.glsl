#version 420

#extension GL_ARB_explicit_uniform_location : enable

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;

out vec3 col;

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  col = inCol;
}
