#version 330

#define LightPos vec3(100.0, 100.0, 50.0)
#define ambient  vec3(0.1, 0.1, 0.1)

uniform sampler2D Sampler[2];


// Daten vom Vertex-Shader
in Data {
  vec3 pos;
  vec3 Normal;
  vec2 UV;
} DataIn;

out vec4 outColor;  // ausgegebene Farbe

vec4 light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  vec3 c  = vec3(clamp(d, 0.0, 1.0));
  return vec4(c, 1.0);
}

void main(void)
{
  outColor = vec4(ambient, 1.0);
  vec3 n = DataIn.Normal + normalize(texture2D(Sampler[1], DataIn.UV).rgb * 2.0 - 1.0);
  vec4 colRed   = light(LightPos - DataIn.pos, n)  * texture( Sampler[0], DataIn.UV );
  outColor += colRed;
}
