<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>05 - Mehrere Texturen</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>05 - Mehrere Texturen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird gezeigt, wie man mehrere Texturen laden kann, im Prinzip geht dies fast gleich wie bei einer Textur.<br>
In diesem Beispiel werden zwei Texturen geladen.<br>
<br>
Wichtig dabei ist, das man mit <b>glBindTexture(...</b> immer die richtige Textur bindet.<br>
<hr><br>
Da es zwei Texturn hat, ist noch eine zweite Textur-Konstnate dazu gekommen.<br>
<pre><code><b><font color="0000BB">const</font></b>
  Textur32_0: <b><font color="0000BB">packed</font></b> <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>, <font color="#0077BB">0</font>..<font color="#0077BB">1</font>, <font color="#0077BB">0</font>..<font color="#0077BB">3</font>] <b><font color="0000BB">of</font></b> byte = (((<font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF), (<font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF)), ((<font color="#0077BB">$00</font>, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF), (<font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF)));
  Textur32_1: <b><font color="0000BB">packed</font></b> <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>, <font color="#0077BB">0</font>..<font color="#0077BB">1</font>, <font color="#0077BB">0</font>..<font color="#0077BB">3</font>] <b><font color="0000BB">of</font></b> byte = (((<font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF), (<font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF)), ((<font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF), (<font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF)));</pre></code>
Da es zwei Texturen hat, bracuht es auch zwei IDs.<br>
<pre><code><b><font color="0000BB">var</font></b>
  textureID: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> GLuint;</pre></code>
Da die Zextur-IDs in einer Array sind, kann man die Textur-Puffer mit nur einem <b>glGenTextures(...</b> erzeugen.<br>
Dazu gebe ich als ersten Parameter die Länge der Array an.<br>
Natürlich könnte man die Puffer auch einzeln erzeugen.<br>
<br>
Das selbe könnte man auch bei den VAOs und VBOs machen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  glGenVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOVertex);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOTex);

  glGenTextures(Length(textureID), @textureID);  <i><font color="#FFFF00">// Erster Parameter die Länge der Arrray.</font></i></pre></code>
Mehrer Texturen laden geht genaus so einfache, wie wen man nur eine hat.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  <i><font color="#FFFF00">// Textur 0 laden.</font></i>
  glBindTexture(GL_TEXTURE_2D, textureID[<font color="#0077BB">0</font>]);
  glTexImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, GL_RGBA, <font color="#0077BB">2</font>, <font color="#0077BB">2</font>, <font color="#0077BB">0</font>, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_0);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  <i><font color="#FFFF00">// Textur 1 laden.</font></i>
  glBindTexture(GL_TEXTURE_2D, textureID[<font color="#0077BB">1</font>]);
  glTexImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, GL_RGBA, <font color="#0077BB">2</font>, <font color="#0077BB">2</font>, <font color="#0077BB">0</font>, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_1);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  glBindTexture(GL_TEXTURE_2D, <font color="#0077BB">0</font>);</pre></code>
Hier sieht man, das ich für die beiden Qudrate unterschiedliche Texturen binde.<br>
Koordinaten verwende ich für beide Qudrate die gleichen, einziger Unterschied, ich verschiebe die Matrix in unterschiedliche Richtungen.<br>
Aus diesem Grund wird die VAO auch nur einmal gebunden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  <i><font color="#FFFF00">// Linkes Quadrat.</font></i>
  glBindTexture(GL_TEXTURE_2D, textureID[<font color="#0077BB">0</font>]);  <i><font color="#FFFF00">// Textur 0 binden.</font></i>
  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));

  <i><font color="#FFFF00">// Rechtes Quadrat.</font></i>
  glBindTexture(GL_TEXTURE_2D, textureID[<font color="#0077BB">1</font>]);  <i><font color="#FFFF00">// Textur 1 binden.</font></i>
  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix.Uniform(Matrix_ID);

  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
Logischerweise muss man auch wieder beide Textur-Puffer frei geben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glDeleteTextures(Length(textureID), @textureID); <i><font color="#FFFF00">// Textur-Puffer frei geben.</font></i></pre></code>
<hr><br>
Die Shader sind genau gleich, wie bei einer Textur.<br>
<br>
<b>Vertex-Shader:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = inUV;                           <i><font color="#FFFF00">// Texur-Koordinaten weiterleiten.</font></i>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;              <i><font color="#FFFF00">// Der Sampler welchem 0 zugeordnet wird.</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler, UV0 );  <i><font color="#FFFF00">// Die Farbe aus der Textur anhand der Koordinaten auslesen.</font></i>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
