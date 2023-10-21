#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 color;

out vec3 Color;
out vec2 Texcoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;
uniform vec3 overrideColor;

const vec4 texcoord[] = vec2[](
  vec2(0, 0), vec2(1, 0), vec2(1, 1),
  vec2(1, 1), vec2(0, 1), vec2(0, 0));

void main()
{
    Color = overrideColor * color;
    Texcoord = texcoord[gl_VertexID % 6];
    gl_Position = proj * view * model * vec4(position, 1.0);
};

