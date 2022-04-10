<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>05 - Framepuffer speichern</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>25 - Framepuffer</h1></b>
    <b><h2>05 - Framepuffer speichern</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Wen man in eine Textur rendert, hat man die Möglichkeit, den Inhalt der Textur in eine Datei zu speichern.<br>
<hr><br>
Die Textur, in dem die Scene gerendert wurde, kann man auch abspeichern.<br>
Hinweis: Das Bild kann evtl. fehlerhaft abgespeichert werden, da dies OS abhängig ist.<br>
Dieser Code wurde unter Linux 64Bit getestet.<br>
Die <b>TBitmap</b> muss 32Bit sein, 24Bit wird nicht unterstützt.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ButtonTexturSaveClick(Sender: TObject);
<b><font color="0000BB">var</font></b>
  Picture: TPicture;
<b><font color="0000BB">begin</font></b>
  Picture := TPicture.Create;
  <b><font color="0000BB">with</font></b> Picture.Bitmap <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    PixelFormat := pf32bit;  <i><font color="#FFFF00">// 32-Bit erzwingen</font></i>
    Width := TexturSize;
    Height := TexturSize;
    glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
    glReadPixels(<font color="#0077BB">0</font>, <font color="#0077BB">0</font>, TexturSize, TexturSize, GL_RGBA, GL_UNSIGNED_BYTE, RawImage.Data);
  <b><font color="0000BB">end</font></b>;
  Picture.SaveToFile(<font color="#FF0000">'textur.png'</font>);
  Picture.Free;
<b><font color="0000BB">end</font></b>;</pre></code>
Es ist auch möglich, die komplett gerenderte Scene zu speichern.<br>
Leider steht das Bild auf dem Kopf. Die Ursache ist, bei einer Bitmap ist der Nullpunkt links-oben, bei OpenGL links/unten.<br>
Dies kann man aber umgehen, wen man Zeile für Zeile einliest.<br>
<b>glBindFramebuffer(GL_FRAMEBUFFER, 0);</b> ist nur notwendig, wen man mehrere Framebuffer verwendet.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ButtonScreenSaveClick(Sender: TObject);
<b><font color="0000BB">var</font></b>
  Picture: TPicture;
  i: integer;
<b><font color="0000BB">begin</font></b>
  Picture := TPicture.Create;
  <b><font color="0000BB">with</font></b> Picture.Bitmap <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    PixelFormat := pf32bit;               <i><font color="#FFFF00">// 32-Bit erzwingen</font></i>
    Width := ogc.Width;
    Height := ogc.Height;
    glBindFramebuffer(GL_FRAMEBUFFER, <font color="#0077BB">0</font>); <i><font color="#FFFF00">// Screen</font></i>

    <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Height - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      glReadPixels(<font color="#0077BB">0</font>, Height - i - <font color="#0077BB">1</font>, Width, Height - i, GL_RGBA, GL_UNSIGNED_BYTE, ScanLine[i]);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
  Picture.SaveToFile(<font color="#FF0000">'screen.png'</font>);
  Picture.Free;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Die Shader sind sehr einfach, der Shader des Quadrates muss nur ein farbige Polygone ausgeben.<br>
Der Shader des Würfels, gibt Texturen aus.<br>
<br>
<b>Vertex-Shader Quadrat:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> vertexUV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = vertexUV0;
}

</pre></code>
<hr><br>
<b>Fragment-Shader Quadrat:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler0;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler0, UV0 );
}
</pre></code>
<hr><br>
<b>Vertex-Shader Würfel:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec3</font></b> Col;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Col = inCol;
}
</pre></code>
<hr><br>
<b>Fragment-Shader Würfel:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> Col;
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor; <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
