#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;
layout (location = 2) in int inJoint;


layout (std140) uniform UBO {
  mat4x4 mat;
  mat4x4 [64] JointMatrix;
};

out vec3 vCol;

void main(void)
{
  vCol = inCol;
  if (inJoint == -1) {
    gl_Position = mat * vec4(inPos, 1.0);
  } else {
    gl_Position = mat * JointMatrix[inJoint] * vec4(inPos, 1.0);
  };
}
