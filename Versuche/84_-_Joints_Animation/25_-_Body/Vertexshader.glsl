#version 330

layout (location = 0) in vec2 inPos;
layout (location = 1) in vec3 inCol;
layout (location = 2) in int inJoint;

layout (std140) uniform UBO {
  mat4x4 proMat;
  mat4x4 modelMat;
  mat4x4 [64] JointMatrix;
};

out vec3 vCol;

void main(void)
{
  vCol = inCol;

  if (inJoint == -1) {
    gl_Position = proMat * modelMat * vec4(inPos, 0.0, 1.0);
  } else {
    gl_Position = proMat * modelMat * JointMatrix[inJoint] * vec4(inPos, 0.0, 1.0);
  };
}
