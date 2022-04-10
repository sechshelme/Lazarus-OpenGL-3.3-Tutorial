<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>40 - Indices</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Normalerweise, werden die Polygone der Reihenfolge der Vertex-Konstanten abgearbeitet.<br>
Man kann aber auch selbst bestimmen, welche Koordinate abgearbeitet werden.<br>
Dafür muss man eine Indices-Array kreieren, welche die Reihenfolge der Koordinaten bestimmt.<br>
<br>
Der Unterschied zum einfachen Zeichenn ist, das ich noch eine Indicen-Array brauche.<br>
Und das Zeichnen ist vor allem anders.<br>
Man verwendet anstelle von <b>glDrawArrays(...</b>, <b>glDrawElements(...</b>, welche als dritten Parameter noch einen Zeiger auf die Indicen-Array bekommt.<br>
<hr><br>
Die Deklaration der Vektor-Koordianten und Indicien Konstanten.<br>
Beim Dreieck sieht man keinen Vorteil bei der Indicien-Version, da das Dreieck sowieso nur aus einem Polygon besteht.<br>
Beim Quadrat, konnten so schon zwei Koordinaten eingespart werden, da man die Eckpunkte nur einmal angeben muss.<br>
Bei der einfachen Variante bräuchte es dafür sechs Eckpunte, weil dort zwei Punkte doppelt vorhandnen sein müssen.<br>
Bei einem Würfel ist der Vorteil noch grösser, da braucht es bei der einfachen Version 36 Punkte, bei der Indicien-Version, nur 8 Stück !<br>
<br>
Mit den Indicen kann ich sagen, zeichen von Punkt 0-1-2 und von Punkt 0-2-3.<br>
<br>
<pre><code>3 - 2
| / |
0 - 1</pre></code>
<pre><code>const
  // --- Dreieck
  // Vertex-Koordinaten
  Triangle: array[0..2] of TVertex3f =</font>
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));</font>
  // Indicien ( Reihenfolge )
  Triangle_Indices: array[0..2] of GLint = (0, 1, 2);

  // --- Quadrat
  // Vertex-Koordinaten
  Quad: array[0..3] of TVertex3f =</font>
    ((-0.2, -0.6, 0.0), (0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (-0.2, -0.1, 0.0));</font>
  // Indicien ( Reihenfolge )
  Quad_Indices: array[0..5] of GLint = (0, 1, 2, 0, 2, 3);</font></pre></code>
Bei <b>glDrawElements(...</b>, muss als dritten Parameter der Zeiger auf die Indicien-Array übergeben werden.<br>
Ansonsten geht das Zeichen gleich, wie bei der einfachen Methode.<br>
Der Polygonmodus wurde auf Linien umgestellt, so das man die Polygone besser sieht.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   // Linien
  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawElements(GL_TRIANGLES, Length(Triangle_Indices), GL_UNSIGNED_INT, @Triangle_Indices);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawElements(GL_TRIANGLES, Length(Quad_Indices), GL_UNSIGNED_INT, @Quad_Indices);</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>

void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  vec3 col = vec3(1.0, 1.0, 0.0); // Gelb</font>
  outColor = vec4(col, 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
