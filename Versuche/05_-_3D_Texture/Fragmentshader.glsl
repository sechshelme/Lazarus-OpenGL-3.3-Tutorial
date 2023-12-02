#version 330

in vec3 UV0;

uniform sampler3D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );
//  FragColor = texture( Sampler, vec3(UV0.xy, 0) );
//  FragColor = texture( Sampler, vec3(1,1,1) );
}
