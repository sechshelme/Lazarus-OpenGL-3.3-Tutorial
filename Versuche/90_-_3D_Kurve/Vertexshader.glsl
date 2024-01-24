#version 330

layout (location = 0) in vec3 inPos;

uniform sampler2D Texture;

layout (std140) uniform UBO {
  vec2 ofs;
  mat4 Matrix;
};

out vec3 col;

void main(void)
{
  vec3 p = inPos;
  p.z += texture(Texture, inPos.xy - vec2(0.5, 0.5) + ofs).r;
  float c = 1.0 - (p.z / 2);
  col = vec3(c, c, c);
  p.z -= 0.5;
//  p.z /= 10;

  gl_Position    = Matrix * vec4(p, 1.0);
}
