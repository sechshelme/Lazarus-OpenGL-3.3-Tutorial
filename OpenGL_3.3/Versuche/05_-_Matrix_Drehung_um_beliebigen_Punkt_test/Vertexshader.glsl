#version 330
#define pi 3.14

layout (location = 0) in vec2 inPos;
uniform mat2x2 mat;
uniform float angele;

vec2 rotate(in vec2 v, in vec2 ofs, float a) {
  vec2 res;
  v -= ofs;

  res.x = v.x * cos(a) - v.y * sin(a) + ofs.x;
  res.y = v.x * sin(a) + v.y * cos(a) + ofs.y;

  return res;
}

void main(void)
{
  vec2 p = inPos;
//  p = rotate(p, vec2(0.3 ,0.3), angele);
  p = mat * inPos;
  gl_Position = vec4(p, 0.0, 1.0);
}
