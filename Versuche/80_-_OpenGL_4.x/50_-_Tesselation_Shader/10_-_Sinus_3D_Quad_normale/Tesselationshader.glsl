#version 400

layout(quads) in;

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
  float sinOfs;
  bool isSinus;
  int tesLevel;
};

in float vArea[];

out vec3 tcol;
out vec3 tnorm;

void main() {
  vec4 p1 = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  vec4 p2 = mix(gl_in[2].gl_Position, gl_in[3].gl_Position, gl_TessCoord.x);
  gl_Position = mix(p1, p2, gl_TessCoord.y);

  float yStep = 1 / float(tesLevel);
  vec3 no = vec3(1, 0, 0);

  tcol = vec3(0.9, 0.0,0.5);
  if (isSinus) {

      float si = abs(sin((gl_Position.y + sinOfs) * 20) / 4 - 1);
      float si0 = abs(sin((gl_Position.y - yStep + sinOfs) * 20) / 4 - 1);
      float si1 = abs(sin((gl_Position.y + yStep + sinOfs) * 20) / 4 - 1);
      gl_Position.x *= si;

    if (vArea[0] == 1.0)  {
      tcol = vec3(0.9, 0.9,0.9);
      no.xy = vec2(si + si0, yStep * 20);
      no = normalize(no);
    }
    //if ((vArea[1] > 1.0) && (vArea[1] < 3.0))  {
    //  tcol = vec3(0.9, 0.9,0.9);
    //  no.xy = vec2(si + si0, yStep * 20);
    //  no = normalize(no);
    //}
  }

  tnorm = no;
//  tcol = gl_Position.xyz + 0.5;

  gl_Position = WorldMatrix * ModelMatrix * gl_Position;
}
