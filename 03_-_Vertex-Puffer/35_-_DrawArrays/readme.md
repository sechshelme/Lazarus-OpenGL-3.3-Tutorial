<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>35 - DrawArrays</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit <b> glDrawArrays(...</b> muss man nicht die ganze Meshes auf einmal zeichnen, man kann auch nur ein Teil davon zeichnen.<br>
Hier im Beispiel, wir das Quadrat in zwei Teilen gezeichnet, so hat man die Möglichkeit zwischendurch zB. die Farbe zu ändern.<br>
<hr><br>
Hier wird das Qudarat in zwei Teilen gezeichnet und zwischendurch die Uniform-Variable Color geändert.<br>
Dafür gibt es in <b>glDrawArrays(...</b> zwei Parameter.<br>
Der Zweite gibt das Offset der Vertex-Array an, und der Dritte, wie viele Vertex-Daten.<br>
Das erste Polygon, fängt bei 0 und ist 3 Vertex lang.<br>
Das zweite Polygon fängt bei 3 an und ist auch 3 Vertex lang.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glUniform3f(Color_ID, 0.0, 0.0, 1.0);</font>
  glDrawArrays(GL_TRIANGLES, 0, 3);</font>

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Farbe ändern</font>
  glDrawArrays(GL_TRIANGLES, 0, 3);      // zweites Polygon</font>
  glUniform3f(Color_ID, 1.0, 0.0, 1.0);  // Farbe ändern</font>
  glDrawArrays(GL_TRIANGLES, 3, 3);      // zweites Polygon</font>

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
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

uniform vec3 Color;  // Farbe von Uniform
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Color, 1.0); // Das 1.0 ist der Alpha-Kanal, hat hier keine Bedeutung.</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
