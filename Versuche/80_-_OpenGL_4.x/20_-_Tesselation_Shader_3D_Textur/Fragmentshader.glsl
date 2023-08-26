#version 400

in vec2 UV0;
in vec2 TextureCoord[4];
in vec2 TexCoord;

out vec4 outColor;  // Ausgegebene Farbe.

uniform sampler2D Sampler;


in vec3 color;

void main(void)
{
  outColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
//  outColor = texture( Sampler, TexCoord );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
//  outColor = texture( Sampler, TextureCoord[0] );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
//  outColor = vec4(color, 1.0);
}
