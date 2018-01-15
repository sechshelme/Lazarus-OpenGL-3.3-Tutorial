#version 330

#define ambient vec3(0.2, 0.2, 0.2)
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

#define PI      3.1415
#define Cutoff  cos(PI / 2 / 4)

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

// Prüfen ob Fragment in Lichtkegel.
bool isCone(vec3 LightPos) {

  vec3 lp = LightPos;

  vec3 lightDirection = normalize(DataIn.pos - lp);
  vec3 spotDirection  = normalize(-LightPos);

  float angle = dot(spotDirection, lightDirection);
  angle = max(angle, 0.0);

  if(angle > Cutoff) {
    return true;
  } else {
    return false;
  }
}

// Lichtstärke anhand der Normale.
float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);
}

void main(void)
{
  outColor = vec4(ambient, 1.0);
  if (RedOn) {
    if (isCone(RedLightPos)) {
      outColor.rgb  += light(RedLightPos - DataIn.pos, DataIn.Normal) * red;
    }
  }
  if (GreenOn) {
    if (isCone(GreenLightPos)) {
      outColor.rgb  += light(GreenLightPos - DataIn.pos, DataIn.Normal) * green;
    }
  }
  if (BlueOn) {
    if (isCone(BlueLightPos)) {
      outColor.rgb  += light(BlueLightPos - DataIn.pos, DataIn.Normal) * blue;
    }
  }
}

