<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>00 - Eine einfache Mesh</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>45 - Schatten</h1></b>
    <b><h2>00 - Eine einfache Mesh</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Wen man mehrere Objekte mit Alpha-Blending hat, ist es wichtig, das man zuerst die Objekte zeichnet, die am weitesten weg sind.<br>
Aus diesem Grund habe ich jeden Objekt eine eigene Matrix gegeben. Somit kann ich die Object anhand dieser Matrix sortieren, das sie später in richtiger Reihenfolge gezeichnet werden können.<br>
<hr><br>
Hier wird der Speicher für die Würfel angefordert.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">const</font></b>
  w = <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b></pre></code>
Startpositionen der einzelnen Würfel definieren.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  CreateTree;
  CreateWand;
</pre></code>
Hier sieht man, das die Matrix der einzelnen Würfel berechnet werden, um sie anschliessend nach der Z-Tiefe zu sortieren.<br>
Nach dem Sortieren werden die Würfel in der richtigen Reihenfolge gezeichnet.<br>
Versuchsweise kann man die Sortierroutine ausklammern, dann sieht man sofort die fehlerhafte Darstellung.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  i: integer;
  Matrix: TMatrix;
<b><font color="0000BB">begin</font></b>

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  <i><font color="#FFFF00">// --- Zeichne Schatten</font></i>
  glBindFramebuffer(GL_FRAMEBUFFER, Shadow.FramebufferName);
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">with</font></b> Shadow <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);
    glViewport(<font color="#0077BB">0</font>, <font color="#0077BB">0</font>, TexturSize, TexturSize);
  <b><font color="0000BB">end</font></b>;

  <b><font color="0000BB">with</font></b> Tree <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);

<i><font color="#FFFF00">//    Matrix.Identity;</font></i>
<i><font color="#FFFF00">//    Matrix.Multiply(ObjectMatrix, Matrix);</font></i>
<i><font color="#FFFF00">//    Matrix.Multiply(WorldMatrix, Matrix);</font></i>
    Matrix := FrustumMatrix * WorldMatrix * ObjectMatrix;
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(vec));
  <b><font color="0000BB">end</font></b>;

  glBindFramebuffer(GL_FRAMEBUFFER, <font color="#0077BB">0</font>);
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);
  glViewport(<font color="#0077BB">0</font>, <font color="#0077BB">0</font>, ClientWidth, ClientHeight);

  <i><font color="#FFFF00">// --- Zeichne Baum</font></i>
  <b><font color="0000BB">with</font></b> Tree <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);

    Matrix :=ObjectMatrix;
    Matrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Matrix := FrustumMatrix * WorldMatrix * Matrix;
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(vec));
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// --- Zeichne Wall</font></i>
  <b><font color="0000BB">with</font></b> Wall <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);
    <i><font color="#FFFF00">//    Textur.ActiveAndBind;</font></i>
    Shadow.Textur.ActiveAndBind;

    Matrix.Identity;

    Matrix.Translate(-<font color="#0077BB">1</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">3</font>);
    Matrix.RotateB(-pi / <font color="#0077BB">2</font>);
    Matrix := FrustumMatrix * WorldMatrix * Matrix;
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(vec));
  <b><font color="0000BB">end</font></b>;

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
Den Speicher von den CubePos wieder frei geben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b></pre></code>
Gedreht wird nur der Baum.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  <i><font color="#FFFF00">//    WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse</font></i>
  Tree.ObjectMatrix.RotateC(<font color="#0077BB">0</font>.<font color="#0077BB">0234</font>);  <i><font color="#FFFF00">// Drehe um Y-Achse</font></i>

  ogc.Invalidate;
<b><font color="0000BB">end</font></b>;
</pre></code>
<hr><br>
<b>Shader für Baum:</b><br>
<pre><code>$vertex
<b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol; <i><font color="#FFFF00">// Farbe</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                       <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                  <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}


$fragment
<b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec4</font></b> Color;     <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor   = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>
<hr><br>
<b>Shader für Wand</b><br>
<pre><code>$vertex
<b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;   <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = inUV;                           <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
}


$fragment
<b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;              <i><font color="#FFFF00">// Der Sampler welchem 0 zugeordnet wird.</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler, UV0 );  <i><font color="#FFFF00">// Die Farbe aus der Textur anhand der Koordinten auslesen.</font></i>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
