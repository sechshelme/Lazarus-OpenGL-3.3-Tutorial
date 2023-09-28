#version 420

#extension GL_ARB_explicit_uniform_location : enable

in vec3 col;

out vec4 color;

void main()
{
  color = vec4(col, 1.0);
}
