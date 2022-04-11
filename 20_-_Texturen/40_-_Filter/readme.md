<html>
    <b><h1>20 - Texturen</h1></b>
    <b><h2>40 - Filter</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird gezeigt, wie man Filter für Texturen verwenden kann.<br>
In diesem Beispiel wird nur eine Texturen geladen, aber es werden mehrere Filter verwendet.<br>
<br>
Die Filter verstellt man mit <b>glTexParameter(...</b>.<br>
<hr><br>
Hier wird die Textur geladen und der Filter <b>MIN_FILTER</b> festgelegt, welcher für alle Ausgaben gültig ist.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  pic: TPicture;
<br>
<b><font color="0000BB">begin</font></b>
  pic := TPicture.Create;
  <b><font color="0000BB">with</font></b> pic <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    LoadFromFile(<font color="#FF0000">'bild.xpm'</font>);
<br>
    <i><font color="#FFFF00">// Textur laden</font></i>
    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, <font color="#0077BB">0</font>, GL_RGB8, Width, Height, <font color="#0077BB">0</font>, GL_BGR, GL_UNSIGNED_BYTE, Bitmap.RawImage.Data);
<br>
    <i><font color="#FFFF00">// Globaler Filter</font></i>
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
<br>
    glBindTexture(GL_TEXTURE_2D, <font color="#0077BB">0</font>);
    Free;
  <b><font color="0000BB">end</font></b>;</code></pre>
Bei dem Filter <b>GL_CLAMP_TO_BORDER</b> kann man noch eine Hintergrundfarbe festlegen.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<i><font color="#FFFF00">// Hintergrundfarbe für Clamp_to_Border, ein Dunkelgrün.</font></i>
<b><font color="0000BB">const</font></b>
  border: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">3</font>] <b><font color="0000BB">of</font></b> GLfloat = (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
<b><font color="0000BB">var</font></b>
  ProdMatrix: TMatrix;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
<br>
  glBindVertexArray(VBQuad.VAO);
  glBindTexture(GL_TEXTURE_2D, textureID);  <i><font color="#FFFF00">// Textur binden.</font></i>
<br>
  <i><font color="#FFFF00">// Links-Oben</font></i>
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
<br>
  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix.Uniform(Matrix_ID);
<br>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
<br>
  <i><font color="#FFFF00">// Rechts-Oben</font></i>
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_BORDER_COLOR, @border);
<br>
  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix.Uniform(Matrix_ID);
<br>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
<br>
  <i><font color="#FFFF00">// Links-Unten</font></i>
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
<br>
  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix.Uniform(Matrix_ID);
<br>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
<br>
  <i><font color="#FFFF00">// Rechts-Unten</font></i>
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
<br>
  ProdMatrix := ScaleMatrix;
  ProdMatrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix.Uniform(Matrix_ID);
<br>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
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
  UV0 = inUV;                           <i><font color="#FFFF00">// Texur-Koordinaten weiterleiten.</font></i>
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;
<br>
<b><font color="0000BB">void</font></b> main()
{
    FragColor = texture( Sampler, UV0 );
}
</code></pre>
<hr><br>
<b>bild.xpm</b><br>
<br>
<pre><code>/* XPM */
static char *XPM_mauer[] = {
  "<font color="#0077BB">8</font> <font color="#0077BB">8</font> <font color="#0077BB">6</font> <font color="#0077BB">1</font>",
  "  c #<font color="#0077BB">882222</font>",
  "* c #FFFFFF",
  "r c #FF0000",
  "g c #<font color="#0077BB">00</font>FF00",
  "b c #<font color="#0077BB">0000</font>FF",
  "y c #<font color="#0077BB">00</font>FFFF",
  "r******g",
  "*rr**gg*",
  "*rr**gg*",
  "********",
  "********",
  "*bb**yy*",
  "*bb**yy*",
  "b******y"
};
</code></pre>
<br>
</html>
