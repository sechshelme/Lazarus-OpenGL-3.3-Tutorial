#version 330 core

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inNorm;
layout (location = 2) in vec2 inTexCoord;

out vec4 vColor;
out vec2 vTexcoord;
out vec3 vNorm;

layout (std140) uniform UBO {
  vec4 color;
  mat4 proj;
  mat4 view;
  mat4 model;
};

void main()
{
  vColor = color;
  vNorm = (model * vec4(inNorm, 1)).xyz;
  vTexcoord = inTexCoord;
  gl_Position = proj * view * model * vec4(inPos, 1.0);
};
