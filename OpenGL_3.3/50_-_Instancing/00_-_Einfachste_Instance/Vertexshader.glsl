#version 330

//#define size 10

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

// Daten für Fragment-shader
out Data {
  vec3 pos;
  vec3 Normal;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;
uniform int size;

void main(void) {
  vec3 p = inPos / 2 - size / 2;
  p.x += gl_InstanceID % size;
  p.y += gl_InstanceID / size % size;
  p.z += gl_InstanceID / size /size;

  gl_Position    = Matrix * vec4(p, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * vec4(p, 1.0)).xyz;
}
