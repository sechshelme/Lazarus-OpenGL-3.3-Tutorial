#version 330

layout (location = 0) in vec3 inPos;

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
}
