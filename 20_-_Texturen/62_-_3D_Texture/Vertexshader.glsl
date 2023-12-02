#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec2 inUV;

layout (std140) uniform UBO {
  mat4x4 mat;
  float W;
};

out vec2 UV;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV = inUV;
}
