#version 330

uniform vec3 Color  ;  // Farbe von Uniform
out     vec4 outColor; // ausgegebene Farbe

uniform int PointTyp;

void main(void)
{
  vec2  p = gl_PointCoord * 2.0 - vec2(1.0);
  float r = sqrt(dot(p, p));

  float theta = atan(p.y, p.x);

  switch (PointTyp){
    case 0: if (dot(gl_PointCoord - 0.5, gl_PointCoord - 0.5) > 0.25)
              discard;
            else
              outColor = vec4(Color, 1.0);
            break;
    case 1: if (dot(p, p) > cos(theta * 5))
              discard;
            else
              outColor = vec4(Color, 1.0);
            break;
    case 2: if (dot(p, p) > r || dot(p, p) < r * 0.75)
              discard;
            else
              outColor = vec4(Color, 1.0);
            break;
    case 3: if (dot(p, p) > 5.0 / cos(theta - 20 * r))
              discard;
            else
              outColor = vec4(Color, 1.0);
            break;
    default: discard;

  }
}
