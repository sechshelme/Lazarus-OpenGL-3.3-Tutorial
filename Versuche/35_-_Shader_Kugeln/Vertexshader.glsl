#version 330

layout (location = 0) in vec2  inPos;  // Vertex-Koordinaten in 2D
layout (location = 1) in vec3  inCol;  // Vertex-Koordinaten in 2D
layout (location = 2) in float inSize; // Vertex-Koordinaten in 2D

out vec3 outCol;

void main(void)
{
  gl_PointSize = inSize;
  gl_Position  = vec4(inPos, 0.0, 1.0);   // Der zweiter Parameter (Z) auf 0.0
  outCol = inCol;
}
