<html>
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
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glUniform3f(Color_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, <font color="#0077BB">3</font>);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Farbe ändern</font></i>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, <font color="#0077BB">3</font>);      <i><font color="#FFFF00">// zweites Polygon</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Farbe ändern</font></i>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">3</font>, <font color="#0077BB">3</font>);      <i><font color="#FFFF00">// zweites Polygon</font></i>

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> Color;  <i><font color="#FFFF00">// Farbe von Uniform</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Das 1.0 ist der Alpha-Kanal, hat hier keine Bedeutung.</font></i>
}
</code></pre>

</html>
