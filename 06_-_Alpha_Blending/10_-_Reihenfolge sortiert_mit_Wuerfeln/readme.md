<html>
    <b><h1>06 - Alpha Blending</h1></b>
    <b><h2>10 - Reihenfolge sortiert mit Wuerfeln</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Wen man mehrere Objekte mit Alpha-Blending hat, ist es wichtig, das man zuerst die Objekte zeichnet, die am weitesten weg sind.<br>
Aus diesem Grund habe ich jeden Objekt eine eigene Matrix gegeben. Somit kann ich die Object anhand dieser Matrix sortieren, das sie später in richtiger Reihenfolge gezeichnet werden können.<br>
<hr><br>
Für CubePos, verwende ich Pointer, somit müssen beim Sortieren nur die Pointer vertauscht werden.<br>
Ansonsten musste der ganze Record umkopiert werden. Auf einem 32Bit OS müssen so nur 4Byte kopiert werden, ansonsten sind es mehr als 64 Byte.<br>
<pre><code=pascal><b><font color="0000BB">type</font></b>
  TCubePos = <b><font color="0000BB">record</font></b>
    pos: TVector3f;
    mat: TMatrix;
  <b><font color="0000BB">end</font></b>;
  PCubePos = ^TCubePos; <i><font color="#FFFF00">// Pointer für Cube</font></i>
<br>
<b><font color="0000BB">var</font></b>
  CubePosArray: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..CubeTotal - <font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> PCubePos; <i><font color="#FFFF00">// Alle Würfel</font></i></code></pre>
Hier wird der Speicher für die Würfel angefordert.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">const</font></b>
  w = <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> CubeTotal - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">New</font></b>(CubePosArray[i]);  <i><font color="#FFFF00">// Speicher anfordern.</font></i>
  <b><font color="0000BB">end</font></b>;</code></pre>
Startpositionen der einzelnen Würfel definieren.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">const</font></b>
  d = <font color="#0077BB">1</font>.<font color="#0077BB">8</font>;
<b><font color="0000BB">var</font></b>
  i, s: integer;
<b><font color="0000BB">begin</font></b>
  s := CubeSize <b><font color="0000BB">div</font></b> <font color="#0077BB">2</font>;
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> CubeTotal - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    CubePosArray[i]^.pos.x := ((i <b><font color="0000BB">mod</font></b> CubeSize) - s) * d;
    CubePosArray[i]^.pos.y := ((i <b><font color="0000BB">div</font></b> CubeSize) <b><font color="0000BB">mod</font></b> CubeSize - s) * d;
    CubePosArray[i]^.pos.z := (i <b><font color="0000BB">div</font></b> (CubeSize * CubeSize) - s) * d;
  <b><font color="0000BB">end</font></b>;</code></pre>
Hier sieht man, das ich die Matrizen vor dem Zeichnen mit einem Quick-Sort sortiere.<br>
Die Tiefe ist in der Matrix bei <b>[3, 2]</b> gespeichert, somit nehme ich den Wert als Vergleich für die Sortierung.<br>
<pre><code=pascal>
<i><font color="#FFFF00">// Pointer vertauschen</font></i>
<b><font color="0000BB">procedure</font></b> SwapPointer(<b><font color="0000BB">var</font></b> p1, p2: Pointer); <b><font color="0000BB">inline</font></b>;
<b><font color="0000BB">var</font></b>
  dummy: Pointer;
<b><font color="0000BB">begin</font></b>
  dummy := p1;
  p1 := p2;
  p2 := dummy;
<b><font color="0000BB">end</font></b>;
<br>
<i><font color="#FFFF00">// Der Quick-Sort</font></i>
<b><font color="0000BB">procedure</font></b> QuickSort(<b><font color="0000BB">var</font></b> ia: <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> PCubePos; ALo, AHi: integer);
<b><font color="0000BB">var</font></b>
  Lo, Hi: integer;
  Pivot: TCubePos;
<b><font color="0000BB">begin</font></b>
  Lo := ALo;
  Hi := AHi;
  Pivot := ia[(Lo + Hi) <b><font color="0000BB">div</font></b> <font color="#0077BB">2</font>]^;
  <b><font color="0000BB">repeat</font></b>
    <b><font color="0000BB">while</font></b> ia[Lo]^.mat[<font color="#0077BB">3</font>, <font color="#0077BB">2</font>] &lt; Pivot.mat[<font color="#0077BB">3</font>, <font color="#0077BB">2</font>] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      Inc(Lo);
    <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">while</font></b> ia[Hi]^.mat[<font color="#0077BB">3</font>, <font color="#0077BB">2</font>] &gt; Pivot.mat[<font color="#0077BB">3</font>, <font color="#0077BB">2</font>] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      Dec(Hi);
    <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">if</font></b> Lo <= Hi <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      SwapPointer(ia[Lo], ia[Hi]);
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
<b><font color="0000BB">end</font></b>;</code></pre>
Hier sieht man, das die Matrix der einzelnen Würfel berechnet werden, um sie anschliessend nach der Z-Tiefe zu sortieren.<br>
Nach dem Sortieren werden die Würfel in der richtigen Reihenfolge gezeichnet.<br>
Versuchsweise kann man die Sortierroutine ausklammern, dann sieht man sofort die fehlerhafte Darstellung.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);  <i><font color="#FFFF00">// Frame und Tiefen-Buffer CubeSizeöschen.</font></i>
<br>
  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);
<br>
  Shader.UseProgram;
<br>
  glBindVertexArray(VBCube.VAO);
<br>

  <i><font color="#FFFF00">// --- Zeichne Würfel</font></i>
<br>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> CubeTotal - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    CubePosArray[i]^.mat.Identity;
    CubePosArray[i]^.mat.Translate(CubePosArray[i]^.pos);             <i><font color="#FFFF00">// Matrix verschieben.</font></i>
    CubePosArray[i]^.mat := WorldMatrix * CubePosArray[i]^.mat;       <i><font color="#FFFF00">// Matrixen multiplizieren.</font></i>
  <b><font color="0000BB">end</font></b>;
<br>
  QuickSort(CubePosArray, <font color="#0077BB">0</font>, CubeTotal - <font color="#0077BB">1</font>);                          <i><font color="#FFFF00">// Würfel nach der Z-Tiefe sortieren.</font></i>
<br>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> CubeTotal - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    CubePosArray[i]^.mat := FrustumMatrix * CubePosArray[i]^.mat;
    CubePosArray[i]^.mat.Uniform(Matrix_ID);                          <i><font color="#FFFF00">// Matrix dem Shader übergeben.</font></i>
    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(CubeVertex) * <font color="#0077BB">3</font>);            <i><font color="#FFFF00">// Zeichnet einen kleinen Würfel.</font></i>
  <b><font color="0000BB">end</font></b>;
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
Den Speicher von den CubePos wieder frei geben.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> CubeTotal - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">New</font></b>(CubePosArray[i]);
  <b><font color="0000BB">end</font></b>;</code></pre>
Gedreht wird nur die WorldMatrix.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  WorldMatrix.RotateA(<font color="#0077BB">0</font>.<font color="#0077BB">0123</font>);  <i><font color="#FFFF00">// Drehe um X-Achse</font></i>
  WorldMatrix.RotateB(<font color="#0077BB">0</font>.<font color="#0077BB">0234</font>);  <i><font color="#FFFF00">// Drehe um Y-Achse</font></i>
<br>
  ogc.Invalidate;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol; <i><font color="#FFFF00">// Farbe</font></i>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                       <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                  <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec4</font></b> Color;     <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor   = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
  outColor.a = <font color="#0077BB">0</font>.<font color="#0077BB">2</font>;   <i><font color="#FFFF00">// Farbe soll halb transparent sein.</font></i>
}
</code></pre>
<br>
</html>
