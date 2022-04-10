<html>
<img src="image.png" alt="Selfhtml"><br><br>
Da mit Texturen welche Alpha-Blending haben das gleiche Problem besteht, wie mit den Würfeln, muss man auch dort sortieren.<br>
Da die Position der Bäume keine Drehbewegung haben, reicht ein Vector für dessen Position, eine Matrix ist nicht nötig.<br>
Für den Boden wird eine Matrix gebraucht, da ich diesen drehe.<br>
<br>
Zusätzlich habe ich für den Boden noch eine Textur genommen, somit sieht die Scene recht realistisch aus.<br>
<br>
Wie Texturen funktionieren, in einem späteren Kapitel.<br>
<hr><br>
Den Speicher für die Position der Bäume reservieren.<br>
<pre><code>
<b><font color="0000BB">procedure</font></b> TForm1.FormCreate(Sender: TObject);
<b><font color="0000BB">var</font></b>
  i: Integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> TreeCount - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">New</font></b>(TreePosArray[i]);
  <b><font color="0000BB">end</font></b>;</code></pre>
Die Position der Bäume  wird zufällig bestimmt.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">const</font></b>
  d = <font color="#0077BB">10</font>;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> TreeCount - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    TreePosArray[i]^.x := -d / <font color="#0077BB">2</font> + Random * d;
    TreePosArray[i]^.y := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
    TreePosArray[i]^.z := -d / <font color="#0077BB">2</font> + Random * d;
  <b><font color="0000BB">end</font></b>;</code></pre>
Der Boden und die Bäume zeichen.<br>
Dabei ist es wichtig, das man zuerst den Boden zeichnet, weil die Bäume Alpha-Blending haben.<br>
Objecte mit Alpha-Blending sollte man immer zum Schluss zeichnen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);

  <b><font color="0000BB">procedure</font></b> QuickSort(<b><font color="0000BB">var</font></b> ia: <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> PTreePos; ALo, AHi: integer);
  <b><font color="0000BB">var</font></b>
    Lo, Hi: integer;
    dummy : PTreePos;
    Pivot: TTreePos;
  <b><font color="0000BB">begin</font></b>
    Lo := ALo;
    Hi := AHi;
    Pivot := ia[(Lo + Hi) <b><font color="0000BB">div</font></b> <font color="#0077BB">2</font>]^;
    <b><font color="0000BB">repeat</font></b>
      <b><font color="0000BB">while</font></b> ia[Lo]^.z &lt; Pivot.z <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
        Inc(Lo);
      <b><font color="0000BB">end</font></b>;
      <b><font color="0000BB">while</font></b> ia[Hi]^.z &gt; Pivot.z <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
        Dec(Hi);
      <b><font color="0000BB">end</font></b>;
      <b><font color="0000BB">if</font></b> Lo <= Hi <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
        dummy := ia[Lo];
        ia[Lo] := ia[Hi];
        ia[Hi] := dummy;
        Inc(Lo);
        Dec(Hi);
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">until</font></b> Lo &gt; Hi;
    <b><font color="0000BB">if</font></b> Hi &gt; ALo <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      QuickSort(ia, ALo, Hi);
    <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">if</font></b> Lo &lt; AHi <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      QuickSort(ia, Lo, AHi);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;

<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);        <i><font color="#FFFF00">// Frame und Tiefen-Puffer löschen.</font></i>

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  <i><font color="#FFFF00">// --- Zeichne Boden</font></i>
  SandTextur.ActiveAndBind;                                   <i><font color="#FFFF00">// Boden-Textur binden</font></i>
  Matrix.Identity;
  Matrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  Matrix.Scale(<font color="#0077BB">10</font>.<font color="#0077BB">0</font>);
  Matrix.RotateA(Pi / <font color="#0077BB">2</font>);

  Matrix := FrustumMatrix * WorldMatrix * GroundPos * Matrix; <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>

  Matrix.Uniform(Matrix_ID);                                  <i><font color="#FFFF00">// Matrix dem Shader übergeben.</font></i>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));      <i><font color="#FFFF00">// Zeichnet einen kleinen Würfel.</font></i>

  <i><font color="#FFFF00">// --- Zeichne Bäume</font></i>
  QuickSort(TreePosArray, <font color="#0077BB">0</font>, TreeCount - <font color="#0077BB">1</font>);                  <i><font color="#FFFF00">// Die Bäume sortieren.</font></i>

  BaumTextur.ActiveAndBind;                                   <i><font color="#FFFF00">// Baum-Textur binden</font></i>

  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> TreeCount - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Matrix.Identity;
    Matrix.Translate(TreePosArray[i]^);                       <i><font color="#FFFF00">// Die Bäume an die richtige Position bringen</font></i>

    Matrix := FrustumMatrix * WorldMatrix * Matrix;           <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
  <b><font color="0000BB">end</font></b>;

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
Da sieht man, das es reicht nur den Vector zu drehen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  rot = <font color="#0077BB">0</font>.<font color="#0077BB">0134</font>;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> TreeCount - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    TreePosArray[i]^.RotateB(rot);
  <b><font color="0000BB">end</font></b>;
  GroundPos.RotateB(rot);

  ogc.Invalidate;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;  <i><font color="#FFFF00">// Textur-Koordinaten</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                  <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0         = inUV;                 <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;              <i><font color="#FFFF00">// Der Sampler welchem 0 zugeordnet wird.</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler, UV0 );  <i><font color="#FFFF00">// Die Farbe aus der Textur anhand der Koordinten auslesen.</font></i>
}
</code></pre>

</html>
