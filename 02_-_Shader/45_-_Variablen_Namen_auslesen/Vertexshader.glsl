#version 330

// Attribute
layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

// Uniform-Variablen
uniform mat4 ModelMatrix;
uniform mat4 Matrix;
uniform vec4 KeineVerwendung; // Wird nicht angezeigt, da nicht verwendet.

// Daten für Fragment-shader
out Data {
  vec3 Pos;
  vec3 Normal;
} DataOut;

void main(void)
{
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
}
