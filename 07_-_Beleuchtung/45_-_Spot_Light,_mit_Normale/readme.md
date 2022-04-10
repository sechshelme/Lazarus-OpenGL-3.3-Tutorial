<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>45 - Spot Light, mit Normale</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Jetzt wird auch die normale berücksicht. Somit wird nur die Vorderseite der Dreiecke beleuchtet, so wie es beim Punktlicht auch der Fall ist.<br>
Diese Berechnung funktioniert genau gleich, wie beim Punktlicht. Somit wird auch wieder eine <b>Normale</b> gebraucht.<br>
<hr><br>
Hier wird die Kegelberechnung ausgeführt.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 1) in vec3 inNormal; // Normale</font>

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
<br>
Zuerst wird geprüft, ob das Fragment sich im Lichtkegel befindet.<br>
Anschliessend wird die Flächenanleuchtung gleich berechnet, wie beim Punktlicht.<br>
<pre><code>#version 330</font>

#define ambient vec3(0.2, 0.2, 0.2)</font>
#define red     vec3(1.0, 0.0, 0.0)</font>
#define green   vec3(0.0, 1.0, 0.0)</font>
#define blue    vec3(0.0, 0.0, 1.0)</font>

#define PI      3.1415</font>
#define Cutoff  cos(PI / 2 / 4)</font>

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
  angle = max(angle, 0.0);</font>

  if(angle > Cutoff) {
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
  return clamp(d, 0.0, 1.0);</font>
}

void main(void) {
  outColor = vec4(ambient, 1.0);</font>
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

</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
