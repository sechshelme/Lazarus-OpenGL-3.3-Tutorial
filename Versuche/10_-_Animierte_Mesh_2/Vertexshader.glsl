#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;
layout (location = 2) in int inAni;

struct Move {
  mat2x2 [2] move;
};

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
  Move [6] move;
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
  switch (inAni) {
  case 02:
    ip.xy += move[0].move[1] * vec2(1,0);
  case 01:
    ip.xy += move[0].move[0] * vec2(1,0);
    break;

  case 12:
    ip.yz += move[1].move[1] * vec2(1,0);
  case 11:
    ip.yz += move[1].move[0] * vec2(1,0);
    break;

  case 22:
    ip.xy += move[2].move[1] * vec2(1,0);
  case 21:
    ip.xy += move[2].move[0] * vec2(1,0);
    break;

  case 32:
    ip.yz += move[3].move[1] * vec2(1,0);
  case 31:
    ip.yz += move[3].move[0] * vec2(1,0);
    break;

  case 42:
    ip.xz += move[4].move[1] * vec2(1,0);
  case 41:
    ip.xz += move[4].move[0] * vec2(1,0);
    break;

  case 52:
    ip.xz += move[5].move[1] * vec2(1,0);
  case 51:
    ip.xz += move[5].move[0] * vec2(1,0);
    break;
  }

  gl_Position = WorldMatrix * ModelMatrix * vec4(ip, 1.0);
  vcol = inCol;
}
