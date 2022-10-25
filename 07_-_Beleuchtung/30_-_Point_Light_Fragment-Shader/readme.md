# 07 - Beleuchtung
## 30 - Point Light Fragment-Shader

<img src="image.png" alt="Selfhtml"><br><br>
Die Berechnung des Lichtes wurde in den Fertex-Shader ausgelagert, somit sieht das Punkt-Licht viel realistischer aus.
Am besten sieht man dies, wen man nur ein Würfel darstellt.

Der Nachteil dabei, es wird mehr <b>GPU</b>-Leistung verlangt, als wen man es im Vertex-Shader berechnet.
<hr><br>
Hier sieht man, das die Berechnung des Lichtes im Fragment-Shader ist.

<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

// Daten für Fragment-shader
out Data {
  vec3 pos;
  vec3 Normal;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void) {
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
}

```

<hr><br>
<b>Fragment-Shader</b>

```glsl
#version 330

#define ambient vec3(0.2, 0.2, 0.2)
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

// Daten vom Vertex-Shader
in Data {
  vec3 pos;
  vec3 Normal;
} DataIn;

uniform bool RedOn;
uniform bool GreenOn;
uniform bool BlueOn;

uniform vec3 RedLightPos;
uniform vec3 GreenLightPos;
uniform vec3 BlueLightPos;

out vec4 outColor;  // ausgegebene Farbe

float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);
}

void main(void) {
  outColor = vec4(ambient, 1.0);
  if (RedOn) {
    vec3 colRed   = light(RedLightPos   - DataIn.pos, DataIn.Normal) * red;
    outColor.rgb += colRed;
  }
  if (GreenOn) {
    vec3 colGreen = light(GreenLightPos - DataIn.pos, DataIn.Normal) * green;
    outColor.rgb += colGreen;
  }
  if (BlueOn) {
    vec3 colBlue  = light(BlueLightPos  - DataIn.pos, DataIn.Normal) * blue;
    outColor.rgb += colBlue;
  }
}

```


