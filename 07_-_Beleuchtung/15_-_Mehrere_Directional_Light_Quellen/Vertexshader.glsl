#version 330

// Konstante für Abiente Hintergrundbeleuchung.
#define ambient vec3(0.2, 0.2, 0.2)

// Die Farben der Lichtstrahlen.
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;

// Einzelne Lichtquellen Ein/Aus.
uniform bool RedOn;
uniform bool GreenOn;
uniform bool BlueOn;

// Position der Lichtquellen.
uniform vec3 RedLightPos;
uniform vec3 GreenLightPos;
uniform vec3 BlueLightPos;

// Berechnet die Ausleuchtung der einzelnen Faces.
float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren,
  vec3 v2 = normalize(n);     // so das es Einheitsvektoren gibt.
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);  // Bereich der Ausgabe einschränken.
}

void main(void)
{
  // Vektoren mit komplette vorberechneter Matrix multipizieren.
  gl_Position = Matrix * vec4(inPos, 1.0);

  // Normale nur mit lokaler Matrix Multipizieren.
  vec3 Normal = mat3(ModelMatrix) * inNormal;

  // Ambiente Lichtquelle
  Color = vec4(ambient, 1.0);

  // Lichtquellen auf verlangen berechnen und addieren.
  if (RedOn) {
    vec3 colRed = light(RedLightPos, Normal) * red;
    Color.rgb += colRed;
  }
  if (GreenOn) {
    vec3 colGreen = light(GreenLightPos, Normal) * green;
    Color.rgb += colGreen;
  }
  if (BlueOn) {
    vec3 colBlue = light(BlueLightPos, Normal) * blue;
    Color.rgb += colBlue;
  }
}
