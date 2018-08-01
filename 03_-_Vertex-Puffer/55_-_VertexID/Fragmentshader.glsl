#version 330

out vec4 outColor;

in  vec3 col;

void main(void) {
  outColor = vec4(col, 1.0);
}
