#version 330

in vec2 UV0;
in vec2 UV1;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;

out vec4 FragColor;

void main()
{
  vec4 tex = texture( Sampler1, UV1 );
  tex = 1.0 - tex;
  tex.a = 1.0;
  FragColor = texture( Sampler0, UV0 ) * tex;
}
