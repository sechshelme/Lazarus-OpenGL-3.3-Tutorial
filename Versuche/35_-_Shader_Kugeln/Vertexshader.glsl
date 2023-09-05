#version 330

layout (location = 0) in vec3  inPos;
layout (location = 1) in vec3  inCol;
layout (location = 2) in float inSize;

out vec3 outCol;
out float radius;
out vec2 center;

uniform vec4 viewport;

void main(void)
{
  gl_PointSize = inSize * min(viewport.z, viewport.w) * 2;

  gl_Position  = vec4(inPos, 1.0);

  center = gl_Position.xy;
  outCol = inCol;
  radius = inSize;
}
