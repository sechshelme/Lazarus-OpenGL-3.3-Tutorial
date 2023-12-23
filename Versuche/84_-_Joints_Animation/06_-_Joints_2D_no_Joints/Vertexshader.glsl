#version 330

layout (location = 0) in vec2 inPos;
layout (location = 1) in vec3 inCol;

layout (std140) uniform UBO {
  mat4x4 proMat;
  mat4x4 modelMat;
};

out vec3 vCol;

void main(void)
{
  vCol = inCol;
  gl_Position = proMat * modelMat * vec4(inPos, 0.0, 1.0);
}
