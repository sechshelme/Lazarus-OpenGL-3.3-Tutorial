#version 400

in vec2 UV0;
in vec2 TextureCoord[4];
in vec2 TexCoord;

out vec4 outColor;  // Ausgegebene Farbe.

uniform sampler2D Sampler;


in vec3 color;

void main(void)
{
  vec2 tmp = UV0;

tmp.x += 0.5;
tmp.y += 0.5;

  outColor = texture( Sampler, tmp );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
//  outColor = vec4(color, 1.0);
}
