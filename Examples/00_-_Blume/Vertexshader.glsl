#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

// Daten für Fragment-shader
out Data {
  vec3 Pos;
  vec3 Normal;
} DataOut;

layout (std140) uniform UBO {
  int   IsInstance;
  vec3  Mambient;   // Umgebungslicht
  vec3  Mdiffuse;   // Farbe
  vec3  Mspecular;  // Spiegelnd
  float Mshininess; // Glanz
  mat4 ModelMatrix; // Matrix des Modeles, ohne Frustum-Beeinflussung.
  mat4 Matrix;      // Matrix für die Drehbewegung und Frustum.
  vec2 pos[19];
};

const mat2x2 m2[] = mat2x2[] (
  mat2x2( 1.0000000,  0.0000000,  0.0000000,  1.0000000),
  mat2x2( 0.4999999, -0.8660254,  0.8660254,  0.4999999),
  mat2x2(-0.5000000, -0.8660253,  0.8660253, -0.5000000),
  mat2x2(-1.0000000,  0.0000000, -0.0000000, -1.0000000),
  mat2x2(-0.4999999,  0.8660254, -0.8660254, -0.4999999),
  mat2x2( 0.4999999,  0.8660254, -0.8660254,  0.4999999));

void main(void)
{
  vec3 n = inNormal;
  vec3 p = inPos;

  if (IsInstance > 0 ) {
    p.xy += pos[gl_InstanceID % 30];
    p.xy = m2[gl_InstanceID / 30] * p.xy;
    n.xy = m2[gl_InstanceID / 30] * n.xy;
  }

  DataOut.Pos    = (ModelMatrix * vec4(p, 1.0)).xyz;
  DataOut.Normal = mat3(ModelMatrix) * n;
  gl_Position    = Matrix * vec4(p, 1.0);
}
