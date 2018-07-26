#version 330

#define Instance_Count 200

layout (location = 0) in vec2 inPos;

uniform float Size[Instance_Count];
uniform mat4 mat[Instance_Count];
uniform vec3 Color[Instance_Count];

out vec3 col;

void main(void)
{
  gl_Position = mat[gl_InstanceID] * vec4((inPos * Size[gl_InstanceID]), 0.0, 1.0);

  col = Color[gl_InstanceID];
}
