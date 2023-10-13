#version 450 core

layout (location = 0) in vec2 vPos;

uniform Uniforms {
   vec3 translation;
   float scale;
   vec4 rotation;
   bool enabled;
};

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
