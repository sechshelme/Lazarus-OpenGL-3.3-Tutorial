#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

// Daten für Fragment-shader
out vec3 Data_Pos;
out vec3 Data_Normal;

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;

void main(void) {
  gl_Position    = Matrix * vec4(inPos, 1.0);
  Data_Pos = inPos;
  Data_Normal = inNormal;

  Data_Normal = mat3(ModelMatrix) * inNormal;
  Data_Pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
}
