#version 330

in vec2 UV0;

//uniform sampler2D Sampler0;
uniform sampler2D Sampler0[8];

out vec4 FragColor;

void main()
{
//  FragColor = texture2D( Sampler0[0], UV0 );
  FragColor = texture( Sampler0[0], UV0 );
}
