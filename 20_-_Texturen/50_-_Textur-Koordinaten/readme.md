<html>
<img src="image.png" alt="Selfhtml"><br><br>
Dieses Beispiel zeigt, wie sich Textur-Koordinaten auf die Textur auswirken.<br>
Bei der linken Textur, entsprechen die Textur-Koordinaten, denen der Vektoren, dies gibt ein Matrix ähnliches Muster, ausser das sie skaliert wird.<br>
Rechts ist jede Koordinate von 0.0-1.0, somit wird die Textur um die Scheibe gezogen. Jedes Rechteck enthält die ganze Textur.<br>
<hr><br>
Hier sieht man gut, das die Textur-Koordinaten verschieden Werte bekommen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CalcCircle;
<b><font color="0000BB">const</font></b>
  TextureVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector2f =    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>),
    (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>));

  Sektoren = <font color="#0077BB">16</font>;
  r0 = <font color="#0077BB">0</font>.<font color="#0077BB">5</font>;
  r1 = <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
<b><font color="0000BB">var</font></b>
  i: integer;
  w0, w1: single;

<b><font color="0000BB">begin</font></b>
  SetLength(Disc, Sektoren * <font color="#0077BB">3</font> * <font color="#0077BB">2</font>);

  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Sektoren - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    w0 := pi * <font color="#0077BB">2</font> / Sektoren * (i + <font color="#0077BB">0</font>);
    w1 := pi * <font color="#0077BB">2</font> / Sektoren * (i + <font color="#0077BB">1</font>);

    <i><font color="#FFFF00">// 1. Dreieck</font></i>

    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">0</font>].Vertex := vec3(sin(w0) * r0, cos(w0) * r0, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">1</font>].Vertex := vec3(sin(w0) * r1, cos(w0) * r1, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">2</font>].Vertex := vec3(sin(w1) * r1, cos(w1) * r1, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);

    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">0</font>].TexkoorL := Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">0</font>].Vertex.xy;
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">0</font>].TexkoorL.scale(<font color="#0077BB">5</font>.<font color="#0077BB">0</font>);
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">1</font>].TexkoorL := Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">1</font>].Vertex.xy;
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">1</font>].TexkoorL.scale(<font color="#0077BB">5</font>.<font color="#0077BB">0</font>);
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">2</font>].TexkoorL := Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">2</font>].Vertex.xy;
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">2</font>].TexkoorL.scale(<font color="#0077BB">5</font>.<font color="#0077BB">0</font>);

    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">0</font>].TexkoorR := TextureVertex[<font color="#0077BB">3</font>];
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">1</font>].TexkoorR := TextureVertex[<font color="#0077BB">4</font>];
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">2</font>].TexkoorR := TextureVertex[<font color="#0077BB">5</font>];

    <i><font color="#FFFF00">// 2. Dreieck</font></i>

    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">3</font>].Vertex := vec3(sin(w0) * r0, cos(w0) * r0, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">4</font>].Vertex := vec3(sin(w1) * r1, cos(w1) * r1, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">5</font>].Vertex := vec3(sin(w1) * r0, cos(w1) * r0, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);

    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">3</font>].TexkoorL := Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">3</font>].Vertex.xy;
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">3</font>].TexkoorL.scale(<font color="#0077BB">5</font>.<font color="#0077BB">0</font>);
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">4</font>].TexkoorL := Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">4</font>].Vertex.xy;
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">4</font>].TexkoorL.scale(<font color="#0077BB">5</font>.<font color="#0077BB">0</font>);
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">5</font>].TexkoorL := Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">5</font>].Vertex.xy;
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">5</font>].TexkoorL.scale(<font color="#0077BB">5</font>.<font color="#0077BB">0</font>);

    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">3</font>].TexkoorR := TextureVertex[<font color="#0077BB">0</font>];
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">4</font>].TexkoorR := TextureVertex[<font color="#0077BB">1</font>];
    Disc[i * <font color="#0077BB">2</font> * <font color="#0077BB">3</font> + <font color="#0077BB">5</font>].TexkoorR := TextureVertex[<font color="#0077BB">2</font>];
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</code></pre>
Vertex-Koordianten bekommen beide Meshes die gleichen, aber die Textur-Koordinaten weichen ab.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  TextureBuffer.ActiveAndBind;
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// Ring Links</font></i>
  glBindVertexArray(VBRingL.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">28</font>, Pointer(<font color="#0077BB">0</font>));

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">28</font>, Pointer(<font color="#0077BB">12</font>));

  <i><font color="#FFFF00">// Ring Rechts</font></i>
  glBindVertexArray(VBRingR.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRingR.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">28</font>, Pointer(<font color="#0077BB">0</font>));

  glBindBuffer(GL_ARRAY_BUFFER, VBRingR.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">28</font>, Pointer(<font color="#0077BB">20</font>));
<b><font color="0000BB">end</font></b>;</code></pre>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  TempMatrix: TMatrix;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);

  TextureBuffer.ActiveAndBind;

  Shader.UseProgram;

  ProdMatrix := ScaleMatrix * RotMatrix;

  <i><font color="#FFFF00">// Zeichne linke Scheibe</font></i>
  TempMatrix := ProdMatrix;
  ProdMatrix.Translate(-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix := TempMatrix;

  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Disc) * <font color="#0077BB">3</font>); <i><font color="#FFFF00">// Zeichnet die linke Scheibe</font></i>

  <i><font color="#FFFF00">// Zeichne rechte Scheibe</font></i>
  ProdMatrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBRingR.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Disc) * <font color="#0077BB">3</font>); <i><font color="#FFFF00">// Zeichnet die rechte Scheibe</font></i>

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
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
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;              <i><font color="#FFFF00">// Der Sampler welchem 0 zugeordnet wird.</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler, UV0 );  <i><font color="#FFFF00">// Die Farbe aus der Textur anhand der Koordinten auslesen.</font></i>
  FragColor.a = <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
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

</html>
