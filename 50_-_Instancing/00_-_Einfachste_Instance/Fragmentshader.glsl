#version 330

#define LightPos vec3(50.0, 10.0, 50.0)
#define Diffuse  vec3( 1.0,  1.0,  0.9)


// Daten vom Vertex-Shader
in Data {
  vec3 pos;
  vec3 Normal;
} DataIn;

out vec4 outColor;

float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);
  return clamp(d, 0.0, 1.0);
}

void main(void)
{
  outColor      = vec4(vec3(0.2, 0.2, 0.05), 1.0);
  outColor.rgb += vec3(light(LightPos - DataIn.pos, DataIn.Normal)) * Diffuse;
}
