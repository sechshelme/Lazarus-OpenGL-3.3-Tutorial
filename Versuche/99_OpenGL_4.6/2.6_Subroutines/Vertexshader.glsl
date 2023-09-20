#version 450 core

layout (location = 0) in vec2 vPos;

uniform Uniforms {
   vec3 translation;
   float scale;
   vec4 rotation;
   bool enabled;
};

struct  {
  vec4 ambient2;
  vec4 diffuse2;
} Materials;

vec4 LightVec = vec4(1,1,1,1);


subroutine vec4 LightFunc(vec3); // Step 1

subroutine (LightFunc) vec4 ambient(vec3 n) // Step 2
{
  return Materials.ambient2;
}

subroutine (LightFunc) vec4 diffuse(vec3 n) // Step 2
//(again)
{
  return Materials.diffuse2 *  max(dot(normalize(n), LightVec.xyz), 0.0);
}
subroutine uniform LightFunc materialShader; // Step 3


void main()
{
  vec3 pos = vec3(vPos, 0.0);

  float angle = radians(rotation[0]);
  vec3 axis = normalize(rotation.yzw);

  mat3 I = mat3(1.0);
  mat3 S = mat3(0, -axis.z, axis.y,
                axis.z, 0, -axis.x,
               -axis.y, axis.x, 0);

  mat3 uuT = outerProduct(axis, axis);
  mat3 rot = uuT + cos(angle)*(I - uuT) + sin(angle) * S;

  pos *= scale;
  pos *= rot;
  pos += translation;

  gl_Position = vec4(pos, 1.0);
}
