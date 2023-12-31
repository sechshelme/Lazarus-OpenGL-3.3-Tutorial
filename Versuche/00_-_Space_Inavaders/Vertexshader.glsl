#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec2 inUV;

out Data {
  vec2 UV0;
} DataOut;

layout (std140) uniform UBO {
  mat4 ModelMatrix;
  mat4 Matrix;
  int CubeEnabled;
};

void main(void)
{
  gl_Position    = Matrix * vec4(inPos, 1.0);
  DataOut.UV0 = inUV;
}
