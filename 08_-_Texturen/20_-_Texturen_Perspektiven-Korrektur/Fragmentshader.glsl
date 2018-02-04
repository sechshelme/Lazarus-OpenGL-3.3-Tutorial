#version 330

in Data {
  vec2 UV0;
  vec3 UV1;
} DataIn;

uniform sampler2D Sampler; // Textursampler
uniform int variante;      // Variante der Texturberechnung

out vec4 FragColor;

void main()
{
  switch (variante) {

    // Unkorrigiert
    case 0: FragColor = texture( Sampler, DataIn.UV0 );
            break;

    // Korrigiert Variante 1
    case 1: FragColor = texture( Sampler, DataIn.UV1.xy / DataIn.UV1.z );
            break;

    // Korrigiert Variante 2
    case 2: FragColor = texture2DProj( Sampler, DataIn.UV1 );
  }
}
