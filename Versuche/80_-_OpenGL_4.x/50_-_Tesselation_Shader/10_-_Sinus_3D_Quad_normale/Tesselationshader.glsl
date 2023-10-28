#version 400

layout(quads) in;

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
  float sinOfs;
  bool isSinus;
  int tesLevel;
};

out vec3 tcol;
out vec3 tnorm;

void main() {
  vec4 p1 = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  vec4 p2 = mix(gl_in[2].gl_Position, gl_in[3].gl_Position, gl_TessCoord.x);
  gl_Position = mix(p1, p2, gl_TessCoord.y);

  float yStep = 1 / float(tesLevel);
  vec3 no = vec3(1, 0, 0);

  if (isSinus) {


    float si = abs(sin((gl_Position.y + sinOfs) * 20) / 2 -1);
    float co = abs(cos((gl_Position.y + sinOfs) * 20) / 2 -1);

    float si0 = abs(sin((gl_Position.y - yStep + sinOfs) * 20) / 2 -1);
    float co0 = abs(cos((gl_Position.y - yStep + sinOfs) * 20) / 2 -1);

    float si1 = abs(sin((gl_Position.y + yStep + sinOfs) * 20) / 2 -1);
    float co1 = abs(cos((gl_Position.y + yStep + sinOfs) * 20) / 2 -1);

    gl_Position.x *= si;

    no.xy = vec2(si + si0, co + co0);
    no = normalize(no);
//    no.y = 0;
//    no.x = yStep;
  }

  tnorm = no;
  tcol = gl_Position.xyz + 0.5;
  tcol = vec3(yStep*0, 0.5,0.5);

  gl_Position = WorldMatrix * ModelMatrix * gl_Position;
}
