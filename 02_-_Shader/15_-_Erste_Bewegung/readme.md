<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>15 - Erste Bewegung</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>15 - Erste Bewegung</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Ohne Bewegung ist OpenGL langweilig.<br>
Hier werden dem Shader ein X- und ein Y-Wert übergeben. Diese Werte werden mit einem Timer verändert.<br>
Damit die Änderung auch sichtbar wird, wird <b>DrawScene</b> danach manuell ausgelöst.<br>
<hr><br>
Hinzugekommen sind die Deklarationen der IDs für die X- und Y-Koordinaten.<br>
<b>TrianglePos</b> bestimmt die Bewegung und Richtung des Dreiecks.<br>
<pre><code><b><font color="0000BB">var</font></b>
  X_ID, Y_ID: GLint;      <i><font color="#FFFF00">// ID für X und Y.</font></i>
  Color_ID: GLint;

  TrianglePos: <b><font color="0000BB">record</font></b>
    x, y: GLfloat;        <i><font color="#FFFF00">// Position</font></i>
    xr, yr: boolean;      <i><font color="#FFFF00">// Richtung</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
Den Timer immer erst nach dem Initialisieren starten!<br>
Im Objektinspektor <b>muss</b> dessen Eigenschaft <b>Enable=(False)</b> sein!<br>
Ansonsten ist ein SIGSEV vorprogrammiert, da Shader aktviert werden, die es noch gar nicht gibt.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormCreate(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  ogc := TContext.Create(<b><font color="0000BB">Self</font></b>);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
  Timer1.Enabled := <b><font color="0000BB">True</font></b>;   <i><font color="#FFFF00">// Timer starten</font></i>
<b><font color="0000BB">end</font></b>;</pre></code>
Dieser Code wurde um zwei <b>UniformLocation</b>-Zeilen erweitert.<br>
Diese ermitteln die IDs, wo sich <b>x</b> und <b>y</b> im Shader befinden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation(<font color="#FF0000">'Color'</font>);
  X_ID := Shader.UniformLocation(<font color="#FF0000">'x'</font>); <i><font color="#FFFF00">// Ermittelt die ID von x.</font></i>
  Y_ID := Shader.UniformLocation(<font color="#FF0000">'y'</font>); <i><font color="#FFFF00">// Ermittelt die ID von y.</font></i></pre></code>
Hier werden die Uniform-Variablen x und y dem Shader übergeben.<br>
Beim Dreieck sind das die Positions-Koordinaten.<br>
Beim Quad ist es 0, 0 und somit bleibt das Quadrat stehen.<br>
Mit <b>glUniform1f(...</b> kann man einen Float-Wert dem Shader übergeben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Gelb</font></i>
  <b><font color="0000BB">with</font></b> TrianglePos <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>  <i><font color="#FFFF00">// Beim Dreieck, die xy-Werte.</font></i>
    glUniform1f(X_ID, x);
    glUniform1f(Y_ID, y);
  <b><font color="0000BB">end</font></b>;
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Triangle) * <font color="#0077BB">3</font>);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Rot</font></i>
  glUniform1f(X_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Beim Quadrat keine Verschiebung, daher 0.0, 0.0 .</font></i>
  glUniform1f(Y_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>);</pre></code>
Den Timer vor dem Freigeben anhalten.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  Timer1.Enabled := <b><font color="0000BB">False</font></b>;</pre></code>
Im Timer wird die Position berechnet, so dass sich das Dreieck bewegt.<br>
Anschliessend wird neu gezeichnet.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  stepx: GLfloat = <font color="#0077BB">0</font>.<font color="#0077BB">010</font>;
  stepy: GLfloat = <font color="#0077BB">0</font>.<font color="#0077BB">0133</font>;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">with</font></b> TrianglePos <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">if</font></b> xr <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      x := x - stepx;
      <b><font color="0000BB">if</font></b> x < -<font color="#0077BB">0</font>.<font color="#0077BB">5</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
        xr := <b><font color="0000BB">False</font></b>;
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">begin</font></b>
      x := x + stepx;
      <b><font color="0000BB">if</font></b> x > <font color="#0077BB">0</font>.<font color="#0077BB">5</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
        xr := <b><font color="0000BB">True</font></b>;
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">if</font></b> yr <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      y := y - stepy;
      <b><font color="0000BB">if</font></b> y < -<font color="#0077BB">1</font>.<font color="#0077BB">0</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
        yr := <b><font color="0000BB">False</font></b>;
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">begin</font></b>
      y := y + stepy;
      <b><font color="0000BB">if</font></b> y > <font color="#0077BB">0</font>.<font color="#0077BB">3</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
        yr := <b><font color="0000BB">True</font></b>;
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
  ogcDrawScene(Sender);  <i><font color="#FFFF00">// Neu zeichnen</font></i>
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Hier sind die Uniform-Variablen <b>x</b> und <b>y</b> hinzugekommen.<br>
Diese werden im Vertex-Shader deklariert. Bewegungen kommen immer in diesen Shader.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">float</font></b> x;                      <i><font color="#FFFF00">// Richtung von Uniform</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">float</font></b> y;
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  <b><font color="0000BB">vec3</font></b> pos;
  pos.x = inPos.x + x;
  pos.y = inPos.y + y;
  pos.z = inPos.z;
  gl_Position = <b><font color="0000BB">vec4</font></b>(pos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> Color;  <i><font color="#FFFF00">// Farbe von Uniform</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
