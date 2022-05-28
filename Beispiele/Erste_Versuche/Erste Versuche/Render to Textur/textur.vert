#version 330

layout (location = 0) in vec3 inPos;
layout (location = 10) in vec2 vertexUV0;
layout (location = 11) in vec2 vertexUV1;

uniform mat4 Matrix;

out vec2 UV0;
out vec2 UV1;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  UV0 = vertexUV0;
  UV1 = vertexUV1;
}
