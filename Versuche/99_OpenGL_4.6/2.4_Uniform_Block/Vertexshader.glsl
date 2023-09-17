#version 450 core

layout (location = 0) in vec2 vPos;

uniform Uniforms {
   vec3 translation;
   float scale;
   vec4 rotation;
   bool enabled;
};

void main()
{
  vec3 pos = vec3(vPos, 0.0);

  pos *= scale;
  pos += translation;

  gl_Position = vec4(pos, 1.0);
}
