#version 330

layout (location = 0) in vec3 inPos; // Vertex-Koordinaten
layout (location = 1) in vec3 inCol; // Farbe

uniform samplerBuffer u_tbo_tex;

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  Color = vec4(inCol, 1.0);

  int offset = (gl_VertexID % 3) * 3;
  Color.r = texelFetch(u_tbo_tex, offset + 0).r;
  Color.g = texelFetch(u_tbo_tex, offset + 1).r;
  Color.b = texelFetch(u_tbo_tex, offset + 2).r;
  Color.a = 1.0;
}
