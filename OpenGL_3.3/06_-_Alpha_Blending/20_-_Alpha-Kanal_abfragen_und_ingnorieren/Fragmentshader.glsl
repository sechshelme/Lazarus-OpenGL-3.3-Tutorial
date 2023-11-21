#version 330

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
  vec4 c = texture( Sampler, UV0 );
  if (c.a > 0.5) {
    FragColor =  c;
  } else {
    discard; // Wen transparent, Pixel nicht ausgeben.
  }
}
