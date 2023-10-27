#version 330

#define LightPos vec3(1.0, 1.0, 0.0)

out vec4 outColor;  // Ausgegebene Farbe.

in vec3 gcol;
in vec3 gnorm;

float light(vec3 p, vec3 n) {
  vec3  v1 = normalize(p);       // Vektoren normalisieren,
  vec3  v2 = normalize(n);       // so das die Länge des Vektors immer 1.0 ist.
  float d  = dot(v1, v2);        // Skalarprodukt aus beiden Vektoren berechnen.
  float c  = clamp(d, 0.0, 1.0); // Alles > 1.0 und < 0.0, wird zwischen 0.0 und 1.0 gesetzt.
  return c;                      // Lichtstärke als Rückgabewert.
}

void main(void)
{
  float col    = light(LightPos, gnorm);
  outColor        = vec4(col, col, col, 1.0);

//  outColor = vec4(gcol, 1.0);
}
