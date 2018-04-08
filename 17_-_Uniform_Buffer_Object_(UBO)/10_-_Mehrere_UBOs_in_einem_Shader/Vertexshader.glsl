#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten

out Data {
  vec3 pos;
} DataOut;

// Matrizen zu einem Block zusammengefasst.
layout(std140) uniform Matrix {
  mat4 ModelMatrix;
  mat4 WorldMatrix;
} matrix;

void main(void)
{
  gl_Position  = matrix.WorldMatrix * vec4(inPos, 1.0);
  DataOut.pos  = (matrix.ModelMatrix * vec4(inPos, 1.0)).xyz;
}
