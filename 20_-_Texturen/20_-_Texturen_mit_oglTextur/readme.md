<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>20 - Texturen mit oglTextur</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird gezeigt, wie einfach es ist, mit der Unit <b>oglTextur</b> Texturen zu laden.<br>
Dafür muss die Unit <b>oglTextur</b> bei uses eingebunden werden.<br>
<br>
Mit der Klasse <b>TTexturBuffer</b> welche dort enthalten ist, geht dies sehr einfach.<br>
Der grösste Voteil ist, das die meisten gängigen Formate von <b>TBitmap</b> erkannt werden.<br>
<hr><br>
Den Textur-Puffer deklarieren.<br>
<pre><code>var
  Textur: TTexturBuffer;</pre></code>
Textur-Puffer erzeugen.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Textur := TTexturBuffer.Create;</pre></code>
Mit diesr Klasse geht das laden einer Bitmap sehr einfach.<br>
Man kann die Texturen auch von einem <b>TRawImages</b> laden.<br>
<pre><code>procedure TForm1.InitScene;
begin
  Textur.LoadTextures('mauer.bmp');</font></pre></code>
Das Binden geht auch sehr einfach.<br>
Man kann dieser Funktion noch eine Nummer mitgeben, aber diese wird nur bei Multitexturing gebraucht, dazu später.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Textur.ActiveAndBind; // Textur binden</pre></code>
Am Ende muss man die Klasse noch frei geben.<br>
<pre><code>procedure TForm1.FormDestroy(Sender: TObject);
begin
  Textur.Free;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten</font>

uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in vec2 UV0;

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
