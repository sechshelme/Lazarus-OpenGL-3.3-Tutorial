# 07 - Beleuchtung
## 45 - Spot Light, mit Normale

![image.png](image.png)

Jetzt wird auch die normale berücksicht. Somit wird nur die Vorderseite der Dreiecke beleuchtet, so wie es beim Punktlicht auch der Fall ist.
Diese Berechnung funktioniert genau gleich, wie beim Punktlicht. Somit wird auch wieder eine <b>Normale</b> gebraucht.
---
Hier wird die Kegelberechnung ausgeführt.

<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

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

---
<b>Fragment-Shader</b>

Zuerst wird geprüft, ob das Fragment sich im Lichtkegel befindet.
Anschliessend wird die Flächenanleuchtung gleich berechnet, wie beim Punktlicht.

```glsl
#version 330

#define ambient vec3(0.2, 0.2, 0.2)
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

#define PI      3.1415
#define Cutoff  cos(PI / 2 / 4)

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

// Prüfen ob Fragment in Lichtkegel.
bool isCone(vec3 LightPos) {

  vec3 lp = LightPos;

  vec3 lightDirection = normalize(DataIn.pos - lp);
  vec3 spotDirection  = normalize(-LightPos);

  float angle = dot(spotDirection, lightDirection);
  angle = max(angle, 0.0);

  if(angle &gt; Cutoff) {
    return true;
  } else {
    return false;
  }
}

// Lichtstärke anhand der Normale.
float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);
}

void main(void) {
  outColor = vec4(ambient, 1.0);
  if (RedOn) {
    if (isCone(RedLightPos)) {
      outColor.rgb += light(RedLightPos - DataIn.pos, DataIn.Normal) * red;
    }
  }
  if (GreenOn) {
    if (isCone(GreenLightPos)) {
      outColor.rgb += light(GreenLightPos - DataIn.pos, DataIn.Normal) * green;
    }
  }
  if (BlueOn) {
    if (isCone(BlueLightPos)) {
      outColor.rgb += light(BlueLightPos - DataIn.pos, DataIn.Normal) * blue;
    }
  }
}


```


