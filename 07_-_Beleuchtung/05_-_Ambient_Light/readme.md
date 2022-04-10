<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>05 - Ambient Light</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Das Ambient-Light ist nut eine einfache Raumausleuchtung, die ganze Meshes erscheint im gleichen Farbton.<br>
Bei reiner Ambienten Ausleuchtung wird <b>keine</b> Normale gebraucht.<br>
<br>
In der Praxis wir Ambient mit anderen Beleuchtungen kombiniert.<br>
<br>
Am Shader an sieht man, wie einfach Ambient ist.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

// Eine leichte Ausleuchtung in Grau.
#define ambient vec3(0.2, 0.2, 0.2)</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void) {
  gl_Position = Matrix * vec4(inPos, 1.0);</font>

  Color = vec4(ambient, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void) {
  outColor = Color; // Die Ausgabe der Farbe
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
