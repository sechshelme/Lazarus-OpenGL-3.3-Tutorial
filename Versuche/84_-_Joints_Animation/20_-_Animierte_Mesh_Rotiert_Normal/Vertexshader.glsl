#version 330
#define jointCount 6

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;
layout (location = 2) in vec3 inNormal;
layout (location = 3) in int inJoint;

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
  mat4x4 [64] JointMatrix;
};

out vec3 vcol;
out vec3 vnorm;

void main(void)
{
  if (inJoint == -1) {
    gl_Position = WorldMatrix * ModelMatrix * vec4(inPos, 1.0);
    vnorm = (ModelMatrix * vec4(inNormal, 1.0)).xyz;
  } else {
    gl_Position = WorldMatrix * ModelMatrix * JointMatrix[inJoint] * vec4(inPos, 1.0);
    vnorm = (ModelMatrix * JointMatrix[inJoint] * vec4(inNormal, 1.0)).xyz;
  }
  vcol = inCol;
}
