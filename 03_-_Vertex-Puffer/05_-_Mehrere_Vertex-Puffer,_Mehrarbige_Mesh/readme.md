<!DOCTYPE html>
<html>
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>05 - Mehrere Vertex-Puffer, Mehrarbige Mesh</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt wurde immer nur ein Vertex-Puffer pro Mesh geladen, hier wird ein zweiter geladen, welcher die Farben der Vektoren enthält.<br>
Somit werden die Mesh mehrfarbig.<br>
<hr><br>
Es sind zwei zusätzliche Vertex-Konstanten dazu gekommen, welche die Farben der Ecken enthält.<br>
<pre><code><b><font color="0000BB">const</font></b>
  TriangleVector: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">0</font>] <b><font color="0000BB">of</font></b> TFace =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">7</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));
  TriangleColor: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">0</font>] <b><font color="0000BB">of</font></b> TFace =   <i><font color="#FFFF00">// Rot / Grün / Blau</font></i>
    (((<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)));
  QuadVector: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));
  QuadColor: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace =       <i><font color="#FFFF00">// Rot / Grün / Gelb / Rot / Gelb / Mint</font></i>
    (((<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)),
    ((<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)));</pre></code>
Für die Farbe ist ein zusätzliches <b>Vertex Buffer Object</b> (VBO) hinzugekommen.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TVB = <b><font color="0000BB">record</font></b>
    VAO,
    VBOvert,         <i><font color="#FFFF00">// VBO für Vektor.</font></i>
    VBOcol: GLuint;  <i><font color="#FFFF00">// VBO für Farbe.</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
CreateScene wurde um zwei Zeilen erweitert.<br>
Die VB0 für den Farben-Puffer müssen noch generiert werden.<br>
<pre><code>  glGenBuffers(<font color="#0077BB">1</font>, @VBTriangle.VBOvert);
  glGenBuffers(<font color="#0077BB">1</font>, @VBTriangle.VBOcol);   <i><font color="#FFFF00">// neu hinzugekommen</font></i>
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOvert);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOcol);       <i><font color="#FFFF00">// neu hinzugekommen</font></i></pre></code>
Hier fast der wichtigste Teil, pro <b>Vertex Array Object</b> (VAO) wird ein zweiter Puffer in das VRAM geladen.<br>
Die 10 und 11, muss indentisch sein, mit dem <b>location</b> im Shader.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  <i><font color="#FFFF00">// --- Daten für Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);

  <i><font color="#FFFF00">// Vektor</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);                         <i><font color="#FFFF00">// 10 ist die Location in inPos Shader.</font></i>
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Farbe</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">11</font>);                         <i><font color="#FFFF00">// 11 ist die Location in inCol Shader.</font></i>
  glVertexAttribPointer(<font color="#0077BB">11</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// --- Daten für Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);

  <i><font color="#FFFF00">// Vektor</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Farbe</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">11</font>);
  glVertexAttribPointer(<font color="#0077BB">11</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</pre></code>
Jetzt kommt wieder ein grosser Vorteil von OpenGL 3.3, das Zeichnen geht gleich einfach wie wen man nur ein VBO hat.<br>
<pre><code>  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(TriangleVector) * <font color="#0077BB">3</font>);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVector) * <font color="#0077BB">3</font>);</pre></code>
Am Ende müssen noch die zusätzlichen VBO-Puffer frei gegeben werden.<br>
Freigaben müssen immer gleich viele sein wie Erzeugungen.<br>
<pre><code>  glDeleteBuffers(<font color="#0077BB">1</font>, @VBTriangle.VBOvert);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBTriangle.VBOcol);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOvert);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOcol);</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Hier ist eine zweite Location hinzugekommen, wichtig ist, das die Location-Nummer übereinstimmt, mit denen beim Vertex-Laden.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol; <i><font color="#FFFF00">// Farbe</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                       <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec4</font></b> Color;      <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>

</html>
