#version 400

layout(triangles) in;

uniform mat4 Matrix;
uniform sampler2D heightMap;

in vec2 TexCoord[];

out vec3 color;
out vec2 TextureCoord;

void main() {
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

  TextureCoord = (gl_TessCoord.x * TexCoord[0]) +
                 (gl_TessCoord.y * TexCoord[1]) +
                 (gl_TessCoord.z * TexCoord[2]);

  float r = texture(heightMap, TextureCoord).r;
  float g = texture(heightMap, TextureCoord).g;
  float b = texture(heightMap, TextureCoord).b;

  float Height = (r + g + b) / 3;

  color = vec3(Height);

  gl_Position.z += (Height * 0.1);
  gl_Position = Matrix * gl_Position;
}
