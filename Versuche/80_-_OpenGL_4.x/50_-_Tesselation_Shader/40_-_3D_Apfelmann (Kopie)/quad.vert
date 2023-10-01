#version 330

uniform mat4 Matrix;

out vec2 pos;                           // Koordinaten für den Fragment-Shader

const vec2 vertices[] = vec2[](
  vec2(-1.0, 1.0),
  vec2(-1.0, -1.0),
  vec2(1.0, -1.0),
  vec2(-1.0, 1.0),
  vec2(1.0, -1.0),
  vec2(1.0, 1.0));


void main(void) {
  gl_Position = Matrix * vec4(vertices[gl_VertexID], 0.0, 1.0);
  pos = gl_Position.xy;
}
