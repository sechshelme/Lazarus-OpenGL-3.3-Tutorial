#version 330

#define Instance_Count 255

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec2 inUV;

uniform int chars[Instance_Count];
uniform mat4 mat;

out vec2 UV0;
out float layer;

void main(void)
{
  vec4 p = vec4(inPos, 1.0);
  p.x += float(gl_InstanceID);

  gl_Position = mat * p;

  layer = chars[gl_InstanceID] - 32;

  UV0 = inUV;
}
