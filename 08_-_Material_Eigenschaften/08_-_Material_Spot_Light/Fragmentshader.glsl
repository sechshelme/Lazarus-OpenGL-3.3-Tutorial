#version 330

#define PI         3.1415

// === Licht
#define Lposition  vec3(7.5, 7.5, 100.0)
#define Lambient   vec3(1.8, 1.8, 1.8)
#define Ldiffuse   vec3(19.5, 19.5, 19.5)

// === Material ( Poliertes Kupfer  )
#define Mambient   vec3(0.23, 0.09, 0.03)
#define Mdiffuse   vec3(0.55, 0.21, 0.07)
#define Mspecular  vec3(0.58, 0.22, 0.07)
#define Mshininess 51.2

// === Spotlicht Parameter
// Öffnungswinkel der Lampe
// 22.5°
#define Cutoff        cos(PI / 2 / 4)

// Lichtrichtung, brennt senkrecht in der Z-Achse.
#define spotDirection vec3(0.0, 0.0, -1.0)

// === Für Abschwächung
// default 0.0
#define spotExponent  50.0

// Diese Werte entsprechen Attenuation Parametern vom alten OpenGL.
// default 1.0
#define spotAttConst  1.0
// default 0.0
#define spotAttLinear 0.1
// default 0.0
#define spotAttQuad   0.0



// Daten vom Vertex-Shader
in Data {
  vec3 Pos;
  vec3 Normal;
} DataIn;

out vec4 outColor;

// Abschwächung, abhängig vom Radius des Lichtes.
float isConeAtt(vec3 LightPos) {
  vec3  lightDirection = normalize(DataIn.Pos - LightPos);

  float D              = length(LightPos - DataIn.Pos);
  float attenuation    = 1.0 / (spotAttConst + spotAttLinear * D + spotAttQuad * D * D);

  float angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, 0.0, 1.0);

  if(angle > Cutoff) {
    return attenuation;
  } else {
    return 0.0;
  }
}

// Abschwächung anhängig der Lichtentfernung zum Mesh.
float isConeExp(vec3 LightPos) {
  vec3  lightDirection = normalize(DataIn.Pos - LightPos);

  float angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, 0.0, 1.0);

  if(angle > Cutoff) {
    return pow(angle, spotExponent);
  } else {
    return 0.0;
  }
}

// Lichtstärke und Material anhand der Normale.
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
    specular = vec3(0.0, 0.0, 0.0);
    diffuse  = vec3(0.0, 0.0, 0.0);
  }
  return (Mambient * Lambient) + diffuse + specular;
}

void main(void)
{
  // Kombiniert ( Rechte )
  float c1 = isConeAtt(Lposition);
  float c2 = isConeExp(Lposition);
  float c  = c1 * c2; // Beide Abschwächungen multipizieren.
  outColor = vec4(vec3(c)  * Light(Lposition - DataIn.Pos, DataIn.Normal), 1.0);
}

