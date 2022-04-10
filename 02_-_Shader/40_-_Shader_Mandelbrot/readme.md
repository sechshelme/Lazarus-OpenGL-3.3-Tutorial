<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>40 - Shader Mandelbrot</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Zum Schluss eine kleine Spielerei: Hier wird ein Mandelbrot im Shader (also auf der GPU) berechnet.<br>
Mit der CPU hatte ich noch keine so schnelle Berechnung hingekriegt, trotz Assembler.<br>
<br>
Anmerkung: Bei diesem Beispiel geht es nicht um mathematische Hintegründe, sondern es soll legentlich demonstrieren, das man mit Shader-Programs sehr komplexe Berechnungen machen kann.<br>
<br>
Der Lazarus-Code ist nichts besonderes, es wird nur ein Rechteck gerendert und anschliessend mit einer Matrix gedreht. Was eine Matrix ist, wird im Kapitel Matrix beschrieben.<br>
<b>Achtung:</b> Eine lahme Grafikkarte kann bei Vollbild ins Stockern kommen.<br>
Zur Beschleunigung kann der Wert <b>#define depth 1000.0</b> im Fragment-Shader verkleinert werden.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos;   // Vertex-Koordinaten</font>

uniform mat4 mat;

out vec2 pos;                           // Koordinaten für den Fragment-Shader

void main(void) {
  gl_Position = mat * vec4(inPos, 1.0);</font>
  pos = gl_Position.xy;                 // XY an Fragment-Shader
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<br>
Hier steckt die ganze Berechnung für das Mandelbrot.<br>
<pre><code>#version 330</font>
#define depth 1000.0</font>

in vec2 pos;       // Interpolierte Koordinaten vom Vertex-Shader

uniform float col; // Start-Wert, für Farben-Spielerei

out vec4 outColor;

void main(void) {
  float creal = pos.x * 1.5 - 0.3;</font>
  float cimag = pos.y * 1.5;</font>

  float Color = 0.0;</font>
  float XPos  = 0.0;</font>
  float YPos  = 0.0;</font>

  float SqrX, SqrY;

  do {
    SqrX   = XPos * XPos;
    SqrY   = YPos * YPos;
    YPos   = XPos * YPos * 2 + cimag;</font>
    XPos   = SqrX - SqrY + creal;
    Color += 1;</font>
  } while (!((SqrX + SqrY > 8) || (Color > depth)));

  Color += col;

  if (Color > depth) {
    Color -= depth;
  }

  outColor = vec4(Color / 3, Color / 10 , Color / 100, 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
