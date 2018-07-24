#version 330

#define Instance_Count 2000

layout (location = 0) in vec2 inPos;
uniform vec2 Position[Instance_Count];
uniform vec3 Color[Instance_Count];
uniform float Size[Instance_Count];

out vec3 col;

void main(void)
{
  vec2 pos = inPos * Size[gl_InstanceID] + Position[gl_InstanceID];
  gl_Position = vec4(pos, 0.0, 1.0);

  col = Color[gl_InstanceID];
}
