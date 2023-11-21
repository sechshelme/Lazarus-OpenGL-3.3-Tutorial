#version 420

#extension GL_ARB_explicit_uniform_location : enable

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inCol;

out vec3 col;

uniform Uniforms {
   vec3 translation;
   float scale;
   vec4 rotation;
   bool enabled;
};

void main(void)
{
  vec3 pos = inPos;

  pos *= scale;
//  pos *= rot;
  pos += translation;

  gl_Position = vec4(pos, 1.0);
  col = inCol;
}
