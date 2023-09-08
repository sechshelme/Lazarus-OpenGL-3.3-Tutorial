#version 330

layout (location = 0) in vec3  inPos;
layout (location = 1) in float inSize;
layout (location = 2) in vec3  inMambient;
layout (location = 3) in vec3  inMdiffuse;
layout (location = 4) in vec3  inMspecular;
layout (location = 5) in float inMshininess;

out Data {
  vec3 color;
  float radius;
  vec3 pos;

  vec3 Mambient;
  vec3 Mdiffuse;
  vec3 Mspecular;
  float Mshininess;
} DataOut;

uniform mat4 ModelMatrix;
uniform vec4 viewport;

void main(void)
{
//  gl_PointSize = inSize * min(viewport.z, viewport.w) * (viewport[2]/viewport[3]);
  gl_PointSize = inSize * min(viewport.z, viewport.w) * 2;
  gl_Position  = ModelMatrix * vec4(inPos, 1.0);

//  DataOut.pos =  (ModelMatrix * vec4(inPos, 1.0)).xyz;
  DataOut.pos =  gl_Position.xyz;
  DataOut.radius = inSize;

  DataOut.Mambient = inMambient;
  DataOut.Mdiffuse = inMdiffuse;
  DataOut.Mspecular = inMspecular;
  DataOut.Mshininess = inMshininess;
}
