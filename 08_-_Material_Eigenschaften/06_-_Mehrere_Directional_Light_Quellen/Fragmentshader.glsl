#version 330

// Konstante für Abiente Hintergrundbeleuchung.
#define ambient2 vec3(0.2, 0.2, 0.2)

// Die Farben der Lichtstrahlen.
#define LightPos     vec3(10.0, 0.0, 10.0)


// #define Lposition     vec4(200.0, 300.0, 100.0, 0.0)
#define Lposition     vec4(50.0, 0.0, 50.0, 0.0)


#define Lambient      vec4(0.8, 0.8, 0.8, 0.0)
#define Ldiffuse      vec4(2.0, 2.0, 2.0, 1.0)
#define Lspecular     vec4(1.0, 1.0, 1.0, 1.0)


#define Memission     vec4(0.0, 0.0, 0.0, 1.0)
#define Mambient      vec4(0.25, 0.20, 0.07, 1.0)
#define Mdiffuse      vec4(0.75, 0.60, 0.23, 1.0)
#define Mspecular     vec4(0.63, 0.56, 0.37, 1.0)
// #define Mshininess    51.2
#define Mshininess    0.4

// Daten vom Vertex-Shader
in Data {
  vec3 pos;
  vec3 Normal;
} DataIn;

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

// Berechnet die Ausleuchtung der einzelnen Faces.
float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren,
  vec3 v2 = normalize(n);     // so das es Einheitsvektoren gibt.
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);  // Bereich der Ausgabe einschränken.
}

vec4 Light(in vec3 Normal, in vec3 Position) {
  vec3 N       = normalize(Normal);
  vec4 emissiv = Memission;
  vec4 ambient = Mambient * Lambient;
  vec3 L       = normalize(vec3(Lposition) - Position);
  vec4 Pos_eye = vec4(0.0, 0.0, 1.0, 0.0);
  vec3 A       = Pos_eye.xyz;
  vec3 H       = normalize(L + A);
  vec4 diffuse       = vec4(0.0, 0.0, 0.0, 1.0);
  vec4 specular      = vec4(0.0, 0.0, 0.0, 1.0);
  float diffuseLight = max(dot(N, L), 0.0);
  if (diffuseLight > 0.0) {
    diffuse         = diffuseLight * Mdiffuse * Ldiffuse;
    float specLight = pow(max(dot(H, N), 0.0), Mshininess);
    specular        = specLight * Mspecular * Lspecular;
  }
  return emissiv + ambient + diffuse + specular;
}

void main(void)
{
  outColor = Light(DataIn.Normal, DataIn.pos);  // Die Ausgabe der Farbe
}
