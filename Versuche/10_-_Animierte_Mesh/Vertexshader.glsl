#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;
layout (location = 2) in int inAni;

struct Move {
  mat2x2 move0, move1;
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

  if (inAni == 01) {
    ip.xy += move[0].move0 * vec2(1,0);
  }
  if (inAni == 11) {
    ip.xy += move[1].move0 * vec2(1,0);
  }
  if (inAni == 21) {
    ip.xz += move[2].move0 * vec2(1,0);
  }
  if (inAni == 31) {
    ip.yz += move[3].move0 * vec2(1,0);
  }
  if (inAni == 41) {
    ip.xz += move[4].move0 * vec2(1,0);
  }
  if (inAni == 51) {
    ip.yz += move[5].move0 * vec2(1,0);
  }

  gl_Position = WorldMatrix * ModelMatrix * vec4(ip, 1.0);
  vcol = inCol;
}
