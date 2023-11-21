#version 330

#define size 10
#define scale 5.0

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

// Daten für Fragment-shader
out Data {
  vec3 Pos;
  vec3 Normal;
} DataOut;

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;

int id = gl_InstanceID;

void main(void) {
  vec3 p = inPos / 2 - size / 2;
  p.x += ((id % size) - size / 2) * scale;
  p.y += ((id / size) - size / 2) * scale;

  gl_Position    = Matrix * vec4(p, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * vec4(p, 1.0)).xyz;
}
