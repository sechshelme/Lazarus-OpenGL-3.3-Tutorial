#version 450 core

layout (location = 0) in vec3 vPosition;
layout (location = 1) in vec3 vColor;

out vec3 col;

void main()
{
  gl_Position = vec4(vPosition, 1);
  col = vColor;
}
