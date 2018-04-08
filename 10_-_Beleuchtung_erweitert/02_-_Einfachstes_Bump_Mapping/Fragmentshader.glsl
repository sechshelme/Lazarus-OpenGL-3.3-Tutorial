#version 330

// Beleuchtungs-Parameter
#define LightPos vec3(100.0, 100.0, 50.0)
#define ambient  vec3(0.1, 0.1, 0.1)

// Textur-Sampler für Normal-Map
uniform sampler2D Sampler;

// Daten vom Vertex-Shader
in Data {
  vec3 pos;
  vec3 Normal;
  vec2 UV;
} DataIn;

// Farb-Ausgabe.
out vec4 outColor;

// Ein einfaches Directional-Light.
vec4 light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);
  vec3 c  = vec3(clamp(d, 0.0, 1.0));
  return vec4(c, 1.0);
}

void main(void)
{
  // Ein Ambient-Light festlegen.
  outColor = vec4(ambient, 1.0);

  // Normal-Map zu Normalen addieren.
  vec3 n   = DataIn.Normal + normalize(texture2D(Sampler, DataIn.UV).rgb * 2.0 - 1.0);

  // Einfache Lichtberechnung.
  outColor = light(LightPos - DataIn.pos, n);
}
