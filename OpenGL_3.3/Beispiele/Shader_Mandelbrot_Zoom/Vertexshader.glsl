#version 330

uniform mat4 mat;

layout (std140) uniform ubo {
  mat4x4 matrix;
  float left;
  float right;
  float top;
  float bottom;
  float col;
};

out vec2 pos;                           // Koordinaten für den Fragment-Shader

const vec2 vertices[] = vec2[](
  vec2(-1.0,  1.0),
  vec2(-1.0, -1.0),
  vec2( 1.0, -1.0),
  vec2(-1.0,  1.0),
  vec2( 1.0, -1.0),
  vec2( 1.0,  1.0));

void main(void) {
  gl_Position = matrix * vec4(vertices[gl_VertexID], 0.0, 1.0);
  pos = vertices[gl_VertexID];         // XY an Fragment-Shader
}
