#version 330

out vec4 outColor;                     // ausgegebene Farbe

void main(void)
{
  bvec3 b = bvec3(true, true, true);
//  bvec3 b = bvec3(false, false, false);

  if (all(b))
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
  else
    outColor = vec4(0.0, 1.0, 0.0, 1.0);
}
