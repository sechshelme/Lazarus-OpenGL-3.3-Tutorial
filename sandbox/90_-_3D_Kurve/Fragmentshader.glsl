#version 330

in vec3 col;

out vec4 outColor;

void main(void) {
  outColor=vec4(col, 1.0);
}

