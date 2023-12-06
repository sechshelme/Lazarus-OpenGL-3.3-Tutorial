#version 330

layout (location = 0) in vec3 inPos;

layout (std140) uniform UBO {
  vec3 col;
  mat4x4 mat;
  mat4x4 [64] JointMatrix;
};

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
}
