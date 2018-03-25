#version 330

#define ambient vec3(0.2, 0.2, 0.2)

#define PI      3.1415
#define Cutoff  cos(PI / 2 / 16)

in Data {
  vec3 pos;
} DataIn;

struct  Light {
  bool On;
  vec3 Pos;
  vec3 Color;
  float CutOff;
};

layout(std140) uniform light0 {
  Light light[3];
};

//layout(std140) uniform light1 {
//  Light light11;
//};
//
//layout(std140) uniform light2 {
//  Light light12;
//};

//uniform Light light0;
//uniform Light light1;
//uniform Light light2;

out vec4 outColor;  // ausgegebene Farbe

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
  if (light[0].On) {
    outColor.rgb += isCone(light[0].Pos) * light[0].Color;
  }
  if (light[1].On) {
    outColor.rgb += isCone(light[1].Pos) * light[1].Color;
  }
  if (light[2].On) {
    outColor.rgb += isCone(light[2].Pos) * light[2].Color;
  }
}

