#version 330

in vec2 UV0;

uniform sampler2D Sampler0;
uniform usampler2D stencil_tex;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler0, UV0 );
  uint stencil = texture( stencil_tex, UV0 );
}
