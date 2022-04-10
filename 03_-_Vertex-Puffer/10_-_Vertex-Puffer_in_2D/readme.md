<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>10 - Vertex-Puffer in 2D</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Wen man nur eine 2D-Mesh hat, kann man die Vektor-Koordinaten auch als <b>2D</b> in das VRAM laden.<br>
Man kann sich dabei den <b>Z-Wert</b> sparen. Matrix-Operation mit eine 4x4 Matrix funktionieren wie wen es 3D wäre.<br>
Für die Farbe wird hier nur eine <b>1D-Array</b> verwendet, da die Mesh nur Rot-Töne enthält. <b>Grün</b> und <b>Blau</b> wird im Shader auf <b>0.0</b> gesetzt.<br>
<br>
Man könnte zusätzlich noch einen <b>VBO</b> für <b>Rot</b> und <b>Grün</b> erzeugen. Somit könnte man jede Farbe einzeln in eine Array schreiben.<br>
<hr><br>
Ein 2D-Vertex ist noch dazu gekommen.<br>
<pre><code>type
  TVertex2f = array[0..1] of GLfloat;</font></pre></code>
Die Vector-Konstanten sind nur noch 2D, der Z-Wert fehlt.<br>
Die Farbe ist nur noch ein einfacher <b>float</b>, da nur Rot ausgegeben wird.<br>
<pre><code>const
  TriangleVector: array[0..0] of TFace2D =                     // Nur noch eine 2D-Array (XY).
    (((-0.4, 0.1), (0.4, 0.1), (0.0, 0.7)));</font>
  TriangleColor: array[0..0] of TVertex3f = ((1.0, 0.5, 0.0)); // Nur eine Float-Array.</font>
  QuadVector: array[0..1] of TFace2D =</font>
    (((-0.2, -0.6), (-0.2, -0.1), (0.2, -0.1)),</font>
    ((-0.2, -0.6), (0.2, -0.1), (0.2, -0.6)));</font>
  QuadColor: array[0..1] of TVertex3f =</font>
    ((0.5, 0.0, 1.0), (0.5, 1.0, 0.0));</pre></code>
Bei <b>glVertexAttribPointer(...</b> wurde der zweite Parameter, von <b>3</b> auf <b>2</b> ersetzt.<br>
Bei einer Farb-Übergabe mit Alpha-Blending (RGBA), kann es auch eine <b>4</b> sein.<br>
Hier wird sogar nur eine <b>1</b> verwendet, da die Rot-Töne nur eine einfache Array ist.<br>
<pre><code>procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  // --- Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil); // Der zweite Wert ist eine 2 für 2D.

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // Der zweite Wert ist eine 1 für eine Farbe (Rot).
  glVertexAttribPointer(11, 1, GL_FLOAT, False, 0, nil);</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Der Z-Wert des Vektors wird konstant auf <b>0.0</b> gesetzt.<br>
Eine Z-Bewegung der ganzen Mesh ist mit einer Matrix trozdem noch möglich. ZB. für Sprite-Darstellung.<br>
Die <b>in</b>-Variable könnte man auch auf <b>vec3</b> belassen, wie bei einem normalen 3D-Shader. Es wird dann automatisch ein <b>0.0</b> für den Z-Wert gesetzt.<br>
<br>
Die Farbe kommt nur noch in einem <b>float</b> an, aus diesem Grund hat <b>Grün</b> und <b>Blau</b> eine feste Konstante <b>0.0</b>.<br>
<pre><code>#version 330</font>

layout (location = 10) in vec2 inPos;     // Vertex-Koordinaten, nur XY.</font>
layout (location = 11) in float inCol;    // Farbe, es kommt nur Rot.</font>

out vec4 Color;                           // Farbe, an Fragment-Shader übergeben.

void main(void)
{
  gl_Position = vec4(inPos, 0.0, 1.0);    // Z ist immer 0.0</font>
  Color = vec4(inCol, 0.0, 0.0, 1.0);     // Der Rot- und Grün - Teil, ist 0.0</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
