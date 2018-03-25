#version 330

#define ambient vec3(0.2, 0.2, 0.2)

#define PI      3.1415

in Data {
  vec3 pos;
} DataIn;

// Struktur einer Lichtquelle.
struct  Light {
  bool  On;
  float CutOff;
  vec3  Pos;
  vec3  Color;
};

// Drei Lichtquellen in der Array.
layout(std140) uniform light0 {
  Light light[3];
};

out vec4 outColor;  // ausgegebene Farbe

// Berechnet die einzelnen Lichtquellen.
vec3 CalcLight(Light light) {

  vec3 lp = light.Pos;

  vec3 lightDirection = normalize(DataIn.pos - lp);
  vec3 spotDirection  = normalize(-light.Pos);

  float angle = dot(spotDirection, lightDirection);
  angle = max(angle, 0.0);

  if(angle > light.CutOff) {
    return vec3(1.0);
  } else {
    return vec3(0.0);
  }
}

// In der Schleife werden alle Lichtquellen addieren.
void main(void)
{
  outColor = vec4(ambient, 1.0);

  for (int i = 0; i <= 2; i++) {
    if (light[i].On) {
      outColor.rgb += CalcLight(light[i]) * light[i].Color;
    }
  }
}

