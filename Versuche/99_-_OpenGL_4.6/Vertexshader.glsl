#version 450 core

layout (location = 0) in vec4 vPosition;

void main()
{
  gl_Position = vPosition;
}
