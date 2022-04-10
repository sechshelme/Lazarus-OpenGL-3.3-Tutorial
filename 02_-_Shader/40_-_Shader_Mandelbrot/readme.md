<!DOCTYPE html>
<html>
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
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;   <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> pos;                           <i><font color="#FFFF00">// Koordinaten für den Fragment-Shader</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  pos = gl_Position.xy;                 <i><font color="#FFFF00">// XY an Fragment-Shader</font></i>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<br>
Hier steckt die ganze Berechnung für das Mandelbrot.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<b><font color="#008800">#define</font></b> depth <font color="#0077BB">1000</font>.<font color="#0077BB">0</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> pos;       <i><font color="#FFFF00">// Interpolierte Koordinaten vom Vertex-Shader</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">float</font></b> col; <i><font color="#FFFF00">// Start-Wert, für Farben-Spielerei</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  <b><font color="0000BB">float</font></b> creal = pos.x * <font color="#0077BB">1</font>.<font color="#0077BB">5</font> - <font color="#0077BB">0</font>.<font color="#0077BB">3</font>;
  <b><font color="0000BB">float</font></b> cimag = pos.y * <font color="#0077BB">1</font>.<font color="#0077BB">5</font>;

  <b><font color="0000BB">float</font></b> Color = <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  <b><font color="0000BB">float</font></b> XPos  = <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  <b><font color="0000BB">float</font></b> YPos  = <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;

  <b><font color="0000BB">float</font></b> SqrX, SqrY;

  <b><font color="0000BB">do</font></b> {
    SqrX   = XPos * XPos;
    SqrY   = YPos * YPos;
    YPos   = XPos * YPos * <font color="#0077BB">2</font> + cimag;
    XPos   = SqrX - SqrY + creal;
    Color += <font color="#0077BB">1</font>;
  } <b><font color="0000BB">while</font></b> (!((SqrX + SqrY > <font color="#0077BB">8</font>) || (Color > depth)));

  Color += col;

  <b><font color="0000BB">if</font></b> (Color > depth) {
    Color -= depth;
  }

  outColor = <b><font color="0000BB">vec4</font></b>(Color / <font color="#0077BB">3</font>, Color / <font color="#0077BB">10</font> , Color / <font color="#0077BB">100</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>

</html>
