#version 330

in vec2 UV0;

uniform sampler2DArray Sampler;
uniform int            Layer;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, vec3(UV0, Layer) );
}
