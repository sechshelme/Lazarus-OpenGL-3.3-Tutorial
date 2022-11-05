# 16 - Bump Mapping
## 00 - Einfachstes Bump Mapping

![image.png](image.png)

Mit Bump-Maping kann man eine Oberfläche noch realistischer gestalten.
Da viele Oberflächen nicht absolut flach sind, so wie die Fugen im Beispiel, drift das Licht nicht immer gleichen Winkel auf die gesamte Oberfläche.
Um dies zu simulieren, nimmt man eine Textur, welche Winkelkorreturen enthält, dies ist eine **Normal-Map**

Lazarus-Seitig läuft die genau gleich ab, wie wen man eine enfache Textur lädt.
Die ganze Berechnung läuft im Fragment-Shader ab.

Der Rest der Beleuchtung läuft gleich ab, so wie bei den anderen Beleuchtungen auch.

---

---
**Vertex-Shader:**

```glsl
#version 330

layout (location =  0) in vec3 inPos;    // Vertex-Koordinaten
layout (location =  1) in vec3 inNormal; // Normale
layout (location = 10) in vec2 inUV;     // Textur-Koordinaten

// Daten für Fragment-Shader
out Data {
  vec3 pos;
  vec3 Normal;
  vec2 UV;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;

void main(void)
{
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
  DataOut.UV     = inUV;
}

```


---
**Fragment-Shader**

Hier sieht man, das die **Normal-Map** zur Normalen addiert wird.

```glsl
#version 330

// Beleuchtungs-Parameter
#define LightPos vec3(100.0, 100.0, 50.0)
#define ambient  vec3(0.1, 0.1, 0.1)

// Textur-Sampler für Normal-Map
uniform sampler2D Sampler;

// Daten vom Vertex-Shader
in Data {
  vec3 pos;
  vec3 Normal;
  vec2 UV;
} DataIn;

// Farb-Ausgabe.
out vec4 outColor;

// Ein einfaches Directional-Light.
vec4 light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);
  vec3 c  = vec3(clamp(d, 0.0, 1.0));
  return vec4(c, 1.0);
}

void main(void)
{
  // Ein Ambient-Light festlegen.
  outColor = vec4(ambient, 1.0);

  // Normal-Map zu Normalen addieren.
  vec3 n   = DataIn.Normal + normalize(texture2D(Sampler, DataIn.UV).rgb * 2.0 - 1.0);

  // Einfache Lichtberechnung.
  outColor = light(LightPos - DataIn.pos, n);
}

```


