#version 400

layout(quads) in;

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
  float sinOfs;
  bool isSinus;
};

out vec3 tcol;

void main() {
  vec4 p1 = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  vec4 p2 = mix(gl_in[2].gl_Position, gl_in[3].gl_Position, gl_TessCoord.x);
  gl_Position = mix(p1, p2, gl_TessCoord.y);

  if (isSinus) {
    float si = sin((gl_Position.z + sinOfs) * 20) / 8 - 1;
    gl_Position.x *=  abs( si);
    si = sin((gl_Position.z + 1.5 + sinOfs) * 19) / 8 - 1;
    gl_Position.y *=  abs( si);

    si = sin((gl_Position.x + sinOfs) * 13) / 8 - 1;
    gl_Position.y *=  abs( si);
    si = sin((gl_Position.x+1.5 + sinOfs) * 14) / 8 - 1;
    gl_Position.z *=  abs( si);

    si = sin((gl_Position.y + sinOfs) * 17) / 8 - 1;
    gl_Position.z *= abs( si);
    si = sin((gl_Position.y+1.5 + sinOfs) * 13) / 8 - 1;
    gl_Position.x *= abs( si);
  }

  tcol = gl_Position.xyz + 0.5;

  gl_Position = WorldMatrix * ModelMatrix * gl_Position;
}
