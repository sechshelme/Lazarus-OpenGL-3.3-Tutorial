#version 330

// Das Licht kommt von Rechts.
#define LightPos vec3(1.0, 0.0, 0.0)

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

uniform mat4 ModelMatrix;               // Matrix des Modell, ohne Frustumeinfluss.
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

float light(vec3 p, vec3 n) {
  vec3  v1 = normalize(p);       // Vektoren normalisieren,
  vec3  v2 = normalize(n);       // so das die Länge des Vektors immer 1.0 ist.
  float d  = dot(v1, v2);        // Skalarprodukt aus beiden Vektoren berechnen.
  float c  = clamp(d, 0.0, 1.0); // Alles > 1.0 und < 0.0, wird zwischen 0.0 und 1.0 gesetzt.
  return c;                      // Lichtstärke als Rückgabewert.
}

void main(void) {
  gl_Position  = Matrix * vec4(inPos, 1.0);

  vec3  Normal = mat3(ModelMatrix) * inNormal;
  float col    = light(LightPos, Normal);

  Color        = vec4(col, col, col, 1.0);
}
