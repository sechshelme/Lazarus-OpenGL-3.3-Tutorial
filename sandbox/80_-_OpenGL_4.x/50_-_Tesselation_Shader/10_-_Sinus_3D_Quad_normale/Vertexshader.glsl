#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in float inArea;

out float vArea;

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  gl_Position.xz *= 0.5;

  vArea = inArea;
}
