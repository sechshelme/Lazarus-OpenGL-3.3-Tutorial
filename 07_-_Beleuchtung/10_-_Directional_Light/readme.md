# 07 - Beleuchtung
## 10 - Directional Light

![image.png](image.png)

Das Directional-Light entspricht in etwa dem Sonnen-Licht, die Lichtstrahlen kommen alle von der gleichen Richtung.
Im Grunde ist die Sonne auch ein Punktlicht, aber auf der Erde nimmt man es als Directional-Light war.
Im Beispiel von Rechts.

Im ersten Beispiel wurde die Beleuchung mit Acos und Pi berechnet.
Dieser Umweg kann man sich sparen, es gibt zwar so ein kleiner Rechnungsfehler, aber diesen kann man getrost ingnorieren.
Dies hat sogar den Vorteil, wen der Einstrahlwinkel des Lichtes flacher als 90° ist, ist die Beleuchtungsstärke gleich null.
Als was flacher als 90° ist, ist negativ.
Für dies gibt es in GLSL eine fertige Funktion **clamp**, mit der kann man einen Bereich festlegen.
So das es in diesem Beispiel keinen Wert < **0.0** oder > **1.0** gibt.

Der einzige Unterschied zu vorherigem Beispiel ist im Shader-Code. Auch der Hintergrund wurde etwas dunkler gemacht, das man den Licht-Effekt besser sieht.

Bei dem Lichtpositions-Vector ist es egal, wie weit die Lichtquelle weg ist, da der Vektor nur die Lichtrichtung angeben muss.
Meistens nimmt man aber einen **Einheitsvektor**, das ist ein Vektor mit der Länge **1.0**.
Die Lichtposition wird im Vertex-Shader als Konstante definiert.

---

---
Hier sieht man, das anstelle von arcos und Pi, **clamp** verwendet wurde.
**Vertex-Shader:**

```glsl
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

```


---
**Fragment-Shader**

```glsl
#version 330

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void) {
  outColor = Color; // Die Ausgabe der Farbe
}

```


