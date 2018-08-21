#version 330

#define ambient vec3(0.2, 0.2, 0.2)

// Daten vom Vertex-Shader
in Data {
  vec3 pos;
  vec3 Normal;
  vec2 UV0;
} DataIn;

uniform vec3 RedLightPos = vec3(10.0, 0.0, 0.0);

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.


out vec4 outColor;  // ausgegebene Farbe

float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);
}

void main(void) {
  vec3 c = ambient;
  c += light(RedLightPos   - DataIn.pos, DataIn.Normal);
  c *= texture( Sampler, DataIn.UV0 ).rgb;

//  colRed   = texture( Sampler, DataIn.UV0 ).rgb;
  outColor.rgb = c;
  outColor.a = 1.0;
}
