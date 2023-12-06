#version 330

layout (std140) uniform UBO {
  vec3 col;
  mat4x4 mat;
  mat4x4 [64] JointMatrix;
};

out vec4 outColor;

void main(void)
{
  outColor = vec4(col, 1.0);
}
