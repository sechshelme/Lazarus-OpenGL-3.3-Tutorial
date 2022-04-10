<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>20 - Texturen mit oglTextur</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
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
<pre><code><b><font color="0000BB">var</font></b>
  Textur: TTexturBuffer;</pre></code>
Textur-Puffer erzeugen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Textur := TTexturBuffer.Create;</pre></code>
Mit diesr Klasse geht das laden einer Bitmap sehr einfach.<br>
Man kann die Texturen auch von einem <b>TRawImages</b> laden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  Textur.LoadTextures(<font color="#FF0000">'mauer.bmp'</font>);</pre></code>
Das Binden geht auch sehr einfach.<br>
Man kann dieser Funktion noch eine Nummer mitgeben, aber diese wird nur bei Multitexturing gebraucht, dazu später.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);

  Textur.ActiveAndBind; <i><font color="#FFFF00">// Textur binden</font></i></pre></code>
Am Ende muss man die Klasse noch frei geben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  Textur.Free;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
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
