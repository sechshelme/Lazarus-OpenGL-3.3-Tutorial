#version 400

layout(quads) in;

out vec3 color;

void main() {
  vec4 p1 = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  vec4 p2 = mix(gl_in[2].gl_Position, gl_in[3].gl_Position, gl_TessCoord.x);
  gl_Position = mix(p1, p2, gl_TessCoord.y);

  color = gl_TessCoord;
}
