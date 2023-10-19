#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 color;
layout (location = 2) in vec2 texcoord;

out vec3 Color;
out vec2 Texcoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;
uniform vec3 overrideColor;

void main()
{
    Color = overrideColor * color;
    Texcoord = texcoord;
    gl_Position = proj * view * model * vec4(position, 1.0);
};

