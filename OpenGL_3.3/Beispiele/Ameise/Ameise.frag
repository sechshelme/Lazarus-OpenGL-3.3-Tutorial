#version 330

in vec2 UV0;
in float Layer;

uniform sampler2DArray Sampler;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, vec3(UV0, Layer));
}
