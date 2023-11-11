#version 330
#define jointCount 6

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;
layout (location = 2) in int inJoint;

struct Move {
  mat2x2 [jointCount] move;
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
  if ((inJoint >= 1) && (inJoint <= 9)) {
    for (int i = inJoint - 1 ; i >= 0; i--) {
      ip.xy += move[0].move[i] * vec2(1,0);
    }
  } else if ((inJoint >= 11) && (inJoint <= 19)) {
    for (int i = inJoint - 11 ; i >= 0; i--) {
      ip.yz += move[1].move[i] * vec2(1,0);
    }
  } else if ((inJoint >= 21) && (inJoint <= 29)) {
    for (int i = inJoint - 21 ; i >= 0; i--) {
      ip.xy += move[2].move[i] * vec2(1,0);
    }
  } else if ((inJoint >= 31) && (inJoint <= 39)) {
    for (int i = inJoint - 31 ; i >= 0; i--) {
      ip.yz += move[3].move[i] * vec2(1,0);
    }
  } else if ((inJoint >= 41) && (inJoint <= 49)) {
    for (int i = inJoint - 41 ; i >= 0; i--) {
      ip.xz += move[4].move[i] * vec2(1,0);
    }
  } else if ((inJoint >= 51) && (inJoint <= 59)) {
    for (int i = inJoint - 51 ; i >= 0; i--) {
      ip.xz += move[5].move[i] * vec2(1,0);
    }
  }

  gl_Position = WorldMatrix * ModelMatrix * vec4(ip, 1.0);
  vcol = inCol;
}
