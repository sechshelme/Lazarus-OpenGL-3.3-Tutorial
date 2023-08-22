#version 330

layout(triangles) in;

out vec3 color;

// varying input from vertex shader
in vec2 TexCoord[];
// varying output to evaluation shader
out vec2 TextureCoord[];

void main() {
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

  color = gl_TessCoord;
}
