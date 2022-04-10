<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>20 - Mehrere Shader</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird gezeigt, wie man mit mehreren Shader arbeitet. In diesem Beispiel sind es zwei.<br>
Der Unterschied der beiden Shader ist, dass der eine das Mesh grün färbt, der andere rot.<br>
Normalerweise würde man dies mit nur einem Shader über eine Uniform-Variable realisieren, jedoch geht es hier darum zu zeigen, wie man mehrere Shader verwendet.<br>
<hr><br>
In diesem Codeausschnitt sind die ersten beiden Zeilen interessant.<br>
Hier werden die zwei Shader in die Grafikkarte geladen.<br>
<br>
Der Vertex-Shader ist in beiden Shader-Programs der Gleiche, daher wird zwei mal die gleiche glsl-Datei geladen.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Shader[0] := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader0.glsl')]);</font>
  Shader[1] := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader1.glsl')]);</font></pre></code>
Beim Zeichnen muss man jetzt tatsächlich mit <b>Shader[x].UseProgram(...</b> den Shader wählen, da mehr als ein Shader verwendet wird.<br>
Die Meshes sollten nun zwei verschiedene Farben haben.<br>
<pre><code>  // Zeichne Dreieck
  Shader[0].UseProgram;  //  Shader 0 wählen  ( Rot )</font>
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  Shader[1].UseProgram;  //  Shader 1 wählen  ( Grün )</font>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);</font>
</pre></code>
Am Ende noch mit <b>Shader[x].Free</b> die Shader in der Grafikkarte wieder freigeben.<br>
<pre><code>procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader[0].Free;</font>
  Shader[1].Free;</font></pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
Der Vertex-Shader ist bei beiden Shader gleich.<br>
<pre><code>#version 330</font>
layout (location = 10) in vec3 inPos;</font>

void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
}
</pre></code>
<b>Fragment-Shader 0:</b><br>
<pre><code>#version 330</font>

out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = vec4(1.0, 0.0, 0.0, 1.0);  // Rot</font>
}
</pre></code>
<b>Fragment-Shader 1:</b><br>
<pre><code>#version 330</font>

out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = vec4(0.0, 1.0, 0.0, 1.0);  // Grün</font>
}
</pre></code>
In der zweit letzten Zeile sieht man, dass man eine andere Farbe an den Ausgang übergibt.<br>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
