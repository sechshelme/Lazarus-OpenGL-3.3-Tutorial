#version 330
in vec3 inPos;
in vec3 inColor;

out vec4 Color;

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  Color = vec4(inColor, 1.0);
}
