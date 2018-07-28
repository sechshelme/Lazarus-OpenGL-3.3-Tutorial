#version 330

in vec2 UV[4];

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV[0]);  // Die Farbe aus der Textur anhand der Koordinten auslesen.

  FragColor += texture( Sampler, UV[1]);
  FragColor += texture( Sampler, UV[2]);
  FragColor += texture( Sampler, UV[3]);
  FragColor += vec4(0.1, 0.1, 0.1, 0.1);
}
