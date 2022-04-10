<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>06 - Alpha Blending</h1></b>
    <b><h2>00 - Einfaches Alpha Blending</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit OpenGL kann man auch (halb)tranparente Elemente zeichen.<br>
Dafür gibt es Alphablending. Der Transparent-Faktor wird mit dem vierten Wert im Vector angegeben. Dies ist auch im Shader der Fall.<br>
Alphablending kann man auch auf Texturen anwenden, zB. um eine Baum zu zeichnen, oder auch nur eine Scheibe. Dazu mehr unter Texturen.<br>
<hr><br>
Neben einem Face mit 3 Werten, gibt es jetzt noch eines mit einem vierten, welcher dann den Aplhablending angibt.<br>
<pre><code>type
  TFace3f = array[0..2] of TVector3f;</font>
  TFace4f = array[0..2] of TVector4f;  // Mit Alpha</font></pre></code>
Beim Color sieht man auch den vierten Parameter. Wobei <b>0.0</b> voll Transparent ist. und <b>1.0</b> undurchsichtig.<br>
Wen man nur den RGB-Wert betrachtet, wäre das Dreieck voll rot und das Rechteck grün.<br>
<pre><code>const
  TriangleVector: array[0..0] of TFace3f =</font>
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));</font>
  TriangleColor: array[0..0] of TFace4f =</font>
    (((1.0, 0.0, 0.0, 1.0), (1.0, 0.0, 0.0, 0.5), (1.0, 0.0, 0.0, 0.0)));

  QuadVector: array[0..1] of TFace3f =</font>
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));</font>
  QuadColor: array[0..1] of TFace4f =</font>
    (((0.0, 1.0, 0.0, 0.5), (0.0, 1.0, 0.0, 1.0), (0.0, 1.0, 0.0, 0.0)),
    ((0.0, 1.0, 0.0, 0.5), (0.0, 1.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0)));</pre></code>
Hier kommen zwie wichtige Zeilen hinzu, mit der Ersten wird Alphablending aktiviert und mit der zweiten gibt man die Art des Blinding an.<br>
Bei <b>glVertexAttribPointer(...</b> bei der Farbe sieht man, das ein Vector 4 Werte anstelle 3 hat.<br>
<pre><code>procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  glEnable(GL_BLEND);                                  // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);   // Sortierung der Primitiven von hinten nach vorne.

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

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
  glVertexAttribPointer(11, 4, GL_FLOAT, False, 0, nil);</pre></code>
<hr><br>
Die Shader sind sehr einfach gehalten. Man könnte mit <b>Color.a</b> direkt einen Alphawert zuordnen.<br>
Da der Alpha-Kanal gebraucht wird, sieht man mehrfach <b>vec4</b> anstelle <b>vec3</b>.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 11) in vec4 inCol;    // Farbe inklusive Alpha</font>
uniform mat4 mat;                        // Matrix von Uniform

out vec4 Color;                          // Farbe, an Fragment-Shader übergeben


void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);  // Vektoren mit der Matrix multiplizieren.</font>
  Color = inCol;
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in  vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = Color;
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
