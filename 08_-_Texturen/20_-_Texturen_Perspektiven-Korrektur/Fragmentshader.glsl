#version 330

in Data {
  vec2 UV0;
  in vec3 UV1;
  in vec4 UV2;
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
    case 2: FragColor = textureProj( Sampler, DataIn.UV2 );
    //CR: texture2DProj does not exist in Core specification: use textureProj
  }
}
