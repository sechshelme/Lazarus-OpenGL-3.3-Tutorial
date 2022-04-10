<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>05 - Polygon - Seite (Backface Culling)</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>05 - 3D</h1></b>
    <b><h2>05 - Polygon - Seite (Backface Culling)</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die Meshes ist hier noch 2D, aber <b>Backface Culling</b> wird in folgenden 3D-Beispielen gebraucht.<br>
<br>
Defaultmässig zeichnet OpenGL immer die Vorder und Rückseite eines Polygones. Für die meisten Meshes ist dies aber nicht nötig.<br>
Bei einem Würfel ist es nicht nötig, das die Innenseite der Polygone gezeichnet werden, da man diese sowieso nicht sieht.<br>
Dies spart Rechneleistung, weil jede Pixelüberprüfung Zeit kostet.<br>
Mit <b>glEnable(GL_CULL_FACE);</b> wird nur die Vorderseite der Polygone gezeichnet. Ausgenommen man schaltet es mit <b>glCullFace(...</b> um, so das nur die Rückseite gezeichnet wird.<br>
<br>
In diesem Beispiel, wird dies mit einem Timer demonstriert.<br>
<br>
Was dabei wichtig ist, die Polygone müssen immer im Gegenuhrzeigersinn gerendert werden. Auch dies könnte man <b>glFrontFace(...</b> umstellen.<br>
Dafür gibt es die Parameter <b>GL_CW</b> für Uhrzeigersinn, und den Default-Parameter <b>GL_CCW</b>.<br>
<hr><br>
Wen man die Konstanten genau anschaut, sieht man, das das Dreieck im Gegenuhrzegersinn und das Qaudrat im Uhrzeigersinn deklariert ist.<br>
<pre><code><b><font color="0000BB">const</font></b>
  <i><font color="#FFFF00">// Dreieck</font></i>
  Triangle: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">0</font>] <b><font color="0000BB">of</font></b> TFace =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">7</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));

  <i><font color="#FFFF00">// Quadrat</font></i>
  Quad: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));</pre></code>
Hier wird die Backface Culling aktiviert:<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glEnable(GL_CULL_FACE);           <i><font color="#FFFF00">// Überprüfung einschalten</font></i></pre></code>
Hier wird zwischen der Rück und Vorder-Seite umgesschalten.<br>
Man sagt immer, welche Seite nicht gezeichnet wird.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  CullFace: boolean = <b><font color="0000BB">False</font></b>;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">if</font></b> CullFace <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    glCullFace(GL_BACK);      <i><font color="#FFFF00">// Rückseite nicht zeichnen.</font></i>
  <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">begin</font></b>
    glCullFace(GL_FRONT);     <i><font color="#FFFF00">// Vorderseite nicht zeichnen.</font></i>
  <b><font color="0000BB">end</font></b>;
  CullFace := <b><font color="0000BB">not</font></b> CullFace;
  ogc.Invalidate;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  <b><font color="0000BB">vec3</font></b> col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  outColor = <b><font color="0000BB">vec4</font></b>(col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
