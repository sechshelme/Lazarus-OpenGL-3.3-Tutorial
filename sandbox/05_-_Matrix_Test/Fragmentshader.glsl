#version 330

layout (packed) uniform UBO {
  mat4x4 proMat;
  mat2x2 modelMat;
};

in vec3 vCol;

out vec4 outColor;

void main(void)
{
  outColor = vec4(vCol, 1.0);
}
