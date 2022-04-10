<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>16 - Bump Mapping</h1></b>
    <b><h2>00 - Einfachstes Bump Mapping</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit Bump-Maping kann man eine Oberfläche noch realistischer gestalten.<br>
Da viele Oberflächen nicht absolut flach sind, so wie die Fugen im Beispiel, drift das Licht nicht immer gleichen Winkel auf die gesamte Oberfläche.<br>
Um dies zu simulieren, nimmt man eine Textur, welche Winkelkorreturen enthält, dies ist eine <b>Normal-Map</b><br>
<br>
Lazarus-Seitig läuft die genau gleich ab, wie wen man eine enfache Textur lädt.<br>
Die ganze Berechnung läuft im Fragment-Shader ab.<br>
<br>
Der Rest der Beleuchtung läuft gleich ab, so wie bei den anderen Beleuchtungen auch.<br>
<hr><br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location =  0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location =  1) in vec3 inNormal; // Normale</font>
layout (location = 10) in vec2 inUV;     // Textur-Koordinaten</font>

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
  gl_Position    = Matrix * vec4(inPos, 1.0);</font>

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;</font>
  DataOut.UV     = inUV;
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<br>
Hier sieht man, das die <b>Normal-Map</b> zur Normalen addiert wird.<br>
<pre><code>#version 330</font>

// Beleuchtungs-Parameter
#define LightPos vec3(100.0, 100.0, 50.0)</font>
#define ambient  vec3(0.1, 0.1, 0.1)</font>

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
  vec3 c  = vec3(clamp(d, 0.0, 1.0));</font>
  return vec4(c, 1.0);</font>
}

void main(void)
{
  // Ein Ambient-Light festlegen.
  outColor = vec4(ambient, 1.0);</font>

  // Normal-Map zu Normalen addieren.
  vec3 n   = DataIn.Normal + normalize(texture2D(Sampler, DataIn.UV).rgb * 2.0 - 1.0);</font>

  // Einfache Lichtberechnung.
  outColor = light(LightPos - DataIn.pos, n);
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
