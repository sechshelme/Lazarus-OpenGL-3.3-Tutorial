#version 330

in vec2 UV0;

uniform sampler2D myPalette;
uniform sampler2D myTexture;

out vec4 FragColor;

void main()
{
  vec4 index = texture2D(myTexture, UV0);

  FragColor = texture2D( myPalette, vec2(index.r, 0.5 ));
//  FragColor = texture( myTexture, UV0 );
}
