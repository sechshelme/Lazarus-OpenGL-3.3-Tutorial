#version 330 core

layout (location = 0) in vec3 inPos;

out vec3 vColor;
out vec2 vTexcoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;
uniform vec3 color;

const vec4 texcoord[] = vec2[](
  vec2(0, 0), vec2(1, 0), vec2(1, 1),
  vec2(0, 0), vec2(1, 1), vec2(0, 1));

void main()
{
  vColor = color;
  vTexcoord = texcoord[gl_VertexID % 6];
  gl_Position = proj * view * model * vec4(inPos, 1.0);
};
