#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;
layout (location = 2) in int inAni;

struct Move {
  mat2x2 move1, move2;
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
    ip.xy += move[0].move2 * vec2(1,0);
  case 01:
    ip.xy += move[0].move1 * vec2(1,0);
    break;

  case 12:
    ip.xy += move[1].move2 * vec2(1,0);
  case 11:
    ip.xy += move[1].move1 * vec2(1,0);
    break;

  case 22:
    ip.xz += move[2].move2 * vec2(1,0);
  case 21:
    ip.xz += move[2].move1 * vec2(1,0);
    break;

  case 32:
    ip.yz += move[3].move2 * vec2(1,0);
  case 31:
    ip.yz += move[3].move1 * vec2(1,0);
    break;

  case 42:
    ip.xz += move[4].move2 * vec2(1,0);
  case 41:
    ip.xz += move[4].move1 * vec2(1,0);
    break;

  case 52:
    ip.yz += move[5].move2 * vec2(1,0);
  case 51:
    ip.yz += move[5].move1 * vec2(1,0);
    break;
  }

  gl_Position = WorldMatrix * ModelMatrix * vec4(ip, 1.0);
  vcol = inCol;
}
