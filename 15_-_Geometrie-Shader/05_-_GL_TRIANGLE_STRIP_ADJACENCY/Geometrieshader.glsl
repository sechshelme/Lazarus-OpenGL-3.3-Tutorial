#version 330

#define b 0.03

//layout(lines) in;
layout(lines_adjacency ) in;
//layout(line_strip, max_vertices = 8) out;
layout(triangle_strip, max_vertices = 8) out;

out vec3 Color;

vec2 rotL(in vec2 v) {
  return vec2(-v.y, v.x);
}

vec2 SP(in vec2 p1, in vec2  p2, in vec2 p3, in vec2 p4) {
  vec2 t1;
  vec2 t2;
  vec2 Result;
  if (p1 == p3) {
    return p1;
  } else if (p1.x == p2.x) {
    t1 = p3;
    t2 = p4;
    Result.x = p1.x;
  } else {
    t1 = p1;
    t2 = p2;
    if (p3.x == p4.x) {
      Result.x = p3.x;
    } else {
      Result.x = ((p3.y - p1.y) + (p2.y - p1.y) / (p2.x - p1.x) * p1.x - (p4.y - p3.y) / (p4.x - p3.x) * p3.x) /
        ((p2.y - p1.y) / (p2.x - p1.x) - (p4.y - p3.y) / (p4.x - p3.x));
    }
  }
  Result.y = ((t2.y - t1.y) / (t2.x - t1.x)) * (Result.x - t1.x) + t1.y;
  return Result;
}


void main(void)
{
  // Links
  vec2 parl = normalize(gl_in[0].gl_Position.xy - gl_in[1].gl_Position.xy);
  vec4 difl = vec4(rotL(parl * b), 0.0, 0.0);

  vec4 parl0 = gl_in[0].gl_Position - difl;
  vec4 parl1 = gl_in[1].gl_Position - difl;
  vec4 parl2 = gl_in[1].gl_Position + difl;
  vec4 parl3 = gl_in[0].gl_Position + difl;

  // Rechts
  vec2 parr = normalize(gl_in[2].gl_Position.xy - gl_in[3].gl_Position.xy);
  vec4 difr = vec4(rotL(parr * b), 0.0, 0.0);

  vec4 parr0 = gl_in[2].gl_Position - difr;
  vec4 parr1 = gl_in[3].gl_Position - difr;
  vec4 parr2 = gl_in[3].gl_Position + difr;
  vec4 parr3 = gl_in[2].gl_Position + difr;

  // Mitte
  vec2 dif1 = gl_in[1].gl_Position.xy - gl_in[2].gl_Position.xy;
  dif1 = normalize(dif1) * b;
  vec4 dif = vec4(rotL(dif1), 0.0, 0.0);

  vec4 par0 = gl_in[1].gl_Position - dif;
  vec4 par1 = gl_in[2].gl_Position - dif;
  vec4 par2 = gl_in[2].gl_Position + dif;
  vec4 par3 = gl_in[1].gl_Position + dif;


  Color = vec3(1.0, 0.0, 0.0);
  gl_Position = vec4(SP(par0.xy, par1.xy, parl1.xy, parl0.xy), 0.0, 1.0);
  EmitVertex();

  gl_Position = vec4(SP(par1.xy, par0.xy, parr0.xy, parr1.xy), 0.0, 1.0);
  EmitVertex();

  Color = vec3(0.0, 1.0, 0.0);
  gl_Position = vec4(SP(par3.xy, par2.xy, parl2.xy, parl3.xy), 0.0, 1.0);
  EmitVertex();

  gl_Position = vec4(SP(par2.xy, par3.xy, parr3.xy, parr2.xy), 0.0, 1.0);
  EmitVertex();
  EndPrimitive();
}
