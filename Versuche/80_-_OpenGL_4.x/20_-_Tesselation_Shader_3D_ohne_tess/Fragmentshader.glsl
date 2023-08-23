#version 400

in vec2 UV0;

out vec4 outColor;  // Ausgegebene Farbe.

uniform sampler2D Sampler;


in vec3 color;

void main(void)
{
  outColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
//  outColor = vec4(color, 1.0);
}
