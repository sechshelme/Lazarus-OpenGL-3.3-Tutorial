#version 330

const vec4 vertices[] = vec4[](
  vec4( 0.50, -0.50, 0.75, 1.0),
  vec4(-0.50, -0.50, 0.75, 1.0),
  vec4( 0.00, 0.50, 0.75, 1.0));

void main(void) {

  gl_Position = vertices[gl_VertexID];
}
