#version 130

in vec3 inPos;
in vec3 inColor;

uniform mat4 Matrix;

out vec4 Color;

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  Color = vec4(inColor, 1.0);
}
