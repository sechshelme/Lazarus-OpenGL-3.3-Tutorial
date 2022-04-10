<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>30 - Texturen und Matrixen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die Textur-Koordinaten kann man im Shader auch mit einer Matrix multipizieren.<br>
Dies geschieht ähnlich, wie bei den Vertex-Koordinanten, der grösste Unterschied dabei ist, das es sich um 2D-Koordinaten handelt.<br>
<br>
Dabei ist zu beachten, das beim Drehen/Verschieben die Transformationen in umgekehrter Reihenfolge verläuft,<br>
im Gegensatz zu Vertex-Koordinaten.<br>
<hr><br>
Das die Textur in der Mitte des Rechteckes dreht, muss sie um 0.5 verschoben werden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(<font color="#0077BB">1</font>.<font color="#0077BB">1</font>);

  TexturRotMatrix.Identity;

  <i><font color="#FFFF00">// Textur verschieben</font></i>
  TexturTransMatrix.Identity;
  TexturTransMatrix.Translate(-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// Startwerte Texturtransformation</font></i>
  <b><font color="0000BB">with</font></b> TexturTransform <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    scale := <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
    direction := <b><font color="0000BB">True</font></b>;
  <b><font color="0000BB">end</font></b>;</pre></code>
Matrizen multiplizieren und den Shader übergeben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  Matrix: TMatrix2D;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Textur.ActiveAndBind;
  Shader.UseProgram;

  ScaleMatrix.Uniform(Matrix_ID);  <i><font color="#FFFF00">// Matrix für die Vektoren.</font></i>

  <i><font color="#FFFF00">// --- Texturmatrizen multiplizieren und übergeben.</font></i>
  Matrix := TexturRotMatrix * TexturTransMatrix;
  Matrix.Uniform(texMatrix_ID);

  <i><font color="#FFFF00">// --- Zeichne Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
Berechnen der Matrix-Bewegungen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  sstep = <font color="#0077BB">1</font>.<font color="#0077BB">03</font>;  <i><font color="#FFFF00">// Schritt für Skalierung</font></i>
  rstep = <font color="#0077BB">0</font>.<font color="#0077BB">01</font>;  <i><font color="#FFFF00">// Schritt für Rotation</font></i>
  winkel: single = <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;

<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">with</font></b> TexturTransform <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">if</font></b> direction <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      scale *= sstep;
      <b><font color="0000BB">if</font></b> scale > <font color="#0077BB">15</font>.<font color="#0077BB">0</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
        direction := <b><font color="0000BB">False</font></b>;
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">begin</font></b>
      scale /= sstep;
      <b><font color="0000BB">if</font></b> scale < <font color="#0077BB">1</font>.<font color="#0077BB">0</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
        direction := <b><font color="0000BB">True</font></b>;
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b>;

    winkel := winkel + rstep;
    <b><font color="0000BB">if</font></b> winkel > <font color="#0077BB">2</font> * pi <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      winkel := winkel - <font color="#0077BB">2</font> * pi;
    <b><font color="0000BB">end</font></b>;

    <i><font color="#FFFF00">// Matrix Skalieren und Rotieren.</font></i>
    TexturRotMatrix.Identity;
    TexturRotMatrix.Scale(scale);
    TexturRotMatrix.Rotate(winkel);
  <b><font color="0000BB">end</font></b>;
  ogcDrawScene(Sender);
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Hier sieht man, wie die Texturkoordinaten anhand der Matrix manipuliert werden.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;   <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat3</font></b> texMat;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// Texturkoordinaten transformieren</font></i>
  UV0 = (texMat * <b><font color="0000BB">vec3</font></b>(inUV, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xy;
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler, UV0 );
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
