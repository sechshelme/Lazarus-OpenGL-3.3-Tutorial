#version 330

uniform vec3 Color  ;  // Farbe von Uniform

in vec3 outCol;

out vec4 outColor; // ausgegebene Farbe

uniform int PointTyp;

void main(void)
{
//  vec2  p = gl_PointCoord * 2.0 - vec2(1.0);
//  float r = sqrt(dot(p, p));
//  outColor = vec4(Color, 1.0);


//if (dot(gl_PointCoord - 0.5, gl_PointCoord - 0.5) > 0.25)
if (length(gl_PointCoord - 0.5) > 0.5)
              discard;
            else
              outColor = vec4(outCol, 1.0);

              outColor.rg = gl_PointCoord;
              outColor.b = 0.0;
}
