#version 330

// Licht
#define Lposition  vec3(1.0, 0.5, 1.0)
#define Lambient   vec3(1.2, 1.2, 1.2)
#define Ldiffuse   vec3(1.5, 1.5, 1.5)

// Material ( Gold )
#define Mambient   vec3(0.25, 0.20, 0.07)
#define Mdiffuse   vec3(0.75, 0.60, 0.23)
#define Mspecular  vec3(0.63, 0.56, 0.37)
#define Mshininess 51.2

// Daten vom Vertex-Shader
in Data {
  vec3 Normal;
} DataIn;

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
  outColor = vec4(Light(Lposition, DataIn.Normal), 1.0);
}
