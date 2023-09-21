#version 450 core

layout (location = 0) out vec4 fColor;

in vec3 col;

void main()
{
  fColor = vec4(col.xy, 1, 1.0);
}
