#version 330

in vec3 inPos;
in vec2 vertexUV0;
in vec2 vertexUV1;

uniform mat4 Matrix;
uniform vec2 Texturxy;

out vec2 UV0;
out vec2 UV1;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  UV0 = vertexUV0;
  UV0.y *= -1;
  UV1 = (vertexUV1 - Texturxy) * 2;
}
