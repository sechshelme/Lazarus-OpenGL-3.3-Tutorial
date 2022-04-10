<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>25 - Point Light Vertex-Shader</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
In diesem Beispiel werden Würfel anstelle der Kugeln verwendet.<br>
<br>
Das Licht wird immer noch im Vertex-Shader berechnet, die hat zwar den Vorteil, das es einges schneller geht als mit dem Fragmsnt-Shader.<br>
Dafür ist di Darstellung des Point-Lichtes unrealistisch. Das sieht man gut, wen man nur ein Würfel darstellt, da ist die Fläche eines Dreieckes sehr gross.<br>
Bei den Kugel war dieser Effekt kaum sichtbar, das sehr kleine Dreiecke verwendet werden.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

#define ambient vec3(0.2, 0.2, 0.2)</font>
#define red     vec3(1.0, 0.0, 0.0)</font>
#define green   vec3(0.0, 1.0, 0.0)</font>
#define blue    vec3(0.0, 0.0, 1.0)</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 1) in vec3 inNormal; // Normale</font>

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
  return clamp(d, 0.0, 1.0);</font>
}

void main(void) {
  gl_Position = Matrix * vec4(inPos, 1.0);</font>

  vec3 Normal = mat3(ModelMatrix) * inNormal;
  vec3 pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;</font>

  Color = vec4(ambient, 1.0);</font>
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
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in  vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void) {
  outColor = Color; // Die Ausgabe der Farbe
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
