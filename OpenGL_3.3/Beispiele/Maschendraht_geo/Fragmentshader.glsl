#version 330

// Licht
//#define Lposition1  vec3(170.0, 117.5, 35.0)
#define Lposition1  vec3(70.0, 117.5, 35.0)
#define Lcolor1     vec3(1.0, 0.0, 1.0)

//#define Lposition2  vec3(-170.0, -117.5, 35.0)
#define Lposition2  vec3(-70.0, 117.5, 35.0)
#define Lcolor2     vec3(0.0, 1.0, 1.0)

#define Lambient   vec3(1.8, 1.8, 1.8)
#define Ldiffuse   vec3(1.5, 1.5, 1.5)

// Material ( Poliertes Kupfer  )
#define Mambient   vec3(0.23, 0.09, 0.03)
#define Mdiffuse   vec3(0.55, 0.21, 0.07)
#define Mspecular  vec3(0.58, 0.22, 0.07)
#define Mshininess 51.2

// Daten vom Vertex-Shader
in GS_OUT {
    vec3 Pos;
    vec3 Normal;
} fs_in;


out vec4 outColor;

vec3 Light(in vec3 p, in vec3 n, in vec3 l) {
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
  return ((Mambient * Lambient) + diffuse + specular) * l;
}

void main(void) {
  outColor =
    vec4(Light(Lposition1 - fs_in.Pos, fs_in.Normal, Lcolor1), 1.0) +
    vec4(Light(Lposition2 - fs_in.Pos, fs_in.Normal, Lcolor2), 1.0);
}
