<!DOCTYPE html>
<html>
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
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Shader[<font color="#0077BB">0</font>] := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader0.glsl'</font>)]);
  Shader[<font color="#0077BB">1</font>] := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader1.glsl'</font>)]);</pre></code>
Beim Zeichnen muss man jetzt tatsächlich mit <b>Shader[x].UseProgram(...</b> den Shader wählen, da mehr als ein Shader verwendet wird.<br>
Die Meshes sollten nun zwei verschiedene Farben haben.<br>
<pre><code>  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  Shader[<font color="#0077BB">0</font>].UseProgram;  <i><font color="#FFFF00">//  Shader 0 wählen  ( Rot )</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Triangle) * <font color="#0077BB">3</font>);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  Shader[<font color="#0077BB">1</font>].UseProgram;  <i><font color="#FFFF00">//  Shader 1 wählen  ( Grün )</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>);
</pre></code>
Am Ende noch mit <b>Shader[x].Free</b> die Shader in der Grafikkarte wieder freigeben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  Shader[<font color="#0077BB">0</font>].Free;
  Shader[<font color="#0077BB">1</font>].Free;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
Der Vertex-Shader ist bei beiden Shader gleich.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<b>Fragment-Shader 0:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor; <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Rot</font></i>
}
</pre></code>
<b>Fragment-Shader 1:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor; <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Grün</font></i>
}
</pre></code>
In der zweit letzten Zeile sieht man, dass man eine andere Farbe an den Ausgang übergibt.<br>

</html>
