#version 330

in vec4 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0.st / UV0.w );
//  FragColor = texture( Sampler, UV0.st / UV0.w );
//  FragColor = texture2DProj( Sampler, UV0 );
}
