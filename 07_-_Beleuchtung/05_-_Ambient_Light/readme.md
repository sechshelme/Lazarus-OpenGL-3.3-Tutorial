# 07 - Beleuchtung
## 05 - Ambient Light

![image.png](image.png)

Das Ambient-Light ist nut eine einfache Raumausleuchtung, die ganze Meshes erscheint im gleichen Farbton.
Bei reiner Ambienten Ausleuchtung wird <b>keine</b> Normale gebraucht.

In der Praxis wir Ambient mit anderen Beleuchtungen kombiniert.

Am Shader an sieht man, wie einfach Ambient ist.
---
<b>Vertex-Shader:</b>

```glsl
#version 330

// Eine leichte Ausleuchtung in Grau.
#define ambient vec3(0.2, 0.2, 0.2)

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void) {
  gl_Position = Matrix * vec4(inPos, 1.0);

  Color = vec4(ambient, 1.0);
}

```

---
<b>Fragment-Shader</b>

```glsl
#version 330

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void) {
  outColor = Color; // Die Ausgabe der Farbe
}

```


