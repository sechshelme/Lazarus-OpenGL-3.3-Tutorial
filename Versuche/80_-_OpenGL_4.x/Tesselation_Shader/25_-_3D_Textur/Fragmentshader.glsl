#version 400

in vec2 TextureCoord;
in vec3 color;

out vec4 outColor;

uniform sampler2D Sampler;

void main(void)
{
  outColor = texture( Sampler, TextureCoord );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
  outColor = (outColor + vec4(color, 1.0)) / 2;
}
