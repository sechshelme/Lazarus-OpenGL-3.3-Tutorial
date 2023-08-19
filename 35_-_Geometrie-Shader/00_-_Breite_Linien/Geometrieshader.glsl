#version 330

#define distance 0.02

layout(lines) in;
layout(line_strip, max_vertices = 6) out;

out vec3 Color; // Farb-Ausgabe für den Fragment-Shader

in vec2 Prev[2];
in vec2 Next[2];

vec2 rotL(in vec2 v) {
  return vec2(-v.y, v.x);
}

void main(void)
{
  gl_Position = gl_in[0].gl_Position;
  Color = vec3(0.0, 0.0, 1.0);
  EmitVertex();

  gl_Position = gl_in[1].gl_Position;
  EmitVertex();

  EndPrimitive();

  vec2 v = gl_in[0].gl_Position.xy - gl_in[1].gl_Position.xy;
  v = normalize(v) * distance;
  vec4 v0 = vec4(rotL(v), 0.0, 0.0);


  gl_Position = gl_in[0].gl_Position + v0;
  Color = vec3(1.0, 1.0, 0.0);
  EmitVertex();

  gl_Position = gl_in[1].gl_Position + v0;
  EmitVertex();

  EndPrimitive();

  gl_Position = gl_in[0].gl_Position - v0;
  Color = vec3(1.0, 0.0, 0.0);
  EmitVertex();

  gl_Position = gl_in[1].gl_Position - v0;
  Color = vec3(0.0, 1.0, 1.0);
  EmitVertex();

  EndPrimitive();
}
