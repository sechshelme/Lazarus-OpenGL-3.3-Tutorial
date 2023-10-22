#version 460 core

layout (location = 0) in vec3 position;

out vec3 Color;
out vec2 Texcoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;
uniform vec3 uColor;

layout (binding = 0) uniform atomic_uint atPixel;

const vec4 texcoord[] = vec2[](
  vec2(0, 0),
  vec2(1, 0),
  vec2(1, 1),
  vec2(0, 1));

void main()
{
  uint ct = atomicCounterIncrement(atPixel);

    Color = uColor;
//    Texcoord = texcoord[gl_VertexID % 4];
    Texcoord = texcoord[ct % 4];
    gl_Position = proj * view * model * vec4(position, 1.0);
};

