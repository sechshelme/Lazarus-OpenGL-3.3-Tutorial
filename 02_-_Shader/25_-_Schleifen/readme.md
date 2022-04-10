<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>25 - Schleifen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
In GLSL gibt es auch Schleifen, im Beispiel wird eine <b>if-else</b>-Schleife gezeigt, welche die Mesh Rot oder Schwarz darstellt.<br>
Es gibt auch <b>for</b> und <b>while-do</b>-Schleifen.<br>
<b>case</b>-Verzweigungen gibt es auch, eigentlich alle, welche es in C++ auch gibt.<br>
<hr><br>
Für die <b>if</b>-Abfrage im Beispiel wird ein Boolean verwendet, man kann aber auch Integer, Float, etc. verwenden.<br>
Der ID, ist es egal, um welchen Unifom-Variablentyp es sich handelt, aus diesem Grund ist sie immer ein GLint.<br>
<pre><code>var
  rot_ID: GLint;      // ID für uniform "rot"</pre></code>
Der Location-Abfrage ist es gleich, was für ein Variablen-Typ die Uniform ist.<br>
Das Ermitteln geht bei allen Typen gleich.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;
  rot_ID := Shader.UniformLocation('rot'); // Ermittelt die ID von "rot".</font></pre></code>
Mit <b>glUniform1i(...</b> wird der Boolean übergeben.<br>
Ein Boolean, muss man als Integer übergeben.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  glUniform1i(rot_ID, GLint(True));   // True = rot
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform1i(rot_ID, GLint(False));  // False = schwarz
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);</font>

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
<br>
Mit der Uniform-Variable "rot" wird ermittelt, ob die Mesh Rot oder schwarz ist.<br>
Die Auswertung erfolgt über eine if-else-Schleife.<br>
<pre><code>#version 330</font>

uniform bool rot;   // Ist es "rot" ?
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  // Die if-Abfrage
  if (rot) {
    outColor = vec4(1.0, 0.0, 0.0, 1.0); // Rot</font>
  } else {
    outColor = vec4(0.0, 0.0, 0.0, 1.0); // Schwarz</font>
  }
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
