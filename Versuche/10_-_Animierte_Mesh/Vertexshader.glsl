#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in int inAni;

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
  mat2x2 moveF;
  mat2x2 moveN;
  mat2x2 moveB;
  mat2x2 moveR;
  mat2x2 moveT;
  mat2x2 moveL;
};

// 0x = vorn
// 1x = hinten
// 2x = unten
// 3x = rechts
// 4x = oben
// 5x = links

out vec3 vcol;

void main(void)
{
  vec3 ip = inPos;

  if (inAni == 01) {
    ip.xy += moveF * vec2(1,0);
  }
  if (inAni == 11) {
    ip.xy += moveN * vec2(1,0);
  }
  if (inAni == 21) {
    ip.xz += moveB * vec2(1,0);
  }
  if (inAni == 31) {
    ip.yz += moveR * vec2(1,0);
  }
  if (inAni == 41) {
    ip.xz += moveT * vec2(1,0);
  }
  if (inAni == 51) {
    ip.yz += moveL * vec2(1,0);
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
