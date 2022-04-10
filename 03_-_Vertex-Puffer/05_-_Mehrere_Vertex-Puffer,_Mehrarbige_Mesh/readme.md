<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>05 - Mehrere Vertex-Puffer, Mehrarbige Mesh</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt wurde immer nur ein Vertex-Puffer pro Mesh geladen, hier wird ein zweiter geladen, welcher die Farben der Vektoren enthält.<br>
Somit werden die Mesh mehrfarbig.<br>
<hr><br>
Es sind zwei zusätzliche Vertex-Konstanten dazu gekommen, welche die Farben der Ecken enthält.<br>
<pre><code>const
  TriangleVector: array[0..0] of TFace =</font>
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));</font>
  TriangleColor: array[0..0] of TFace =   // Rot / Grün / Blau</font>
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)));</font>
  QuadVector: array[0..1] of TFace =</font>
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));</font>
  QuadColor: array[0..1] of TFace =       // Rot / Grün / Gelb / Rot / Gelb / Mint</font>
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (1.0, 1.0, 0.0)),</font>
    ((1.0, 0.0, 0.0), (1.0, 1.0, 0.0), (0.0, 1.0, 1.0)));</font></pre></code>
Für die Farbe ist ein zusätzliches <b>Vertex Buffer Object</b> (VBO) hinzugekommen.<br>
<pre><code>type
  TVB = record
    VAO,
    VBOvert,         // VBO für Vektor.
    VBOcol: GLuint;  // VBO für Farbe.
  end;</pre></code>
CreateScene wurde um zwei Zeilen erweitert.<br>
Die VB0 für den Farben-Puffer müssen noch generiert werden.<br>
<pre><code>  glGenBuffers(1, @VBTriangle.VBOvert);
  glGenBuffers(1, @VBTriangle.VBOcol);   // neu hinzugekommen
  glGenBuffers(1, @VBQuad.VBOvert);</font>
  glGenBuffers(1, @VBQuad.VBOcol);       // neu hinzugekommen</pre></code>
Hier fast der wichtigste Teil, pro <b>Vertex Array Object</b> (VAO) wird ein zweiter Puffer in das VRAM geladen.<br>
Die 10 und 11, muss indentisch sein, mit dem <b>location</b> im Shader.<br>
<pre><code>procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  // --- Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);</font>
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);
end;</pre></code>
Jetzt kommt wieder ein grosser Vorteil von OpenGL 3.3, das Zeichnen geht gleich einfach wie wen man nur ein VBO hat.<br>
<pre><code>  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);</pre></code>
Am Ende müssen noch die zusätzlichen VBO-Puffer frei gegeben werden.<br>
Freigaben müssen immer gleich viele sein wie Erzeugungen.<br>
<pre><code>  glDeleteBuffers(1, @VBTriangle.VBOvert);
  glDeleteBuffers(1, @VBTriangle.VBOcol);</font>
  glDeleteBuffers(1, @VBQuad.VBOvert);</font>
  glDeleteBuffers(1, @VBQuad.VBOcol);</font></pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Hier ist eine zweite Location hinzugekommen, wichtig ist, das die Location-Nummer übereinstimmt, mit denen beim Vertex-Laden.<br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 11) in vec3 inCol; // Farbe</font>

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
  Color = vec4(inCol, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
