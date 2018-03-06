#version 330

// Licht
#define Lposition     vec3(1.0, 0.5, 1.0)
#define Lambient      vec3(1.2, 1.2, 1.2)
#define Ldiffuse      vec3(1.5, 1.5, 1.5)
#define Lspecular     vec3(1.0, 1.0, 1.0)

// Material Gold
#define Mambient      vec3(0.25, 0.20, 0.07)
#define Mdiffuse      vec3(0.75, 0.60, 0.23)
#define Mspecular     vec3(0.63, 0.56, 0.37)
#define Mshininess    51.2

//// Material Perle
//#define Mambient      vec3(0.25, 0.21, 0.21)
//#define Mdiffuse      vec3(1.00, 0.83, 0.83)
//#define Mspecular     vec3(0.30, 0.30, 0.30)
//#define Mshininess    11.3

// Daten vom Vertex-Shader
in Data {
  vec3 Normal;
} DataIn;

out vec4 outColor;  // ausgegebene Farbe

vec3 Light(in vec3 p, in vec3 n) {
  vec3 nn = normalize(n);
  vec3 np = normalize(p);
  vec3 diffuse;
  vec3 specular;
  float angele = max(dot(nn, np), 0.0);
  if (angele > 0.0) {
    vec3 H   = normalize(np + vec3(0.0, 0.0, 1.0));
    specular = pow(max(dot(H, nn), 0.0), Mshininess) * Mspecular * Lspecular;
    diffuse  = angele * Mdiffuse * Ldiffuse;
  } else {
    specular = vec3(0.0, 0.0, 0.0);
    diffuse  = vec3(0.0, 0.0, 0.0);
  }
  return (Mambient * Lambient) + diffuse + specular;
}

void main(void)
{
  outColor = vec4(Light(Lposition, DataIn.Normal), 1.0);  // Die Ausgabe der Farbe
}
