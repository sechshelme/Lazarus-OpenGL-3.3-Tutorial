<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>00 - Erste Textur</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>00 - Erste Textur</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit Texturen sieht eine Mesh um einiges besser aus, als wen es nur einfache Farbverläufe sind.<br>
Mit OpenGL kann man recht einfach Texturen in das VRAM laden.<br>
<br>
Am einfachsten geht dies, wen man eine Textur als Statische Konstante hat, so wie im Beispiel hier.<br>
<br>
In der Praxis wird man meistens Texturen von einer Bitmap-Datei laden.<br>
Da es sehr viele Bitmap-Formate gibt, habe ich dafür eine Unit oglTextur.pas geschrieben.<br>
Diese sollte die meisten üblichen Formate abdecken. Dazu später.<br>
<hr><br>
Das OpenGL weiss, welcher Bereich von einer Textur auf das Polygon gezeichnet wird, kommt noch eine 2D Vertex-Array dazu.<br>
Hier im Beispiel, ist dies von einem Bereich von 0.0 bis 1.0, somit ist die ganze Textur sichtbar.<br>
Als Versuch kann man die 1.0 durch 2.0 ersetzen, dann wird man sehen, das die Textur doppelt vorhanden ist.<br>
Umgekehrt, mit 0.5 ist nur die halbe Textur sichtbar.<br>
Natürlich kann man dies auch mit einer Matrix modfizieren, dazu später.<br>
<pre><code><b><font color="0000BB">const</font></b>
  QuadVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector3f =       <i><font color="#FFFF00">// Koordinaten der Polygone.</font></i>
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>),
    (-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));

  TextureVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector2f =    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>),
    (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>));</pre></code>
Die Textur selbst als Konstante. Es ist eine sehr kleine Textur mit 2x2 Pixel.<br>
Das Format ist RGBA ( Rot/Grün/Blau/Alpha ).<br>
Der Alpha-Kanal ist hier Bedeutungslos, er wird nur gebraucht, das ein Pixel auf 32Bit kommt.<br>
<br>
Bei der Seitenlänge einer Textur sollt darauf geachtet werden, das diese <b>2<sup>x</sup></b> ist.<br>
Andere Werte gehen zwar auch bei modernen OpenGL, aber dann muss mit Performanceeinbrüchen rechnen.<br>
<pre><code><b><font color="0000BB">const</font></b>
  Textur32_0: <b><font color="0000BB">packed</font></b> <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>, <font color="#0077BB">0</font>..<font color="#0077BB">1</font>, <font color="#0077BB">0</font>..<font color="#0077BB">3</font>] <b><font color="0000BB">of</font></b> byte = (((<font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF), (<font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF)), ((<font color="#0077BB">$00</font>, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF), (<font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF)));</pre></code>
Für die Textur-Koordinaten ist noch ein VBO dazu gekommen.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TVB = <b><font color="0000BB">record</font></b>
    VAO,
    VBOVertex,        <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
    VBOTex: GLuint;   <i><font color="#FFFF00">// Textur-Koordianten</font></i>
  <b><font color="0000BB">end</font></b>;

<b><font color="0000BB">var</font></b>
  VBQuad: TVB;</pre></code>
Wie in OpenGL üblich, braucht auch der Textur-Puffer eine ID.<br>
Solche BPffer können auch mehrere vorkommen, eine Scene hat selten nur eine Textur.<br>
<pre><code><b><font color="0000BB">var</font></b>
  textureID: GLuint;</pre></code>
Hier wird der Textur-Puffer mit <b>glGenTextures(...</b> erzeugt, ähnlich wie andere Puffer auch.<br>
Für den Shader muss noch eine Sampler-Nr. zugeordnet werden, diese numeriert man fortlaufend durch.<br>
Da man dies nur einmal machen muss, kann man den Umweg über eine Uniform_ID sparen und dies direkt verschachtelt zuweisen.<br>
Ich hatte schon versucht, diese Nummer als Konstante in den Shader zu schreiben, dies geht aber leider <b>nicht</b> !<br>
<br>
Da hier nur eine Textur verwendet wird, könnte man dies auch weglassen, weil dies default auf <b>0</b> ist.<br>
Bei Multitexturing ist dies natürlich nicht mehr der Fall.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  glGenVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOVertex);
  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOTex);

  glGenTextures(<font color="#0077BB">1</font>, @textureID);                 <i><font color="#FFFF00">// Erzeugen des Textur-Puffer.</font></i>

  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  <b><font color="0000BB">with</font></b> Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    UseProgram;
    Matrix_ID := UniformLocation(<font color="#FF0000">'mat'</font>);
    glUniform1i(UniformLocation(<font color="#FF0000">'Sampler'</font>), <font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Dem Sampler 0 zuweisen.</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
Um Texturen zu laden, muss man die Textur zuerst binden, und anschliessend mit Daten füllen.<br>
Das wichtigste dabei ist <b>glTexImage2D(...</b>. Hier gibt man eine Zeiger auf die Textur-Daten mit.<br>
Die Textur-Daten im RAM könnte man anschliessend löschen, aber hier geht dies natürlich nicht, da es sich um eine Konstae handelt.<br>
Dies wird erst interessant, wen man die Daten von der Festplatte lädt.<br>
Da es sich um eine 2D-Texur handelt muss man über alll noch <b>GL_TEXTURE_2D</b> angeben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  <i><font color="#FFFF00">// Textur binden.</font></i>
  glBindTexture(GL_TEXTURE_2D, textureID);

  <i><font color="#FFFF00">// Textur laden.</font></i>
  glTexImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, GL_RGBA, <font color="#0077BB">2</font>, <font color="#0077BB">2</font>, <font color="#0077BB">0</font>, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32_0);

  <i><font color="#FFFF00">// Ein minimalst Filter aktivieren, ansonsten bleibt die Ausgabe schwarz.</font></i>
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
<i><font color="#FFFF00">//  glGenerateMipmap(GL_TEXTURE_2D);</font></i>

  <i><font color="#FFFF00">// Am Schluss kann man die Tetxur entbinden, dies ist aber nicht zwingend.</font></i>
  glBindTexture(GL_TEXTURE_2D, <font color="#0077BB">0</font>);</pre></code>
Bevor man ein Polygon zeichnet, muss man die Texur binden. Dies geschieht mit <b>glBindTexture(...</b>.<br>
Anschliessend kann ganz normal gezeichnet werden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);

  glBindTexture(GL_TEXTURE_2D, textureID);  <i><font color="#FFFF00">// Textur binden.</font></i></pre></code>
Zum Schluss muss man wie gewohnt, auch den Textur-Puffer wieder frei geben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  Timer1.Enabled := <b><font color="0000BB">False</font></b>;

  glDeleteTextures(<font color="#0077BB">1</font>, @textureID);       <i><font color="#FFFF00">// Textur-Puffer frei geben.</font></i>
  glDeleteVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOVertex);
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBQuad.VBOTex);</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Hier sieht man, das die Textur-Koordinaten gleich behandelt werden wie Vertex-Attribute.<br>
Dies muss man dann aber dem Fragment-Shader weiterleiten. So wurde es auch schon mit den Color-Vectoren gemacht.<br>
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
<br>
Hier ist der Sampler für die Zuordnung dazu gekommen.<br>
Und man sieht auch, das die Farb-Ausgabe von der Textur kommen.<br>
Die UV-Koordinate gibt an, von welchem Bereich der Pixel aus der Textur gelesen wird.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

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