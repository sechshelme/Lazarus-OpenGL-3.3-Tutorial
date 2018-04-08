#version 330
#define size 0.1

in vec2 PosXY;

out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  vec2 p = mod(PosXY.xy, size * 2);
//  vec2 p = mod(gl_FragCoord.xy, 0.2);
  if (((p.x > size) && (p.y > size)) || ((p.x < size) && (p.y < size))) {
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
  } else {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
  };
  outColor.xyz = gl_FragCoord.xyz / 1024;
//  outColor.a = 1.0;
//  outColor = vec4(PosXY, 0.0, 1.0);
}
