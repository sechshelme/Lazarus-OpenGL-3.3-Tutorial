#version 330

layout (location = 0) in vec3  inPos;  // Vertex-Koordinaten in 2D
layout (location = 1) in vec3  inCol;  // Vertex-Koordinaten in 2D
layout (location = 2) in float inSize; // Vertex-Koordinaten in 2D

out vec3 outCol;
out float radius;

uniform vec4 viewport;
//  uniform float viewport;

void main(void)
{
  gl_PointSize = inSize * min(viewport.z, viewport.w) / 1000;
//  gl_PointSize = inSize * viewport/ 10;
//  gl_PointSize = inSize *viewport.z / 1000;

  gl_Position  = vec4(inPos, 1.0);

  outCol = inCol;
  radius = inSize;
}
