#version 330

#define ambient vec3(0.2, 0.2, 0.2)
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

// Daten vom Vertex-Shader
in Data {
  vec3 pos;
  vec3 Normal;
} DataIn;

uniform bool RedOn;
uniform bool GreenOn;
uniform bool BlueOn;

uniform vec3 RedLightPos;
uniform vec3 GreenLightPos;
uniform vec3 BlueLightPos;

out vec4 outColor;  // ausgegebene Farbe

float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);
}

void main(void) {
  outColor = vec4(ambient, 1.0);
  if (RedOn) {
    vec3 colRed   = light(RedLightPos   - DataIn.pos, DataIn.Normal) * red;
    outColor.rgb += colRed;
  }
  if (GreenOn) {
    vec3 colGreen = light(GreenLightPos - DataIn.pos, DataIn.Normal) * green;
    outColor.rgb += colGreen;
  }
  if (BlueOn) {
    vec3 colBlue  = light(BlueLightPos  - DataIn.pos, DataIn.Normal) * blue;
    outColor.rgb += colBlue;
  }
}
