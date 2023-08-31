#version 330

layout (location = 10) in vec3 inPos;   // Vertex-Koordinaten

uniform mat4 mat;

void main(void) {
  gl_Position = mat * vec4(inPos, 1.0);
}
