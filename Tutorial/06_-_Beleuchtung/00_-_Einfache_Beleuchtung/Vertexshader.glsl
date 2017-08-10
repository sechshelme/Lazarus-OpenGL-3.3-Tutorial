#version 330

#define PI 3.1415926535897932384626433832795

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

vec3 LightPos = vec3(1.0, 0.0, 0.0);

float angele(vec3 p, vec3 q){
  vec3  r1 = normalize(p);              // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3  r2 = normalize(q);              // In diesem Beispiel sind diese schon 1.0, aber in der Praxis können auch andere Werte ankommen.
  float d  = dot(r1, r2);               // Skalarprodukt aus beiden Vektoren berechnen.
  return acos(d);                       // Davon noch den Arkuskosinus berechnen. Somit hat man den Winkel zwischen den beiden Vektoren.
}

void main(void)
{
  vec3 Normal = mat3(Matrix) * inNormal;

  float w = angele(LightPos, Normal);   // Den Winkel der beiden Vektoren berechnen.
  float col = (w / PI);                 // Anschliessend diesen noch durch Pi teilen, da 0° Weiss und 180° Schwarz sein soll.
                                        // Der Winkel ist bei 180° = Pi.

  gl_Position = Matrix * vec4(inPos, 1.0);
  Color = vec4(col, col, col, 0.0);
}
