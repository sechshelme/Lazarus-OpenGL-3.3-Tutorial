#version 330

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 instance_color;
layout (location = 2) in mat4 instance_Matrix;

out vec4 Color;

void main(void) {
  gl_Position = instance_Matrix * vec4(position, 1.0);
  Color       = vec4(instance_color, 1.0);
}

