<!DOCTYPE html>
<html>
    <b><h1>20 - Texturen</h1></b>
    <b><h2>10 - Texturn austauschen, Auschnitt laden</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Es ist möglich sehr schnell die Daten des Texturpuffers auszutauschen.<br>
Dies ist auch mit einem <b>Texturauschnitt</b> möglich.<br>
Dies geschieht mit <b>glTexSubImage2D(...</b>.<br>
<hr><br>
Big ist die Totalgrösse der Texturdaten.<br>
Small ist ein Auschnitt.<br>
<pre><code><b><font color="0000BB">const</font></b>
  TextursizeBig = <font color="#0077BB">256</font>;
  TextursizeSmall = <font color="#0077BB">64</font>;</pre></code>
3 Datenpuffer, welche sehr mit sehr einfachen Werten geladen werden.<br>
<pre><code><b><font color="0000BB">var</font></b>
  TexturBig: <b><font color="0000BB">packed</font></b> <b><font color="0000BB">array</font></b> [<font color="#0077BB">0</font>..TextursizeBig*TextursizeBig-<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> UInt32 ;
  TexturSmall0, TexturSmall1: <b><font color="0000BB">packed</font></b> <b><font color="0000BB">array</font></b> [<font color="#0077BB">0</font>..TextursizeSmall*TextursizeSmall-<font color="#0077BB">1</font>]<b><font color="0000BB">of</font></b> UInt32;
  textureID: GLuint;</pre></code>
Es werden sehr einfache Datenbuffer mit Daten befüllt.<br>
In der Praxis werden die Puffer meistens mit Bitmaps gefüllt.<br>
Der grosse Texturbuffer füllt die ganze Textur auf.<br>
Die kleinen Datenbuffer werden später zur Laufzeit abwechslungsweise geladen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <i><font color="#FFFF00">// Einfache Datenbuffer erzeugen.</font></i>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> TextursizeBig * TextursizeBig - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    TexturBig[i] := i <b><font color="0000BB">or</font></b> <font color="#0077BB">$</font>FF000000;
  <b><font color="0000BB">end</font></b>;

  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> TextursizeSmall * TextursizeSmall - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    TexturSmall0[i] := i <b><font color="0000BB">or</font></b> <font color="#0077BB">$</font>FF000000;
    TexturSmall1[i] := (<b><font color="0000BB">not</font></b> i) <b><font color="0000BB">or</font></b> <font color="#0077BB">$</font>FF000000;
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// --- Texturbuffer erzeugen und anschliessend mit Daten der grossen Textur befüllen.</font></i>

  glGenTextures(<font color="#0077BB">1</font>, @textureID);
  glBindTexture(GL_TEXTURE_2D, textureID);

  <i><font color="#FFFF00">// Nur Speicher reservieren</font></i>
  glTexImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, GL_RGBA, TextursizeBig, TextursizeBig, <font color="#0077BB">0</font>, GL_RGBA, GL_UNSIGNED_BYTE, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Texturbuffer mit dem grossen Datenbuffer befüllen.</font></i>
  glTexSubImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, <font color="#0077BB">0</font>, <font color="#0077BB">0</font>, TextursizeBig, TextursizeBig, GL_RGBA, GL_UNSIGNED_BYTE, @TexturBig);</pre></code>
Ein Auschnitt der Textur wird zur Laufzeit abwechslungsweise ausgtauscht<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  step = <font color="#0077BB">0</font>.<font color="#0077BB">01</font>;
  z: integer = <font color="#0077BB">1</font>;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">if</font></b> z > <font color="#0077BB">10</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    glTexSubImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, <font color="#0077BB">64</font>, <font color="#0077BB">64</font>, TextursizeSmall, TextursizeSmall, GL_RGBA, GL_UNSIGNED_BYTE, @TexturSmall0);
  <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">begin</font></b>
    glTexSubImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, <font color="#0077BB">64</font>, <font color="#0077BB">64</font>, TextursizeSmall, TextursizeSmall, GL_RGBA, GL_UNSIGNED_BYTE, @TexturSmall1);
  <b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;  <i><font color="#FFFF00">// Textur-Koordinaten</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0         = inUV;
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

</html>
