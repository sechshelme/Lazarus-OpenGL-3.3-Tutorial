<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>05 - 3D</h1></b>
    <b><h2>10 - Tiefenbuffer</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Einen Tiefenpuffer braucht man, das Polygone nicht einfach willkürlich übereinander gezeichnet werden.<br>
Mit dem Tiefenpuffer wird berechnet, das ein Polygon das sich hinter einem anderen befindet, nicht gezeichnet wird.<br>
Diese Berechnung läuft auf Pixelebene.<br>
<br>
Bei dem Würfelbeispiel, wird der kleine Würfel nicht mehr gezeichnet, da sich dieser hinter den Flächen des grossen Würfels befindet.<br>
<hr><br>
Hier wird den Tiefenpufferprüfung eingeschaltet, dies geschieht mit <b>glEnable(GL_DEPTH_TEST);</b>.<br>
Die Art der Prüfung kann man mit <b>glDepthFunc(...</b> einstellen, wobei Default auf <b>GL_LESS</b> ist.<br>
Mit <b>GL_LESS</b> wird geprüft, ob der Z-Wert geringer ist, und wen ja, darf der Pixel gezeichnet werden.<br>
<br>
<pre><code>procedure TForm1.CreateScene;
begin
  glEnable(GL_DEPTH_TEST);  // Tiefenprüfung einschalten.
  glDepthFunc(GL_LESS);     // Kann man weglassen, da Default.</pre></code>
Bei <b>glClear(...</b> ist noch etwas neues dazugekommen, <b>GL_DEPTH_BUFFER_BIT</b>.<br>
Dies bewirkt, das bei <b>glClear(...</b> nicht nur der Frame-Puffer gelöscht wird, sondern auch der Tiefen-Puffer.<br>
Jetzt darf der kleine Würfel nicht mehr sichtbar sein, da sich dieser hinter dem grossen versteckt.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
var
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Puffer löschen.

  Shader.UseProgram;

  // --- Zeichne Würfel

  glBindVertexArray(VBCube.VAO);

  WorldMatrix.Uniform(WorldMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3);

  TempMatrix := WorldMatrix;

  WorldMatrix.Scale(0.5);</font>
  WorldMatrix.Uniform(WorldMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // wird nicht gezeichnet.

  WorldMatrix := TempMatrix;

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 11) in vec3 inCol; // Farbe</font>

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

uniform mat4 Matrix;                  // Matrix für die Drehbewegung

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);</font>
  Color = vec4(inCol, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
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
