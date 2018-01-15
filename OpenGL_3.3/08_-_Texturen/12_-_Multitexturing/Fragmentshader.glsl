#version 330

in vec2 UV0;
in vec2 UV1;

uniform sampler2D Sampler[2];                      // 2 Sampler deklarieren.

out vec4 FragColor;

void main()
{
  FragColor = (texture( Sampler[0], UV0 ) +        // Die beiden Farben zusammenzählen und anschliessend durch 2 teilen.
               texture( Sampler[1], UV1 )) / 2.0;
}
