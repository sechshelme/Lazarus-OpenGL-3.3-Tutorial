#version 330

#define b 0.02

//layout(lines) in;
layout(lines_adjacency ) in;
layout(line_strip, max_vertices = 8) out;
//layout(triangle_strip, max_vertices = 6) out;

out vec3 Color;

vec2 rotL(in vec2 v) {
  return vec2(-v.y, v.x);
}


vec2 SP(in vec2 p1, in vec2  p2, in vec2 p3, in vec2 p4) {
  vec2 Result;
  Result.x = ((p3.y - p1.y) + (p2.y - p1.y) / (p2.x - p1.x) * p1.x - (p4.y - p3.y) / (p4.x - p3.x) * p3.x) /
    ((p2.y - p1.y) / (p2.x - p1.x) - (p4.y - p3.y) / (p4.x - p3.x));

  Result.y = ((p2.y - p1.y) / (p2.x - p1.x)) * (Result.x - p1.x) + p1.y;
  return Result;
}



void main(void)
{
  vec2 vl0 = normalize(gl_in[1].gl_Position.xy - gl_in[0].gl_Position.xy);
  vec2 vl1 = normalize(gl_in[1].gl_Position.xy - gl_in[2].gl_Position.xy);
  vec2 vl = normalize(vl0 + vl1) * b ;

  vec2 vr0 = normalize(gl_in[2].gl_Position.xy - gl_in[3].gl_Position.xy);
  vec2 vr1 = normalize(gl_in[2].gl_Position.xy - gl_in[1].gl_Position.xy);
  vec2 vr = normalize(vr0 + vr1) * b ;

  vec4 v0 = gl_in[1].gl_Position + vec4(vl, 0.0, 0.0);
  vec4 v1 = gl_in[1].gl_Position - vec4(vl, 0.0, 0.0);
  vec4 v2 = gl_in[2].gl_Position - vec4(vr, 0.0, 0.0);
  vec4 v3 = gl_in[2].gl_Position + vec4(vr, 0.0, 0.0);

  vec2 dif1 = gl_in[1].gl_Position.xy - gl_in[2].gl_Position.xy;
  dif1 = normalize(dif1) * b;
  vec4 dif = vec4(rotL(dif1), 0.0, 0.0);

  vec4 par0 = gl_in[1].gl_Position + dif;
  vec4 par1 = gl_in[1].gl_Position - dif;
  vec4 par2 = gl_in[2].gl_Position - dif;
  vec4 par3 = gl_in[2].gl_Position + dif;


  Color = vec3(0.0, 0.0, 0.0);
  gl_Position = gl_in[1].gl_Position;
  EmitVertex();

  gl_Position = gl_in[2].gl_Position;
  EmitVertex();
  EndPrimitive();



  Color = vec3(1.0, 0.0, 0.0);
  gl_Position = vec4(SP(par0.xy, par3.xy, v0.xy, v1.xy), 0.0, 1.0);
  EmitVertex();

  gl_Position = vec4(SP(par0.xy, par3.xy, v2.xy, v3.xy), 0.0, 1.0);
  EmitVertex();
  EndPrimitive();

  Color = vec3(0.0, 1.0, 0.0);
  gl_Position = vec4(SP(par1.xy, par2.xy, v0.xy, v1.xy), 0.0, 1.0);
  EmitVertex();

  gl_Position = vec4(SP(par1.xy, par2.xy, v2.xy, v3.xy), 0.0, 1.0);
  EmitVertex();
  EndPrimitive();

  //Color = vec3(1.0, 0.0, 0.0);
  //gl_Position = par0;
  //EmitVertex();
  //
  //gl_Position = par3;
  //EmitVertex();
  //EndPrimitive();
  //
  //Color = vec3(0.0, 1.0, 0.0);
  //gl_Position = par1;
  //EmitVertex();
  //
  //gl_Position = par2;
  //EmitVertex();
  //EndPrimitive();
  //
  //

}
