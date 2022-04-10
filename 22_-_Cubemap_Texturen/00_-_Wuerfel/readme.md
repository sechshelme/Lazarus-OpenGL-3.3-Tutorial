    <b><h1>22 - Cubemap Texturen</h1></b>
    <b><h2>00 - Wuerfel</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit <b>Textur Cube Map</b> hat man die Möglichkeit die Texturen auf einer Würfel-Fläche abzubilden.<br>
Ausser für den einfachen Würfel kann man dies auch für folgendes gebrauchen.<br>
* Hintergrund in einer 360° Optik.<br>
* Reflektionen auf einer Mesh.<br>
Man kann auch eine Kugel oder sonst eine komplizierte Mesh nehmen.<br>
<br>
Die Textur-Koordinaten sind 3D-Vektoren, welche auf die Position des Würfels zeigen,<br>
dabei ist nur die Richtung des Vektores wichtig, die Länge ist egal.<br>
<br>
Meistens sind Vertex und Texturkoordinaten gleich. Hier im Beispiel ein Würfel.<br>
<hr><br>
Die 6 Flächen des Würfels werden einzeln in VRAM geladen.<br>
Dies geschieht ähnlich, wie bei einer Textur-Array.<br>
<br>
Die sechs einelnen Bitmap heisen 1.xpm - 6.xpm .<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  bit: TPicture; <i><font color="#FFFF00">// Bitmap</font></i>
<b><font color="0000BB">begin</font></b>
  bit := TPicture.Create;
  <b><font color="0000BB">with</font></b> bit <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    LoadFromFile(<font color="#FF0000">'1.xpm'</font>);
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X, <font color="#0077BB">0</font>, GL_RGB, Width, Height, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile(<font color="#FF0000">'2.xpm'</font>);
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X, <font color="#0077BB">0</font>, GL_RGB, Width, Height, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile(<font color="#FF0000">'3.xpm'</font>);
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y, <font color="#0077BB">0</font>, GL_RGB, Width, Height, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile(<font color="#FF0000">'4.xpm'</font>);
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y, <font color="#0077BB">0</font>, GL_RGB, Width, Height, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile(<font color="#FF0000">'5.xpm'</font>);
    glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z, <font color="#0077BB">0</font>, GL_RGB, Width, Height, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    LoadFromFile(<font color="#FF0000">'6.xpm'</font>);
    glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z, <font color="#0077BB">0</font>, GL_RGB, Width, Height, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);

    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

    glBindTexture(GL_TEXTURE_2D_ARRAY, <font color="#0077BB">0</font>);
    Free; <i><font color="#FFFF00">// Picture frei geben.</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.<br>
<br>
<b>Vertex-Shader:</b><br>
Hier sieht man, das für die Textur und Vertex-Koordinaten die gleichen Werte genommen werden.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;   <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec3</font></b> UV0;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = inPos;                           <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
Einzig Unterschied zu einer normalen Textur, das die Textur-Koordinaten 3D sind.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">samplerCube</font></b> Sampler;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture(Sampler, UV0);
}
</pre></code>

