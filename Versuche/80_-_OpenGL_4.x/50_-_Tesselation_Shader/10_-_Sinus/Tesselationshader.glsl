#version 330

layout(triangles) in;

out vec3 color;

void main() {
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);

  float si = sin(gl_Position.y * 20) / 14;
//  si /= abs(gl_TessCoord.x -0.5)*64;

  if (gl_Position.x > 0) {
   gl_Position.x +=  si;
//   gl_Position.z +=  si;
  } else {
   gl_Position.x -=  si;
//   gl_Position.z -=  si;
  }

  color = gl_Position.xyz + 0.5;
}
