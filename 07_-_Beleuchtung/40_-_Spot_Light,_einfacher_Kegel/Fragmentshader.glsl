#version 330

#define ambient vec3(0.2, 0.2, 0.2)
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

#define PI      3.1415
#define Cutoff  cos(PI / 2 / 4)

in Data {
  vec3 pos;
} DataIn;

uniform bool RedOn;
uniform bool GreenOn;
uniform bool BlueOn;

uniform vec3 RedLightPos;
uniform vec3 GreenLightPos;
uniform vec3 BlueLightPos;

out vec4 outColor;  // ausgegebene Farbe

// Prüfen ob Fragment in Lichtkegel
vec3 isCone(vec3 LightPos) {

  vec3 lp = LightPos;

  vec3 lightDirection = normalize(DataIn.pos - lp);
  vec3 spotDirection  = normalize(-LightPos);

  float angle = dot(spotDirection, lightDirection);
  angle = max(angle, 0.0);

  if(angle > Cutoff) {
    return vec3(1.0);
  } else {
    return vec3(0.0);
  }
}

void main(void)
{
  outColor = vec4(ambient, 1.0);
  if (RedOn) {
    outColor.rgb += isCone(RedLightPos) * red;
  }
  if (GreenOn) {
    outColor.rgb += isCone(GreenLightPos) * green;
  }
  if (BlueOn) {
    outColor.rgb += isCone(BlueLightPos) * blue;
  }
}

