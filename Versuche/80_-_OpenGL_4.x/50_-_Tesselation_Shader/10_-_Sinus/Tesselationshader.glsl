#version 330

layout(triangles) in;

uniform bool isSinus;

out vec3 color;

void main() {
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

  if (isSinus) {
    float si = sin(gl_Position.y * 10) / 8 - 1;
    gl_Position.x *=  si;
  }

  color = gl_Position.xyz + 0.5;
}
