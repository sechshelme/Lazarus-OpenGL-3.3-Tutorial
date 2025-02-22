#version 330

// Licht
#define Lposition  vec3(35.0, 17.5, 35.0)
#define Lambient   vec3(1.8, 1.8, 1.8)
#define Ldiffuse   vec3(1.5, 1.5, 1.5)

// Daten vom Vertex-Shader
in Data {
  vec3 Pos;
  vec2 UV0;
  vec3 Normal;
} DataIn;

uniform sampler2D Texture;

layout (std140) uniform UBO {
  vec3  Mambient;   // Umgebungslicht
  vec3  Mdiffuse;   // Farbe
  vec3  Mspecular;  // Spiegelnd
  float Mshininess; // Glanz
  mat4 ModelMatrix; // Matrix des Modeles, ohne Frustum-Beeinflussung.
  mat4 Matrix;      // Matrix für die Drehbewegung und Frustum.
  int CubeEnabled;
};

out vec4 outColor;

vec3 Light(in vec3 p, in vec3 n) {
  vec3 nn = normalize(n);
  vec3 np = normalize(p);
  vec3 diffuse;   // Licht
  vec3 specular;  // Reflektion
  float angele = max(dot(nn, np), 0.0);
  if (angele > 0.0) {
    vec3 eye = normalize(np + vec3(0.0, 0.0, 1.0));
    specular = pow(max(dot(eye, nn), 0.0), Mshininess) * Mspecular;
    diffuse  = angele * Mdiffuse * Ldiffuse;
  } else {
    specular = vec3(0.0);
    diffuse  = vec3(0.0);
  }
  return (Mambient * Lambient) + diffuse + specular;
}

void main(void) {
  vec4 c = vec4(1.0, 1.0, 1.0, 1.0) - texture(Texture, DataIn.UV0);
  if (CubeEnabled != 0) {
    c.rgb += vec3(0.7, 0.7, 0.7);
  }

  outColor = vec4(Light(Lposition - DataIn.Pos, DataIn.Normal), 1.0) + c;
}

