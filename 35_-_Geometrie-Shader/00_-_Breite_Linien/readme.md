<html>
    <b><h1>35 - Geometrie-Shader</h1></b>
    <b><h2>00 - Breite Linien</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Dieses Beispiel zeigt, wie sich Textur-Koordinaten auf die Textur auswirken.<br>
Bei der linken Textur, entsprechen die Textur-Koordinaten, denen der Vektoren, dies gibt ein Matrix ähnliches Muster, ausser das sie skaliert wird.<br>
Rechts ist jede Koordinate von 0.0-1.0, somit wird die Textur um die Scheibe gezogen. Jedes Rechteck enthält die ganze Textur.<br>
<hr><br>
Hier sieht man gut, das die Textur-Koordinaten verschieden Werte bekommen.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.CalcCircle;
<b><font color="0000BB">const</font></b>
  Sektoren = <font color="#0077BB">7</font>;
  maxSek = Sektoren * <font color="#0077BB">8</font>;
  r = <font color="#0077BB">1</font>.<font color="#0077BB">6</font> / maxSek;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  SetLength(Linies, maxSek);
  SetLength(Linies_Prev, maxSek);
  SetLength(Linies_Next, maxSek);
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> maxSek - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Linies[i, <font color="#0077BB">0</font>] := sin(Pi * <font color="#0077BB">2</font> / Sektoren * i) * r * i;
    Linies[i, <font color="#0077BB">1</font>] := cos(Pi * <font color="#0077BB">2</font> / Sektoren * i) * r * i;
  <b><font color="0000BB">end</font></b>;
<br>
  Linies_Prev[<font color="#0077BB">0</font>] := vec2(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">1</font> <b><font color="0000BB">to</font></b> maxSek - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Linies_Prev[i] := Linies[i - <font color="#0077BB">1</font>];
  <b><font color="0000BB">end</font></b>;
<br>
  Linies_Next[maxSek - <font color="#0077BB">1</font>] := vec2(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> maxSek - <font color="#0077BB">1</font> - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Linies_Next[i] := Linies[i + <font color="#0077BB">1</font>];
  <b><font color="0000BB">end</font></b>;
<br>
<b><font color="0000BB">end</font></b>;</code></pre>
Vertex-Koordianten bekommen beide Meshes die gleichen, aber die Textur-Koordinaten weichen ab.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  TextureBuffer.ActiveAndBind;
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
<br>
  <i><font color="#FFFF00">// Ring Links</font></i>
  glBindVertexArray(VBRingL.VAO);
<br>
  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<br>
  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Prev);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies_Prev), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">1</font>);
  glVertexAttribPointer(<font color="#0077BB">1</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<br>
  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Next);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies_Next), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">2</font>);
  glVertexAttribPointer(<font color="#0077BB">2</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</code></pre>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  TempMatrix: TMatrix;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
<br>
  TextureBuffer.ActiveAndBind;
<br>
  Shader.UseProgram;
<br>
  ProdMatrix := ScaleMatrix * RotMatrix;
<br>
  <i><font color="#FFFF00">// Zeichne linke Scheibe</font></i>
  TempMatrix := ProdMatrix;
  <i><font color="#FFFF00">//  ProdMatrix.Translate(-0.5, 0.0, 0.0);</font></i>
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix := TempMatrix;
<br>
  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_LINE_STRIP, <font color="#0077BB">0</font>, Length(Linies) <b><font color="0000BB">div</font></b> <font color="#0077BB">2</font>);
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPos;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPrev;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">2</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inNext;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> Prev;
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> Next;
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
<i><font color="#FFFF00">//  Prev = inPrev;</font></i>
<i><font color="#FFFF00">///  Next = inNext;</font></i>
<br>
  Prev = (mat * <b><font color="0000BB">vec4</font></b>(inPrev, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xy;
  Next = (mat * <b><font color="0000BB">vec4</font></b>(inNext, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xy;
<br>
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;              <i><font color="#FFFF00">// Der Sampler welchem 0 zugeordnet wird.</font></i>
<br>
<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> Color;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;
<br>
<b><font color="0000BB">void</font></b> main()
{
<i><font color="#FFFF00">//  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.</font></i>
  FragColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>muster.xpm:</b><br>
<pre><code>/* XPM */
static char *XPM_mauer[] = {
  "<font color="#0077BB">8</font> <font color="#0077BB">8</font> <font color="#0077BB">3</font> <font color="#0077BB">1</font>",
  "  c #<font color="#0077BB">882222</font>",
  "* c #<font color="#0077BB">442222</font>",
  "+ c #<font color="#0077BB">4422</font>BB",
  "        ",
  " ****** ",
  " *    * ",
  " * ++ * ",
  " * ++ * ",
  " *    * ",
  " ****** ",
  "        "
};
</code></pre>
<br>
</html>
