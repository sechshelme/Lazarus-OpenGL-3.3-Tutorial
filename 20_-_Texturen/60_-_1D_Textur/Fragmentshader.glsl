#version 330

in float UV0;

uniform sampler1D Sampler;              // Ein 1D-Sampler

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // UV0 ist nur ein Float.
}
