#version 330

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
//  if (UV0.x <= 1.0) {
    FragColor = texture( Sampler, UV0 );
//  } else {
//    FragColor = texture( Sampler, vec2(1.0, UV0.y));
//  }
}
