#version 330

layout (location = 0) in vec3  inPos;
layout (location = 1) in float inSize;

out Data {
  float radius;
  vec3 center;
} DataOut;

uniform vec4 viewport;

void main(void)
{
  gl_PointSize = inSize * min(viewport.z, viewport.w) * 2;
  gl_Position  = vec4(inPos, 1.0);

  DataOut.center = gl_Position.xyz;
  DataOut.radius = inSize;
}