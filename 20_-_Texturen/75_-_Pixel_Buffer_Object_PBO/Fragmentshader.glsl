#version 330

in vec2 UV0;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;

out vec4 FragColor;

void main()
{
  FragColor = (texture( Sampler0, UV0 ) + texture( Sampler1, UV0 )) / 2;
}
