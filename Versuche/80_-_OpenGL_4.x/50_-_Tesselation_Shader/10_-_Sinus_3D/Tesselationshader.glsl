#version 330

layout(triangles) in;

//uniform bool isSinus;

layout (std140) uniform UBO {
  mat4x4 ModelMatrix;
  bool isSinus;
};

out vec3 col;

void main() {
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

  if (isSinus) {
    float si = sin(gl_Position.y * 20) / 8 - 1;
    gl_Position.x *=  si;
    gl_Position.z *=  si;
  }

  col = gl_Position.xyz + 0.5;

  gl_Position = ModelMatrix * gl_Position;
}
