<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>15 - Nur eine Array</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann die Vertex-Daten, auch alles in einen Daten-Block schreiben. Hier werden die Vector- und Color - Daten alle in einen Block geschrieben.<br>
In den vorherigen Beispielen hat es für die Vector- und  Color - Daten eine separate TFace-Array gehabt.<br>
Hier werden zwei Möglichkeiten vorgestellt, wie die Daten in der Array sind.<br>
Variante1: <b>Vec0, Col0, ..., Vecn, Coln</b><br>
Variante2: <b>Vec0, ..., Vecn, Col0, ..., Coln</b><br>
Die hat noch den Vorteil, das nur ein <b>VBO</b> angelegt werden muss, obwohl mehrere Attribute in der Array sind.<br>
<hr><br>
Die zwei Daten-Varianten:<br>
Variante 0: <b>XYZ RGB XYZ RGB XYZ RGB XYZ RGB XYZ RGB XYZ RGB</b><br>
Variante 1: <b>XYZ XYZ XYZ XYZ XYZ XYZ RGB RGB RGB RGB RGB RGB</b><br>
<br>
Bei dem zweiten Quadrat, sind die Y-Werte gespiegelt, es sollten zwei Quadrate sichtbar sein.<br>
<pre><code>const
  QuadVektor0: array[0..1] of TFace2 =</font>
    // Vec, Col, Vec, Col, ....
    (((-0.2, 0.6, 0.0, 1.0, 0.0, 0.0), (-0.2, 0.1, 0.0, 0.0, 1.0, 0.0), (0.2, 0.1, 0.0, 1.0, 1.0, 0.0)),
    ((-0.2, 0.6, 0.0, 1.0, 0.0, 0.0), (0.2, 0.1, 0.0, 1.0, 1.0, 0.0), (0.2, 0.6, 0.0, 0.0, 1.0, 1.0)));
  QuadVektor1: array[0..3] of TFace =</font>
    // Vec
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)),</font>
    // Col
    ((1.0, 0.0, 1.0), (1.0, 1.0, 0.0), (1.0, 1.0, 1.0)),</font>
    ((1.0, 0.0, 1.0), (1.0, 1.0, 1.0), (0.0, 1.0, 1.0)));</font></pre></code>
Hier die wichtigste Änderung:<br>
Relevant sind die zwei letzten Parameter von <b>glVertexAttribPointer(...</b><br>
Was irritiert der einte Parameter ist direkt ein Integer, der andere braucht eine Typenumwandlung auf einen Pointer.<br>
Der zweitletzte Parameter (stride), gibt das <b>Byte</b> Offset, zum nächsten Attribut-Wert an, repektive die Schritt/Block-grösse.<br>
Der letzte Parameter (pointer), gibt die Position zum ersten Attribut-Wert an.<br>
Die Werte sind immer als <b>Byte</b>, somit muss man bei einem <b>glFloat</b> immer <b>4x</b> rechnen.<br>
<br>
Varinate 0:<br>
Die Vektoren beginnen bei 0, Die Grösse ist 24Byte = 6 glFloat x 4 entspricht <b>XYZRGB</b>.<br>
Die Farben beginnen beim 12Byte. Die Grösse ist mit 24Byte gleich wie bei den Vektoren.<br>
<br>
Varinate 1:<br>
Da die Vektoren hintereinander stehen, darf dieser Default (0) sein.<br>
Die Farben beginnen beim 72Byte.<br>
<pre><code>procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  // --- Daten für Quadrat 0
  glBindVertexArray(VBQuad0.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBO); // Nur ein VBO erforderlich
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor0), @QuadVektor0, GL_STATIC_DRAW);

  // Vektor
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 24, nil);  // nil = Pointer(0)

  // Farbe
  glEnableVertexAttribArray(11);</font>
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 24, Pointer(12));</font>

  // --- Daten für Quadrat 1
  glBindVertexArray(VBQuad1.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBO); // Nur ein VBO erforderlich
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor1), @QuadVektor1, GL_STATIC_DRAW);

  // Vektor
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

  // Farbe
  glEnableVertexAttribArray(11);</font>
  glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, Pointer(72));</font>
end;</pre></code>
Das Zeichnen ist gleich, wie wen man separate Datenblöcke hätte. <br>
Es wurde das <b>Length(...</b> entfernt, da die einte Array zwei und die andere vier Elemente hat.<br>
Was aber sicher ist, das beide Quadrate aus sechs Vektoren bestehen.<br>
<pre><code>  // Zeichne Quadrat 0
  glBindVertexArray(VBQuad0.VAO);
  glDrawArrays(GL_TRIANGLES, 0, 6);  // 6 Vertex pro Quadrat</font>

  // Zeichne Quadrat 1
  glBindVertexArray(VBQuad1.VAO);
  glDrawArrays(GL_TRIANGLES, 0, 6);  // 6 Vertex pro Quadrat</font></pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Im Shader gibt es keine Änderung, da es diesem egal ist, wie <b>glVertexAttribPointer(...</b> die Daten übergibt.<br>
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
