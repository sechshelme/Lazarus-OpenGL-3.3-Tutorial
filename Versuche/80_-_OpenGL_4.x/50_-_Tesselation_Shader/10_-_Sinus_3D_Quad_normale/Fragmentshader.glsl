#version 330

#define LightPos0 vec3(1.0, 1.0, -1.0)
#define LightPos1 vec3(-1.0, 1.0, 0.0)
#define ambient0 1.4
#define ambient1 0.2

out vec4 outColor;

in vec3 tcol;
in vec3 tnorm;

float light(vec3 p, vec3 n) {
  vec3  v1 = normalize(p);
  vec3  v2 = normalize(n);
  float d  = dot(v1, v2);
  float c  = clamp(d, 0.0, 1.0);
  return c;
}

void main(void)
{
  float l0 = light(LightPos0, tnorm) * ambient0;
  float l1 = light(LightPos1, tnorm) * ambient1;

  vec3 col = tcol * (l0 + l1) ;
  outColor = vec4(col, 1.0);
}
