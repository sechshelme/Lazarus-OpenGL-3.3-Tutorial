<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>65 - Textur Array</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>65 - Textur Array</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Wen man mehrere Texturen im gleichen Format hat, kann man diese in einem einzigen Puffer ablegen.<br>
Dafür gibt es <b>GL_TEXTURE_2D_ARRAY</b>.<br>
Inerhalb des Puffers, sind die Texturen in mehreren Ebenen/Layer gespeichert.<br>
Zur Laufzeit muss man nur mit teilen, welche Layer das verwendet werden soll. Dies geschieht über eine Uniform-Variable.<br>
<br>
Eine Textur-Array kann man auch für Multitexturing verwenden. Man muss im Fragment-Shader nur bei <b>texture(...</b> nur den Layer angeben.<br>
Eine andere Anwendung wäre, bei einem 2D-Spiel, Sprites in eine Textur-Array abzulegen.<br>
<hr><br>
Die Koordinaten sind gleich, wie bei einer einzelnen Textur.<br>
<pre><code><b><font color="0000BB">const</font></b>
  QuadVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector3f =       <i><font color="#FFFF00">// Koordinaten der Polygone.</font></i>
    ((-<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>),
    (-<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));

  TextureVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector2f =    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>),
    (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>));</pre></code>
Dieser Puffer wird gleich reserviert, wie bei der einzelnen Textur.<br>
Im Shader ist der Layer eine Unifom-Variable.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  glGenTextures(<font color="#0077BB">1</font>, @textureID);                 <i><font color="#FFFF00">// Erzeugen des Textur-Puffer.</font></i>

  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  <b><font color="0000BB">with</font></b> Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    UseProgram;
    Matrix_ID := UniformLocation(<font color="#FF0000">'mat'</font>);
    Layer_ID := UniformLocation(<font color="#FF0000">'Layer'</font>);        <i><font color="#FFFF00">// Die ID für den Layer Zugriff.</font></i>
    glUniform1i(UniformLocation(<font color="#FF0000">'Sampler'</font>), <font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Dem Sampler 0 zuweisen.</font></i>
  <b><font color="0000BB">end</font></b>;

  glGenVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOVertex);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOTex);</pre></code>
Die Ziffern befinde sich alle in einer Bitmap, welche alle Ziffern übereinander beinhaltet.<br>
Man sieht hier gut, das man anstelle von <b>GL_TEXTURE_2D</b>, <b>GL_TEXTURE_2D_ARRAY</b> verwenden muss.<br>
Die Textur-Daten werden mit <b>glTexImage3D(GL_TEXTURE_2D_ARRAY,...</b> übegeben. Neben der Breite und Höhe, muss man noch die Anzahl Layer mitgeben.<br>
Die Höhe muss man noch durch die Anzahl Layer teilen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">const</font></b>
  anzLayer = <font color="#0077BB">6</font>;
<b><font color="0000BB">var</font></b>
  bit: TPicture;                  <i><font color="#FFFF00">// Bitmap</font></i>
<b><font color="0000BB">begin</font></b>
  bit := TPicture.Create;
  <b><font color="0000BB">with</font></b> bit <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    LoadFromFile(<font color="#FF0000">'ziffer.xpm'</font>);   <i><font color="#FFFF00">// Das Images laden.</font></i>

    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    glTexImage3D(GL_TEXTURE_2D_ARRAY, <font color="#0077BB">0</font>, GL_RGB, Width, Height <b><font color="0000BB">div</font></b> anzLayer, anzLayer, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

    glBindTexture(GL_TEXTURE_2D_ARRAY, <font color="#0077BB">0</font>);
    Free;                        <i><font color="#FFFF00">// Bitmap frei geben.</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
Zeichnen der einzelnen Quadrate. Hier sieht man gut, das nur eine Textur gebunden wird.<br>
Für den Textur-Wechsel muss man nur den Layer übergeben.<br>
Die Matrizen drehen und positionieren nur die Quadrate.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  x, y: integer;
  Matrix: TMatrix;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;
  glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);  <i><font color="#FFFF00">// Textur binden.</font></i>
  glBindVertexArray(VBQuad.VAO);

  <b><font color="0000BB">for</font></b> x := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">2</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">for</font></b> y := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      Matrix.Identity;
      Matrix.RotateC(x + y * <font color="#0077BB">3</font> + <font color="#0077BB">1</font>);
      Matrix.Scale(<font color="#0077BB">0</font>.<font color="#0077BB">4</font>);
      Matrix.Translate(-<font color="#0077BB">1</font>.<font color="#0077BB">0</font> + x, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font> + y, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
      Matrix := ScaleMatrix * Matrix;
      Matrix.Uniform(Matrix_ID);

      glUniform1i(Layer_ID, x + y * <font color="#0077BB">3</font>);    <i><font color="#FFFF00">// Layer wechseln</font></i>

      glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Im Fragment-Shader muss ein 2D-Array-Sampler verwendet werden.<br>
Dieser hat ein 3. Parameter, welcher den Layer enthält.<br>
Ansonsten ist der Shader sehr einfach.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;   <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = inUV;                           <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2DArray</font></b> Sampler;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">int</font></b>            Layer;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler, <b><font color="0000BB">vec3</font></b>(UV0, Layer));
}
</pre></code>
<b>ziffer.xpm:</b><br>
<pre><code>/* XPM */
static char *ziffer_xpm[] = {

  /* width height num_colors chars_per_pixel */
  "     <font color="#0077BB">8</font>    <font color="#0077BB">48</font>       <font color="#0077BB">16</font>            <font color="#0077BB">1</font>",

  /* colors */
  "` c #<font color="#0077BB">000000</font>", ". c #<font color="#0077BB">800000</font>", "# c #<font color="#0077BB">008000</font>", "a c #<font color="#0077BB">808000</font>",
  "b c #<font color="#0077BB">000080</font>", "c c #<font color="#0077BB">800080</font>", "d c #<font color="#0077BB">008080</font>", "e c #<font color="#0077BB">808080</font>",
  "f c #c0c0c0", "g c #ff0000", "h c #<font color="#0077BB">00</font>ff00", "i c #ffff00",
  "j c #<font color="#0077BB">0000</font>ff", "k c #ff00ff", "l c #<font color="#0077BB">00</font>ffff", "m c #ffffff",

  /* pixels */
  "jjjjjjjj", "jjjjijjj", "jjjiijjj", "jjijijjj", "jjjjijjj", "jjjjijjj", "jjjjijjj", "jjjjjjjj",
  "iiiiiiii", "iiijjiii", "iijiijii", "iiiiijii", "iiiijiii", "iiijiiii", "iijjjjii", "iiiiiiii",
  "kkkkkkkk", "kkkllkkk", "kklkklkk", "kkkklkkk", "kkkkklkk", "kklkklkk", "kkkllkkk", "kkkkkkkk",
  "hhhhhhhh", "hhmhmhhh", "hhmhmhhh", "hhmhmhhh", "hhmmmmhh", "hhhhmhhh", "hhhhmhhh", "hhhhhhhh",
  "aaaaaaaa", "aaiiiiaa", "aaiaaaaa", "aaiiiaaa", "aaaaaiaa", "aaaaaiaa", "aaiiiaaa", "aaaaaaaa",
  "gggggggg", "gggjjjgg", "ggjggggg", "ggjjjggg", "ggjggjgg", "ggjggjgg", "gggjjggg", "gggggggg"
};
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>