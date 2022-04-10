<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>00 - Einfachster Vertex-Puffer</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>00 - Einfachster Vertex-Puffer</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
<hr><br>
Die Deklaration der Vektor-Koordianten Konstanten.<br>
<pre><code><b><font color="0000BB">const</font></b>
  <i><font color="#FFFF00">// Dreieck</font></i>
  Triangle: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">0</font>] <b><font color="0000BB">of</font></b> TFace =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">7</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));

  <i><font color="#FFFF00">// Quadrat</font></i>
  Quad: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));</pre></code>
Hier werden die Daten in die Grafikkarte geschrieben.<br>
Es hat nichts besonderes.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  <i><font color="#FFFF00">// Daten für das Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Daten für das Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</pre></code>
Bei <b>glDrawArrays(...</b> ist der erste Parameter das wichtigste, hier wird angegeben, wie die Vektor-Koordinaten gezeichnet werden.<br>
Hier im Beispiel, sind dies einfache Dreiecke.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Triangle) * <font color="#0077BB">3</font>);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>);</pre></code>
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
