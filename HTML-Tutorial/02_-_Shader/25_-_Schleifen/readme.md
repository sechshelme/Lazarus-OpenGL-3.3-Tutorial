<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>25 - Schleifen</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
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
<pre><code><b><font color="0000BB">var</font></b>
  rot_ID: GLint;      <i><font color="#FFFF00">// ID für uniform "rot"</font></i></pre></code>
Der Location-Abfrage ist es gleich, was für ein Variablen-Typ die Uniform ist.<br>
Das Ermitteln geht bei allen Typen gleich.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;
  rot_ID := Shader.UniformLocation(<font color="#FF0000">'rot'</font>); <i><font color="#FFFF00">// Ermittelt die ID von "rot".</font></i></pre></code>
Mit <b>glUniform1i(...</b> wird der Boolean übergeben.<br>
Ein Boolean, muss man als Integer übergeben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glUniform1i(rot_ID, GLint(<b><font color="0000BB">True</font></b>));   <i><font color="#FFFF00">// True = rot</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Triangle) * <font color="#0077BB">3</font>);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glUniform1i(rot_ID, GLint(<b><font color="0000BB">False</font></b>));  <i><font color="#FFFF00">// False = schwarz</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>);

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<br>
Mit der Uniform-Variable "rot" wird ermittelt, ob die Mesh Rot oder schwarz ist.<br>
Die Auswertung erfolgt über eine if-else-Schleife.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> rot;   <i><font color="#FFFF00">// Ist es "rot" ?</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  <i><font color="#FFFF00">// Die if-Abfrage</font></i>
  <b><font color="0000BB">if</font></b> (rot) {
    outColor = <b><font color="0000BB">vec4</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Rot</font></i>
  } <b><font color="0000BB">else</font></b> {
    outColor = <b><font color="0000BB">vec4</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Schwarz</font></i>
  }
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
