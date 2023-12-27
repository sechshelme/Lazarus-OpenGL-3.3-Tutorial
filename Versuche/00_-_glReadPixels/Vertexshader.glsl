#version 330

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec2 inUV;
layout (location = 2) in vec3 inNormal;

// Daten für Fragment-shader
out Data {
  vec3 Pos;
  vec2 UV0;
  vec3 Normal;
} DataOut;

layout (std140) uniform UBO {
  vec3  Mambient;   // Umgebungslicht
  vec3  Mdiffuse;   // Farbe
  vec3  Mspecular;  // Spiegelnd
  float Mshininess; // Glanz
  mat4 ModelMatrix; // Matrix des Modeles, ohne Frustum-Beeinflussung.
  mat4 Matrix;      // Matrix für die Drehbewegung und Frustum.
};

void main(void)
{
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;

  DataOut.UV0 = inUV;
}
