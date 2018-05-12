#version 330

in vec3 UV0;

uniform samplerCube Sampler;

out vec4 FragColor;

void main()
{
//  FragColor = texture(Sampler, UV0);
  FragColor = textureCube(Sampler, UV0);
}
