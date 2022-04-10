<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>30 - Point Light Fragment-Shader</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die Berechnung des Lichtes wurde in den Fertex-Shader ausgelagert, somit sieht das Punkt-Licht viel realistischer aus.<br>
Am besten sieht man dies, wen man nur ein Würfel darstellt.<br>
<br>
Der Nachteil dabei, es wird mehr <b>GPU</b>-Leistung verlangt, als wen man es im Vertex-Shader berechnet.<br>
<hr><br>
Hier sieht man, das die Berechnung des Lichtes im Fragment-Shader ist.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 1) in vec3 inNormal; // Normale</font>

// Daten für Fragment-shader
out Data {
  vec3 pos;
  vec3 Normal;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void) {
  gl_Position    = Matrix * vec4(inPos, 1.0);</font>

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

#define ambient vec3(0.2, 0.2, 0.2)</font>
#define red     vec3(1.0, 0.0, 0.0)</font>
#define green   vec3(0.0, 1.0, 0.0)</font>
#define blue    vec3(0.0, 0.0, 1.0)</font>

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
  return clamp(d, 0.0, 1.0);</font>
}

void main(void) {
  outColor = vec4(ambient, 1.0);</font>
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
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
