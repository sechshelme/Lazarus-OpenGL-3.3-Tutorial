#version 410 core

in float Height;

out vec4 FragColor;

void main()
{
  float h = Height;
  FragColor = vec4(h, h, h, 1.0);
}
