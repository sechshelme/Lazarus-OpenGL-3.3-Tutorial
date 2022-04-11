<html>
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
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  glEnable(GL_DEPTH_TEST);  <i><font color="#FFFF00">// Tiefenprüfung einschalten.</font></i>
  glDepthFunc(GL_LESS);     <i><font color="#FFFF00">// Kann man weglassen, da Default.</font></i></code></pre>
Bei <b>glClear(...</b> ist noch etwas neues dazugekommen, <b>GL_DEPTH_BUFFER_BIT</b>.<br>
Dies bewirkt, das bei <b>glClear(...</b> nicht nur der Frame-Puffer gelöscht wird, sondern auch der Tiefen-Puffer.<br>
Jetzt darf der kleine Würfel nicht mehr sichtbar sein, da sich dieser hinter dem grossen versteckt.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  TempMatrix: TMatrix;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);  <i><font color="#FFFF00">// Frame und Tiefen-Puffer löschen.</font></i>
<br>
  Shader.UseProgram;
<br>
  <i><font color="#FFFF00">// --- Zeichne Würfel</font></i>
<br>
  glBindVertexArray(VBCube.VAO);
<br>
  WorldMatrix.Uniform(WorldMatrix_ID);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(CubeVertex) * <font color="#0077BB">3</font>);
<br>
  TempMatrix := WorldMatrix;
<br>
  WorldMatrix.Scale(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>);
  WorldMatrix.Uniform(WorldMatrix_ID);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(CubeVertex) * <font color="#0077BB">3</font>); <i><font color="#FFFF00">// wird nicht gezeichnet.</font></i>
<br>
  WorldMatrix := TempMatrix;
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol; <i><font color="#FFFF00">// Farbe</font></i>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                       <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben</font></i>
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                  <i><font color="#FFFF00">// Matrix für die Drehbewegung</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec4</font></b> Color;     <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</code></pre>
<br>
</html>
