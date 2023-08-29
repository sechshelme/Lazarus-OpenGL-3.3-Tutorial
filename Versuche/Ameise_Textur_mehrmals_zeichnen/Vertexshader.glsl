#version 330

#define a 0.5

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten

uniform mat4 mat;
uniform vec4 angele;

out vec2 UV[4];


vec2 rot(vec2 v, float ang) {
  vec2 vr;
  vr.x = v.x * cos(ang) - v.y * sin(ang);
  vr.y = v.x * sin(ang) + v.y * cos(ang);
  return vr;
}


void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);


  UV[0] = inUV;
  UV[0] -= 0.5;

  UV[0] *= 5.0;
  UV[0] = rot(UV[0], angele[0]);

  UV[0] += 0.5;

  UV[1] = inUV;
  UV[1] /= 0.3;

  UV[2] = inUV;
  UV[2] /= 0.4;
  UV[2] -= 1.0;

  UV[3] = inUV;
  UV[3] /= 0.5;
  UV[3] -= 1.2;
}
