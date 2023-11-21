#version 330

layout (location = 0) in vec2 inPos;
uniform mat4 mat;

void main(void)
{
  gl_Position = mat * vec4(inPos, 0.0, 1.0);
}
