#version 330 core

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec2 inTexCoord;

out vec4 vColor;
out vec2 vTexcoord;

layout (std140) uniform UBO {
  vec4 color;
  mat4 proj;
  mat4 view;
  mat4 model;
};

void main()
{
  vColor = color;
  vTexcoord = inTexCoord;
  gl_Position = proj * view * model * vec4(inPos, 1.0);
};
