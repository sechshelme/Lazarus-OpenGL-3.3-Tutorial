    <b><h1>20 - Texturen</h1></b>
    <b><h2>35 - Multitexturing</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Multitexturing, tönt Anfangs sehr kompliziert, aber im Grunde ist es sehr einfach.<br>
Der Unterschied zu einer einzelnen Textur ist, das man mehrere Texturen über die Mesh zieht.<br>
Somit muss man auch mehrere Texturen beim Zeichenen mittels <b>glActiveTexture(...</b> aktivieren.<br>
<br>
Hier im Beispiel, ist es ein Stück Mauer, welches mit einer farbigen Lampe angeleuchtet wird.<br>
<hr><br>
Die Textur-Puffer deklarieren, sehr einfach geht dies mit einer Array.<br>
<pre><code><b><font color="0000BB">var</font></b>
  Textur: <b><font color="0000BB">array</font></b> [<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TTexturBuffer;</pre></code>
Textur-Puffer erzeugen und Shader vorbereiten.<br>
Die Textur-Sampler muss man durchnummerieren.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Textur[<font color="#0077BB">0</font>] := TTexturBuffer.Create;
  Textur[<font color="#0077BB">1</font>] := TTexturBuffer.Create;

  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  <b><font color="0000BB">with</font></b> Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    UseProgram;
    Matrix_ID := UniformLocation(<font color="#FF0000">'mat'</font>);
    glUniform1i(UniformLocation(<font color="#FF0000">'Sampler[0]'</font>), <font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Dem Sampler[0] 0 zuweisen.</font></i>
    glUniform1i(UniformLocation(<font color="#FF0000">'Sampler[1]'</font>), <font color="#0077BB">1</font>);  <i><font color="#FFFF00">// Dem Sampler[1] 1 zuweisen.</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
Mit diesr Klasse geht das laden einer Bitmap sehr einfach.<br>
Man kann die Texturen auch von einem <b>TRawImages</b> laden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  Textur[<font color="#0077BB">0</font>].LoadTextures(<font color="#FF0000">'mauer.xpm'</font>);
  Textur[<font color="#0077BB">1</font>].LoadTextures(<font color="#FF0000">'licht.xpm'</font>);</pre></code>
Da man bei Multitexturing mehrere Sampler braucht, muss man mitteilen, welche Textur zu welchen Sampler gehört.<br>
Dies macht man mit <b>glActiveTexture(...</b>, Dazu muss man als Parameter die <b>Sampler-Nr + GL_TEXTURE0</b> mitgeben.<br>
<br>
Das sieht man auch gut in der TTexturBuffer Class.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TTexturBuffer.ActiveAndBind(Nr: integer);
<b><font color="0000BB">begin</font></b>
  glActiveTexture(GL_TEXTURE0 + Nr);
  glBindTexture(GL_TEXTURE_2D, FID);  <i><font color="#FFFF00">// FID ist Textur-ID.</font></i>
<b><font color="0000BB">end</font></b>;</pre></code>
<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);

  Textur[<font color="#0077BB">0</font>].ActiveAndBind(<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Textur 0 mit Sampler 0 binden.</font></i>
  Textur[<font color="#0077BB">1</font>].ActiveAndBind(<font color="#0077BB">1</font>); <i><font color="#FFFF00">// Textur 1 mit Sampler 1 binden.</font></i></pre></code>
Die beiden Texturen am Ende wieder frei geben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  Textur[<font color="#0077BB">0</font>].Free;  <i><font color="#FFFF00">// Texturen frei geben.</font></i>
  Textur[<font color="#0077BB">1</font>].Free;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;     <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV0;    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV1;    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV1;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = inUV0;                           <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
  UV1 = inUV1;                           <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<br>
Bei diesem einfachen Beispiel werden einfach die Pixel der Textur addiert und anschliessend duch 2 geteilt.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;
<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV1;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler[<font color="#0077BB">2</font>];                      <i><font color="#FFFF00">// 2 Sampler deklarieren.</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = (texture( Sampler[<font color="#0077BB">0</font>], UV0 ) +        <i><font color="#FFFF00">// Die beiden Farben zusammenzählen und anschliessend durch 2 teilen.</font></i>
               texture( Sampler[<font color="#0077BB">1</font>], UV1 )) / <font color="#0077BB">2</font>.<font color="#0077BB">0</font>;
}
</pre></code>
<hr><br>
<b>mauer.xpm:</b><br>
<pre><code>/* XPM */
static char *XPM_mauer[] = {
  "<font color="#0077BB">8</font> <font color="#0077BB">8</font> <font color="#0077BB">2</font> <font color="#0077BB">1</font>",
  "  c #AA2222",
  "* c #<font color="#0077BB">222222</font>",
  "********",
  "*   *   ",
  "*   *   ",
  "*   *   ",
  "********",
  "  *   * ",
  "  *   * ",
  "  *   * "
};
</pre></code>
<hr><br>
<b>licht.xpm:</b><br>
<pre><code>/* XPM */
static char *XPM_licht[] = {
  "<font color="#0077BB">2</font> <font color="#0077BB">2</font> <font color="#0077BB">4</font> <font color="#0077BB">1</font>",
  "<font color="#0077BB">1</font> c #FF0000",
  "<font color="#0077BB">2</font> c #<font color="#0077BB">00</font>FF00",
  "<font color="#0077BB">3</font> c #<font color="#0077BB">0000</font>FF",
  "<font color="#0077BB">4</font> c #FF0000",
  "<font color="#0077BB">12</font>",
  "<font color="#0077BB">34</font>"
};
</pre></code>

