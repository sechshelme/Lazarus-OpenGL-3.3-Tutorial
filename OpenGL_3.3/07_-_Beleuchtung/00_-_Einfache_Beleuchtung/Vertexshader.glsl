#version 330

// Die Lichtquelle befindet sich Links.
#define LightPos vec3(1.0, 0.0, 0.0)
#define PI       3.1415

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

uniform mat4 ModelMatrix;               // Matrix des Modeles, ohne Einfluss von Frustum.
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

float light(in vec3 p, in vec3 n) {
  vec3  v1 = normalize(p); // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3  v2 = normalize(n); // In diesem Beispiel sind diese schon 1.0, aber in der Praxis können auch andere Werte ankommen.
  float d  = dot(v1, v2);  // Skalarprodukt ( Winkel ) aus beiden Vektoren berechnen.
                           // Der Winkel ist bei 180° = Pi.

  d  = acos(d);            // Davon noch den Arkuskosinus berechnen. Somit hat man den Winkel zwischen den beiden Vektoren.
  d /= PI;                 // Anschliessend diesen noch durch Pi teilen, da 0° Weiss und 180° Schwarz sein soll.
  return d;
}

void main(void) {
  gl_Position  = Matrix * vec4(inPos, 1.0);    // Die komplette Berechnete Matrix.

  vec3  Normal = mat3(ModelMatrix) * inNormal; // Matrix mit lokalen Tranformationen.
  float col    = light(LightPos, Normal);      // Licht berechnen.

  Color        = vec4(col, col, col, 1.0);
}
