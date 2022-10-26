# 07 - Beleuchtung
## 25 - Point Light Vertex-Shader

![image.png](image.png)

In diesem Beispiel werden Würfel anstelle der Kugeln verwendet.

Das Licht wird immer noch im Vertex-Shader berechnet, die hat zwar den Vorteil, das es einges schneller geht als mit dem Fragmsnt-Shader.
Dafür ist di Darstellung des Point-Lichtes unrealistisch. Das sieht man gut, wen man nur ein Würfel darstellt, da ist die Fläche eines Dreieckes sehr gross.
Bei den Kugel war dieser Effekt kaum sichtbar, das sehr kleine Dreiecke verwendet werden.
---
<b>Vertex-Shader:</b>

```glsl
#version 330

#define ambient vec3(0.2, 0.2, 0.2)
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

uniform mat4 ModelMatrix;
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

uniform bool RedOn;
uniform bool GreenOn;
uniform bool BlueOn;

uniform vec3 RedLightPos;
uniform vec3 GreenLightPos;
uniform vec3 BlueLightPos;

float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);
}

void main(void) {
  gl_Position = Matrix * vec4(inPos, 1.0);

  vec3 Normal = mat3(ModelMatrix) * inNormal;
  vec3 pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;

  Color = vec4(ambient, 1.0);
  if (RedOn) {
    vec3 colRed = light(RedLightPos - pos, Normal) * red;
    Color.rgb += colRed;
  }
  if (GreenOn) {
    vec3 colGreen = light(GreenLightPos - pos, Normal) * green;
    Color.rgb += colGreen;
  }
  if (BlueOn) {
    vec3 colBlue = light(BlueLightPos - pos, Normal) * blue;
    Color.rgb += colBlue;
  }
}

```

---
<b>Fragment-Shader</b>

```glsl
#version 330

in  vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void) {
  outColor = Color; // Die Ausgabe der Farbe
}

```


