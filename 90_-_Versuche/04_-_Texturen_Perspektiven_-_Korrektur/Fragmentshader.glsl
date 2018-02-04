#version 330

//in vec2 UV0;
in vec4 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
//  FragColor = texture( Sampler, UV0 );
  FragColor = textureProj( Sampler, UV0 );
//CR: texture2DProj does not exist in Core specification: use textureProj
}
