#version 330

#define ambient vec3(0.2, 0.2, 0.2)
//#define red     vec3(1.0, 0.0, 0.0)
//#define green   vec3(0.0, 1.0, 0.0)
//#define blue    vec3(0.0, 0.0, 1.0)

#define PI      3.1415
#define Cutoff  cos(PI / 2 / 4)

in Data {
  vec3 pos;
} DataIn;

//layout(std140) struct   light0, light1 {
layout(std140) struct   Light {
  bool On;
  vec3 Pos;
  vec3 Color;
  float CutOff;
};

uniform light0 {
  Light light10;
};

uniform light1 {
  Light light11;
};

uniform light2 {
  Light light12;
};

//uniform Light light0;
//uniform Light light1;
//uniform Light light2;

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
  if (light10.On) {
    outColor.rgb  += isCone(light10.Pos) * light10.Color;
  }
  if (light11.On) {
    outColor.rgb += isCone(light11.Pos) * light11.Color;
  }
  if (light12.On) {
    outColor.rgb += isCone(light12.Pos) * light12.Color;
  }
  //if (light10.On) {
  //  outColor.rgb  += isCone(RedLightPos) * red;
  //}
  //if (light11.On) {
  //  outColor.rgb += isCone(GreenLightPos) * green;
  //}
  //if (light12.On) {
  //  outColor.rgb += isCone(BlueLightPos) * blue;
  //}
}

