#version 330

#define PI            3.1415

// Eine leichte Hintergrundbeleuchtung.
#define ambient       vec3(0.2, 0.15, 0.095)

// Farbe des Lichtstrahles.
#define yellow        vec3(1.0, 0.9, 0.8)

// Öffnungswinkel der Lampe
// 22.5°
#define Cutoff        cos(PI / 2 / 4)

// Lichtrichtung, brennt senkrecht in der Z-Achse.
#define spotDirection vec3(0.0, 0.0, -1.0)

// Für Abschwächung
// default 0.0
#define spotExponent  50.0

// Diese Werte entsprechen Attenuation Parametern vom alten OpenGL.
// default 1.0
#define spotAttConst  1.0
// default 0.0
#define spotAttLinear 0.1
// default 0.0
#define spotAttQuad   0.0

in Data {
  vec3 pos;
  vec3 Normal;
} DataIn;

uniform vec3 LeftLightPos;
uniform vec3 CenterLightPos;
uniform vec3 RightLightPos;

out vec4 outColor;  // ausgegebene Farbe

// Abschwächung, abhängig vom Radius des Lichtes.
float isConeAtt(vec3 LightPos) {
  vec3  lightDirection = normalize(DataIn.pos - LightPos);

  float D              = length(LightPos - DataIn.pos);
  float attenuation    = 1.0 / (spotAttConst + spotAttLinear * D + spotAttQuad * D * D);

  float angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, 0.0, 1.0);

  if(angle > Cutoff) {
    return attenuation;
  } else {
    return 0.0;
  }
}

// Abschwächung anhängig der Lichtentfernung zum Mesh.
float isConeExp(vec3 LightPos) {
  vec3  lightDirection = normalize(DataIn.pos - LightPos);

  float angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, 0.0, 1.0);

  if(angle > Cutoff) {
    return pow(angle, spotExponent);
  } else {
    return 0.0;
  }
}

// Lichtstärke anhand der Normale.
float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);
  return clamp(d, 0.0, 1.0);
}

void main(void)
{
  // Grundbeleuchtung
  outColor = vec4(ambient, 1.0);
  float c;

  // Nur Attenuation ( Links )
  c = isConeAtt(LeftLightPos);
  outColor.rgb += vec3(c) * light(LeftLightPos - DataIn.pos, DataIn.Normal) * yellow;

  // Nur Exponent ( Mitte )
  c = isConeExp(CenterLightPos);
  outColor.rgb += vec3(c)  * light(CenterLightPos - DataIn.pos, DataIn.Normal) * yellow;

  // Kombiniert ( Rechte )
  float c1 = isConeAtt(RightLightPos);
  float c2 = isConeExp(RightLightPos);
  c        = c1 * c2; // Beide Abschwächungen multipizieren.
  outColor.rgb += vec3(c)  * light(RightLightPos - DataIn.pos, DataIn.Normal) * yellow;
}

