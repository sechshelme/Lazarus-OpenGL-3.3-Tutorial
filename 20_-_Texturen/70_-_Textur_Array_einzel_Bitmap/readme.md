<html>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann auch in jedem Layer einzeln die Texturen laden.<br>
Der einzige Unterschied zum kompletten laden ist, man ladet die Texturen einzeln mit SubImage hoch.<br>
Der Rest ist gleich, wie wen man alles miteinander hoch ladet.<br>
<hr><br>
Mit <b>glTexImage3D(...</b> wird nur der Speicher für die Texturen reserviert. Dabei muss man von Anfang an wissen, wie gross die Texturen sind.<br>
Mit <b>glTexSubImage3D(...</b> werden dann die Texturen Layer für Layer hochgeladen.<br>
Die sechs einzelnen Bitmap heisen 1.xpm - 6.xpm .<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">const</font></b>
  size = <font color="#0077BB">8</font>;      <i><font color="#FFFF00">// Grösse der Texturen</font></i>
  anzLayer = <font color="#0077BB">6</font>;
<b><font color="0000BB">var</font></b>
  i: integer;
  bit: TPicture; <i><font color="#FFFF00">// Bitmap</font></i>
<b><font color="0000BB">begin</font></b>
  bit := TPicture.Create;
  <b><font color="0000BB">with</font></b> bit <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>

    glBindTexture(GL_TEXTURE_2D_ARRAY, textureID);

    <i><font color="#FFFF00">// Speicher reservieren</font></i>
    glTexImage3D(GL_TEXTURE_2D_ARRAY, <font color="#0077BB">0</font>, GL_RGB, size, size, anzLayer, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, <b><font color="0000BB">nil</font></b>);
    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D_ARRAY, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> anzLayer - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>

      <i><font color="#FFFF00">// Bitmap von HD laden.</font></i>
      LoadFromFile(IntToStr(i + <font color="#0077BB">1</font>) + <font color="#FF0000">'.xpm'</font>);   <i><font color="#FFFF00">// Die Images laden.</font></i>

      <i><font color="#FFFF00">// Texturen hoch laden</font></i>
      glTexSubImage3D(GL_TEXTURE_2D_ARRAY, <font color="#0077BB">0</font>, <font color="#0077BB">0</font>, <font color="#0077BB">0</font>, i, Width, Height, <font color="#0077BB">1</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
    <b><font color="0000BB">end</font></b>;
    glBindTexture(GL_TEXTURE_2D_ARRAY, <font color="#0077BB">0</font>);
    Free; <i><font color="#FFFF00">// Picture frei geben.</font></i>
  <b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
Die Shader sind gleich, wie wen man alles auf einmal hoch ladet.<br>
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
</code></pre>
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
</code></pre>

</html>
