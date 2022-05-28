#version 330

in vec4 Color;

out vec4 FragColor;

void main()
{
  vec4 cc;
  float c = (Color.r + Color.g + Color.b) / 3;
  cc.r = c;
  cc.g = c;
  cc.b = c;
  FragColor = cc;
}
