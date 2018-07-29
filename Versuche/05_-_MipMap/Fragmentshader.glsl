#version 330

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0, -5 );
// FragColor = vec4(1.0);
}
