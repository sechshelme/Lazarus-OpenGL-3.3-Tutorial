#version 330

layout (location = 0) in vec3 inPos;

uniform samplerBuffer sb;

out vec4 Color;

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  Color = texelFetch(sb, gl_VertexID % 6);
}
