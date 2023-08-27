#version 400 core

layout (vertices=3) out;

uniform float TLO[4];
uniform float TLI[2];

void main()
{
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

  if (gl_InvocationID == 0) {
    gl_TessLevelOuter = TLO;
    gl_TessLevelInner = TLI;
  }
}
