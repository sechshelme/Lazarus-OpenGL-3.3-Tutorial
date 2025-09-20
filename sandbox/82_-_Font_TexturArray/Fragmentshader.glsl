#version 330

in vec2 UV0;
in float layer;

uniform sampler2DArray Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, vec3(UV0, layer));  // Die Farbe aus der Textur anhand der Koordinten auslesen.
}
