#version 330

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

in vec3 Color;

out vec4 FragColor;

void main()
{
//  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
  FragColor = vec4(Color, 1.0);
}
