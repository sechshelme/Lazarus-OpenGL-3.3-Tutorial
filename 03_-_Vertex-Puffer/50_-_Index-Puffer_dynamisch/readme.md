<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>50 - Index-Puffer dynamisch</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Indicien kann man auch zur Laufzeit im VRAM verändern, dies geht fast gleich, wie bei den Vertex-Daten.<br>
Man macht dies auch mit <b>glBufferSubData(...</b>.<br>
<hr><br>
Dafür nimmt man für die Indicen auch eine dynamische Array.<br>
Auch für diese Array wird die Länge gespeichert, da man diese nach dem Laden ins VRAM aus dem RAM entfernen kann.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TVertex3f = <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> GLfloat;

  TMesh = <b><font color="0000BB">record</font></b>                        <i><font color="#FFFF00">// Record für die Mesh-Daten, welcher auch size enthält.</font></i>
    Vector, Color: <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> TVertex3f;  <i><font color="#FFFF00">// Vertex-Daten.</font></i>
    Vec_Count: integer;                 <i><font color="#FFFF00">// Die Grösse der Vertex-Daten.</font></i>
    Indicies: <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> GLint;           <i><font color="#FFFF00">// Indicies-Daten.</font></i>
    Indicies_Count: integer;            <i><font color="#FFFF00">// Die Grösser der Indicies-Array.</font></i>
    VBuffer: TVB;                       <i><font color="#FFFF00">// VBO und VAO der Mesh.</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
Mit dieser Funktion werden die Vertex-Daten und die Indicen berechnet.<br>
Es wird ein Kreis mit zufälliger Anzahl Sektoren erzeugt, somit hat man unterschiedlich lange Vertex-Daten.<br>
Mit <b>ofsx</b> wird das Mesh in der X-Achse verschoben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateVertex_and_Indicien(<b><font color="0000BB">var</font></b> Mesh: TMesh; ofsx: GLfloat);
<b><font color="0000BB">const</font></b>
  r = <font color="#0077BB">0</font>.<font color="#0077BB">5</font>;  <i><font color="#FFFF00">// Radius des Kreises.</font></i>
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">with</font></b> Mesh <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Vec_Count := Random(maxSektor - <font color="#0077BB">3</font>) + <font color="#0077BB">3</font>;
    Indicies_Count := Vec_Count * <font color="#0077BB">3</font>;
    Inc(Vec_Count);

    SetLength(Vector, Vec_Count);
    SetLength(Color, Vec_Count);
    SetLength(Indicies, Indicies_Count);

    <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Vec_Count - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      Color[i, <font color="#0077BB">0</font>] := Random();
      Color[i, <font color="#0077BB">1</font>] := Random();
      Color[i, <font color="#0077BB">2</font>] := Random();
    <b><font color="0000BB">end</font></b>;

    <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Vec_Count - <font color="#0077BB">2</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      Vector[i, <font color="#0077BB">0</font>] := sin(Pi * <font color="#0077BB">2</font> / (Vec_Count - <font color="#0077BB">1</font>) * i) * r + ofsx;
      Vector[i, <font color="#0077BB">1</font>] := cos(Pi * <font color="#0077BB">2</font> / (Vec_Count - <font color="#0077BB">1</font>) * i) * r;
      Vector[i, <font color="#0077BB">2</font>] := <font color="#0077BB">0</font>;

      Indicies[i * <font color="#0077BB">3</font> + <font color="#0077BB">0</font>] := Vec_Count - <font color="#0077BB">1</font>;
      Indicies[i * <font color="#0077BB">3</font> + <font color="#0077BB">1</font>] := i;
      Indicies[i * <font color="#0077BB">3</font> + <font color="#0077BB">2</font>] := i + <font color="#0077BB">1</font>;
    <b><font color="0000BB">end</font></b>;

    <i><font color="#FFFF00">// Das letzte Array-Element ist das Zentrum.</font></i>
    Vector[Vec_Count - <font color="#0077BB">1</font>, <font color="#0077BB">0</font>] := ofsx;
    Vector[Vec_Count - <font color="#0077BB">1</font>, <font color="#0077BB">1</font>] := <font color="#0077BB">0</font>;
    Vector[Vec_Count - <font color="#0077BB">1</font>, <font color="#0077BB">2</font>] := <font color="#0077BB">0</font>;

    <i><font color="#FFFF00">// Der Letzte Index muss auf den ersten Vektor zeigen.</font></i>
    Indicies[Indicies_Count - <font color="#0077BB">1</font>] := <font color="#0077BB">0</font>;
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Hier werden schon mal die ersten Vertex-Daten und Indicien erzeugt.<br>
Später werden neue Daten in einem Timer erzeugt.<br>
Mit UpdateScene werden sie dann in das VRAM geladen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormCreate(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  ogc := TContext.Create(<b><font color="0000BB">Self</font></b>);
  ogc.OnPaint := @ogcDrawScene;

  Randomize;

  CreateScene;

  CreateVertex_and_Indicien(CircleMesh[<font color="#0077BB">0</font>], <font color="#0077BB">0</font>.<font color="#0077BB">5</font>);   <i><font color="#FFFF00">// Vertex-Daten erzeugen.</font></i>
  CreateVertex_and_Indicien(CircleMesh[<font color="#0077BB">1</font>], -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>);

  UpdateScene(<font color="#0077BB">0</font>);                                  <i><font color="#FFFF00">// Daten in VRAM schreiben.</font></i>
  UpdateScene(<font color="#0077BB">1</font>);                                  <i><font color="#FFFF00">// Daten in VRAM schreiben.</font></i>
  Timer1.Enabled := <b><font color="0000BB">True</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Da die Vertex-Daten erst zur Laufzeit geladen/geändert werden, wird mit <b>glBufferData(...</b> nur der Speicher dafür reserviert.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;

  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Length(CircleMesh) - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">with</font></b> CircleMesh[i] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      glGenVertexArrays(<font color="#0077BB">1</font>, @VBuffer.VAO);
      glGenBuffers(<font color="#0077BB">1</font>, @VBuffer.VBOvert);
      glGenBuffers(<font color="#0077BB">1</font>, @VBuffer.VBOcol);
      glGenBuffers(<font color="#0077BB">1</font>, @VBuffer.IBO);

      glBindVertexArray(VBuffer.VAO);

      <i><font color="#FFFF00">// Vektor</font></i>
      glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOvert);
      glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex3f) * (maxSektor + <font color="#0077BB">1</font>), <b><font color="0000BB">nil</font></b>, GL_DYNAMIC_DRAW); <i><font color="#FFFF00">// Nur Speicher reservieren.</font></i>
      glEnableVertexAttribArray(<font color="#0077BB">10</font>);
      glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

      <i><font color="#FFFF00">// Farbe</font></i>
      glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOcol);
      glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex3f) * (maxSektor + <font color="#0077BB">1</font>), <b><font color="0000BB">nil</font></b>, GL_DYNAMIC_DRAW);
      glEnableVertexAttribArray(<font color="#0077BB">11</font>);
      glVertexAttribPointer(<font color="#0077BB">11</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

      <i><font color="#FFFF00">// Indicien</font></i>
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBuffer.IBO);
      glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLint) * maxSektor * <font color="#0077BB">3</font>, <b><font color="0000BB">nil</font></b>, GL_DYNAMIC_DRAW);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Da der Speicher im VRAM schon reserviert ist, kann man mit <b>glBufferSubData(...</b> nur noch die Vertex-Daten in das VRAM schreiben/ersetzen.<br>
<br>
Nach dem schreiben ins VRAM , kann mit <b>SetLength(...</b> die Daten im RAM entfernt werden.<br>
Wen die Daten einmal im VRAM sind, werden sie im RAM nicht mehr gebraucht.<br>
<br>
Mit <b>MeshNr</b> wird die Mesh angegben, welche neu in das VRAM kopiert werden soll.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.UpdateScene(MeshNr: integer);
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">with</font></b> CircleMesh[MeshNr] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glBindVertexArray(VBuffer.VAO);

    <i><font color="#FFFF00">// Vektor</font></i>
    glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOvert);
    glBufferSubData(GL_ARRAY_BUFFER, <font color="#0077BB">0</font>, sizeof(TVertex3f) * Vec_Count, Pointer(Vector)); 
    SetLength(Vector, <font color="#0077BB">0</font>);                                                                

    <i><font color="#FFFF00">// Farbe</font></i>
    glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOcol);
    glBufferSubData(GL_ARRAY_BUFFER, <font color="#0077BB">0</font>, sizeof(TVertex3f) * Vec_Count, Pointer(Color));
    SetLength(Color, <font color="#0077BB">0</font>);

    <i><font color="#FFFF00">// Indicien</font></i>
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBuffer.IBO);
    glBufferSubData(GL_ELEMENT_ARRAY_BUFFER, <font color="#0077BB">0</font>, sizeof(GLint) * Indicies_Count, Pointer(Indicies)); <i><font color="#FFFF00">// Daten ins VRAM schreiben.</font></i>
    SetLength(Indicies, <font color="#0077BB">0</font>);                                                                         <i><font color="#FFFF00">// Daten im RAM entfernen.</font></i>
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Gezeichnet wird dann mit <b>glDrawElements(...</b>, wobei der letzte Paramter nur noch <b>Nil</b> ist, da sich die Daten bereits im VRAM befinden.<br>
<pre><code>  <i><font color="#FFFF00">// Zeichne Kreise</font></i>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Length(CircleMesh) - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">with</font></b> CircleMesh[i] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      glBindVertexArray(VBuffer.VAO);
      glDrawElements(GL_TRIANGLES, Indicies_Count, GL_UNSIGNED_INT, <b><font color="0000BB">nil</font></b>);  <i><font color="#FFFF00">// Hier Nil</font></i>
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</pre></code>
Mit einem Timer werden alle 1/2 Sekunden neue Vertex-Daten erzeugt und in das VRAM geladen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  za: integer = <font color="#0077BB">0</font>;
<b><font color="0000BB">begin</font></b>
  Inc(za);
  <b><font color="0000BB">if</font></b> za = <font color="#0077BB">5</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>                             <i><font color="#FFFF00">// Mesh 0 neu erzeugen und laden</font></i>
    CreateVertex_and_Indicien(CircleMesh[<font color="#0077BB">0</font>], <font color="#0077BB">0</font>.<font color="#0077BB">5</font>);
    UpdateScene(<font color="#0077BB">0</font>);                                <i><font color="#FFFF00">// Daten mit dem VAO 0 binden.</font></i>
    ogc.Invalidate;                                <i><font color="#FFFF00">// Neu zeichnen.</font></i>
  <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">if</font></b> za = <font color="#0077BB">10</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>                   <i><font color="#FFFF00">// Mesh 1 neu erzeugen und laden</font></i>
    CreateVertex_and_Indicien(CircleMesh[<font color="#0077BB">1</font>], -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>);
    UpdateScene(<font color="#0077BB">1</font>);                                <i><font color="#FFFF00">// Daten mit dem VAO 1 binden</font></i>
    ogc.Invalidate;                                <i><font color="#FFFF00">// Neu zeichnen.</font></i>
    za := <font color="#0077BB">0</font>;
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Bei den Shadern gibt es nichts besonders.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol; <i><font color="#FFFF00">// Farbe</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                       <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec4</font></b> Color;      <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
