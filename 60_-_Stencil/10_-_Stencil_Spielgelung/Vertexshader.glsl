#version 330 core

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec2 inTexCoord;

out vec3 vColor;
out vec2 vTexcoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;
uniform vec3 color;

void main()
{
  vColor = color;
  vTexcoord = inTexCoord;
  gl_Position = proj * view * model * vec4(inPos, 1.0);
};
