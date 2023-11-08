#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in int inAni;

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
  float moveRZ;
  float moveLZ;
};

  // 0x = oben
  // 1x = unten
  // 2x = vorn
  // 3x = rechts
  // 4x = hinten
  // 5x = links

out vec3 vcol;

void main(void)
{
  vec3 ip = inPos;

  if (inAni==31) {
    ip.z += moveRZ;
  }
  if (inAni==51) {
    ip.z += moveLZ;
  }

  gl_Position = WorldMatrix * ModelMatrix * vec4(ip, 1.0);



  switch ((gl_VertexID / 6) % 6)
  {
    case 0:  vcol = vec3(1.0, 0.0, 0.0);
             break;
    case 1:  vcol = vec3(0.0, 1.0, 0.0);
             break;
    case 2:  vcol = vec3(0.0, 0.0, 1.0);
             break;
    case 3:  vcol = vec3(1.0, 1.0, 0.0);
             break;
    case 4:  vcol = vec3(0.0, 1.0, 1.0);
             break;
    default: vcol = vec3(1.0, 0.0, 1.0);
  }
}
