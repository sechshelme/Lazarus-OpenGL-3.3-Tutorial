#version 330
in vec3 inPos;
in vec4 inColor;

uniform mat4 Matrix;

out vec4 Color;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  Color = inColor;
}
