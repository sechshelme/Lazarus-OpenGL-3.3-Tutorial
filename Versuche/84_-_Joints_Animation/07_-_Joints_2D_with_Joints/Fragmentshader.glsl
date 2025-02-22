#version 330

layout (std140) uniform UBO {
  mat4x4 proMat;
  mat4x4 modelMat;
  mat4x4 [64] JointMatrix;
};

in vec3 vCol;

out vec4 outColor;

void main(void)
{
  outColor = vec4(vCol, 1.0);
}
