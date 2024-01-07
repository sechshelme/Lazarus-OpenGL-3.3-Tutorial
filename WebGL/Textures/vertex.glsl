#version 300 es

precision highp float;

layout(location = 0) in vec3 inPos;
layout(location = 1) in vec2 inUV;

uniform mat4 viewTransform;

out vec2 UV0;

void main() {
  gl_Position = viewTransform * vec4(inPos, 1.0);
  UV0 = inUV;
}



