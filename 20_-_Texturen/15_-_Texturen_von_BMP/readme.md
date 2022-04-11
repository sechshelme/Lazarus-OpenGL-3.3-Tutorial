<html>
    <b><h1>20 - Texturen</h1></b>
    <b><h2>15 - Texturen von BMP</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
In der Praxis liegen die Texturen meisten als Bitmap, auf der Festplatte.<br>
Hier wird gezeigt, wie man eine 24Bit BMP als Textur lädt.<br>
<hr><br>
Der Unterschied zur Konstante, das man die Bitmap noch laden muss, und anschliessend einen Zeiger darauf <b>glTexImage2D(...</b> mit gibt.<br>
Man kann auch eine Bitmap selbst über Canvas zeichnen.<br>
<br>
Das es sich hier um eine BMP-Datei handelt, kann man diese direkt mit <b>TBitmap</b> laden.<br>
<br>
Anstelle von TBitmap kann man auch TPicture verwenden. Was sehr wichtig ist, man muss wissen in welchen Format die Bitmap gespeichert ist.<br>
Je nach dem in welchen Format die Bitmap vorliegt, müssen die Parameter in <b>glTexImage2D(...</b> angepasst werden.<br>
In diesen Beispiel sind es die Konstanten <b>GL_RGB</b> und <b>GL_BGR</b>.<br>
<br>
Wen man eine Bitmap mit der Unit <b>oglTextur</b> lädt, werden diese Parameter automatisch angepasst.<br>
<br>
Unterumständen könnte es noch exotische Formate geben, welche (noch) nicht unterstützt werden.<br>
Bei einem Fehler bitte im DGL-Forum melden, evt. kann man es dann noch anpassen. ;-)<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  bit: TBitmap;                  <i><font color="#FFFF00">// Bei anderen Formaten TPicture.</font></i>
<b><font color="0000BB">begin</font></b>
  bit := TBitmap.Create;         <i><font color="#FFFF00">// Bitmap erzeugen.</font></i>
  <b><font color="0000BB">with</font></b> bit <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    LoadFromFile(<font color="#FF0000">'mauer.bmp'</font>);   <i><font color="#FFFF00">// BMP in Bitmap laden.</font></i>
<br>
    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, GL_RGB, Width, Height, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, RawImage.Data); <i><font color="#FFFF00">// Zeiger auf Bitmap übergeben.</font></i>
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glBindTexture(GL_TEXTURE_2D, <font color="#0077BB">0</font>);
<br>
    Free;                        <i><font color="#FFFF00">// Bitmap frei geben.</font></i>
  <b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;   <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = inUV;                           <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;              <i><font color="#FFFF00">// Der Sampler welchem 0 zugeordnet wird.</font></i>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;
<br>
<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler, UV0 );  <i><font color="#FFFF00">// Die Farbe aus der Textur anhand der Koordinten auslesen.</font></i>
}
</code></pre>
<br>
</html>
