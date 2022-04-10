<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>20 - Vertex-Daten zur Laufzeit modifizieren</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>20 - Vertex-Daten zur Laufzeit modifizieren</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt waren die Vertexdaten immer statisch. Man kann diese aber auch zur Laufzeit neu in den Vertex-Puffer schreiben.<br>
<br>
Da sich nicht nur die Koordinaten ändern, sondern auch die grösse des Mesh, muss die TFaceArray eine <b>dynamische</b> Array sein.<br>
Zur Demonstration, werden alle 1/2 Sekunden neue Vertex-Daten geladen.<br>
Dafür habe ich einen Kreis gewählt, der zufällig jedes mal eine andere Anzahl Sektoren bekommt. Die Farben der Vektoren werden auch zufällig erzeugt.<br>
<hr><br>
Zusätzlich ist noch eine <b>TFaceArray</b> hinzugekommen.<br>
Das sieht man, das die <b>TFaceArray</b> für das Mesh dynamisch ist.<br>
<br>
Für die einzelnen Meshes gibt es nun einen Record, welcher mit <b>size</b> die Grösse der TFace-Array speichert.<br>
Auch habe ich die Objekt-Namen von <b>VBO</b> und <b>VAO</b> in den Record genommen.<br>
<b>size</b> ist erforderlich, weil ich die Arraygrösse im RAM auf Null setzte. Sobald die Vertex-Daten sich im VRAM befinden, werden die Daten im RAM nicht mehr gebraucht.<br>
Bei einem sehr grossen Mesh kann man damit kostbares RAM sparen.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TVertex3f = <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> GLfloat;
  TFace = <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> TVertex3f;
  TFaceArray = <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> TFace;       <i><font color="#FFFF00">// neu</font></i>

  TMesh = <b><font color="0000BB">record</font></b>                     <i><font color="#FFFF00">// Record für die Mesh-Daten, welcher auch size enthält.</font></i>
    Vector, Color: TFaceArray;       <i><font color="#FFFF00">// Vertex-Daten.</font></i>
    size: integer;                   <i><font color="#FFFF00">// Die Grösse der Vertex-Daten.</font></i>
    VBuffer: TVB;                    <i><font color="#FFFF00">// VBO und VAO der Mesh.</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
Deklaration der beiden Meshes. Ich habe bewusst die Meshes in ein Array genommen.<br>
Somit kann man vieles mit einer For-To-Schleife machen. Was den Vorteil hat, wen man mehrere Meshes hat, man erspart sich viel Tipparbeit.<br>
<pre><code><b><font color="0000BB">var</font></b>
  CircleMesh: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TMesh;</pre></code>
Mit dieser Funktion werden neue Vertex-Daten berechnet.<br>
Es wird ein Kreis mit zufälliger Anzahl Sektoren erzeugt, somit hat man unterschiedlich lange Vertex-Daten.<br>
Mit <b>ofsx</b> wird das Mesh in der X-Achse verschoben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateVertex(<b><font color="0000BB">var</font></b> Mesh: TMesh; ofsx: GLfloat);
<b><font color="0000BB">const</font></b>
  r = <font color="#0077BB">0</font>.<font color="#0077BB">5</font>;  <i><font color="#FFFF00">// Radius des Kreises.</font></i>
<b><font color="0000BB">var</font></b>
  i, j: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">with</font></b> Mesh <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    size := Random(maxSektor - <font color="#0077BB">3</font>) + <font color="#0077BB">3</font>;
    SetLength(Vector, size);
    SetLength(Color, size);
    <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> size - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      <b><font color="0000BB">for</font></b> j := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">2</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
        Color[i, j, <font color="#0077BB">0</font>] := Random();
        Color[i, j, <font color="#0077BB">1</font>] := Random();
        Color[i, j, <font color="#0077BB">2</font>] := Random();
      <b><font color="0000BB">end</font></b>;

      Vector[i, <font color="#0077BB">0</font>, <font color="#0077BB">0</font>] := ofsx;
      Vector[i, <font color="#0077BB">0</font>, <font color="#0077BB">1</font>] := <font color="#0077BB">0</font>;
      Vector[i, <font color="#0077BB">0</font>, <font color="#0077BB">2</font>] := <font color="#0077BB">0</font>;

      Vector[i, <font color="#0077BB">1</font>, <font color="#0077BB">0</font>] := sin(Pi * <font color="#0077BB">2</font> / size * i) * r + ofsx;
      Vector[i, <font color="#0077BB">1</font>, <font color="#0077BB">1</font>] := cos(Pi * <font color="#0077BB">2</font> / size * i) * r;
      Vector[i, <font color="#0077BB">1</font>, <font color="#0077BB">2</font>] := <font color="#0077BB">0</font>;

      Vector[i, <font color="#0077BB">2</font>, <font color="#0077BB">0</font>] := sin(Pi * <font color="#0077BB">2</font> / size * (i + <font color="#0077BB">1</font>)) * r + ofsx;
      Vector[i, <font color="#0077BB">2</font>, <font color="#0077BB">1</font>] := cos(Pi * <font color="#0077BB">2</font> / size * (i + <font color="#0077BB">1</font>)) * r;
      Vector[i, <font color="#0077BB">2</font>, <font color="#0077BB">2</font>] := <font color="#0077BB">0</font>;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Hier werden schon mal die ersten Vertex-Daten erzeugt.<br>
Später werden neue Daten in einem Timer erzeugt.<br>
Mit UpdateScene werden sie dann in das VRAM geladen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormCreate(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  ogc := TContext.Create(<b><font color="0000BB">Self</font></b>);
  ogc.OnPaint := @ogcDrawScene;

  Randomize;

  CreateScene;

  CreateVertex(CircleMesh[<font color="#0077BB">0</font>], <font color="#0077BB">0</font>.<font color="#0077BB">5</font>);   <i><font color="#FFFF00">// Vertex-Daten erzeugen.</font></i>
  CreateVertex(CircleMesh[<font color="#0077BB">1</font>], -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>);

  UpdateScene(<font color="#0077BB">0</font>);                     <i><font color="#FFFF00">// Vertex-Daten in VRAM schreiben.</font></i>
  UpdateScene(<font color="#0077BB">1</font>);                     <i><font color="#FFFF00">// Vertex-Daten in VRAM schreiben.</font></i>
  Timer1.Enabled := <b><font color="0000BB">True</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Das Anlegen der Puffer geht mit einer Schleife viel einfacher.<br>
Bei den zwei Meshes wie bei diesem Beispiel hier, sind die Ersparnisse nicht so gross, aber will man zB. 20 Kreise darstellen, sieht dies schon viel anders aus.<br>
<br>
Da die Vertex-Daten erst zur Laufzeit geladen/geändert werden, wird mit <b>glBufferData(...</b> nur der Speicher dafür reserviert.<br>
<br>
Auch ist der zweite Parameter (size) etwas anders angegeben, wen man nur SizeOf(Array) macht, würden nur 4Byte zurückgeliefert (Die grösse des Zeigers der Array).<br>
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

      glBindVertexArray(VBuffer.VAO);

      <i><font color="#FFFF00">// Vektor</font></i>
      glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOvert);
      glBufferData(GL_ARRAY_BUFFER, sizeof(TFace) * maxSektor, <b><font color="0000BB">nil</font></b>, GL_DYNAMIC_DRAW); <i><font color="#FFFF00">// Nur Speicher reservieren.</font></i>
      glEnableVertexAttribArray(<font color="#0077BB">10</font>);
      glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

      <i><font color="#FFFF00">// Farbe</font></i>
      glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOcol);
      glBufferData(GL_ARRAY_BUFFER, sizeof(TFace) * maxSektor, <b><font color="0000BB">nil</font></b>, GL_DYNAMIC_DRAW);
      glEnableVertexAttribArray(<font color="#0077BB">11</font>);
      glVertexAttribPointer(<font color="#0077BB">11</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Da der Speicher im VRAM schon reserviert ist, kann man mit <b>glBufferSubData(...</b> nur noch die Vertex-Daten in das VRAM schreiben/ersetzen.<br>
<br>
Nach dem schreiben ins VRAM , kann mit <b>SetLength(...</b> die Daten im RAM entfernt werden.<br>
Wen die Daten einmal im VRAM sind, werden sie im RAM nicht mehr gebraucht.<br>
<br>
Der Zeiger auf die Vertex-Daten, bei <b>glBufferSubData(...</b> hat sich ein wenig verändert.<br>
Anstelle von <b>@</b> muss man bei einer dynamischen Array mit <b>Pointer</b> arbeiten.<br>
Auch wen man mit <b>glBufferData(...</b> schreiben würden muss man es bei der dynamischen Array so machen.<br>
Ansonsten wird der Zeiger der Array übergeben, anstelle der Daten selbst, da die Array selbst nur ein Zeiger auf die Daten ist.<br>
<br>
Mit <b>MeshNr</b> wird die Mesh angegben, welche neu in das VRAM kopiert werden soll.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.UpdateScene(MeshNr: integer);
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">with</font></b> CircleMesh[MeshNr] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glBindVertexArray(VBuffer.VAO);

    <i><font color="#FFFF00">// Vektor</font></i>
    glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOvert);
    glBufferSubData(GL_ARRAY_BUFFER, <font color="#0077BB">0</font>, sizeof(TFace) * size, Pointer(Vector)); <i><font color="#FFFF00">// Daten ins VRAM schreiben.</font></i>
    SetLength(Vector, <font color="#0077BB">0</font>);                                                       <i><font color="#FFFF00">// Daten im RAM entfernen.</font></i>

    <i><font color="#FFFF00">// Farbe</font></i>
    glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOcol);
    glBufferSubData(GL_ARRAY_BUFFER, <font color="#0077BB">0</font>, sizeof(TFace) * size, Pointer(Color));
    SetLength(Color, <font color="#0077BB">0</font>);
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Das Zeichen ist nichts besonderes, ausser das es jetzt mit einer Schleife läuft.<br>
<pre><code><i><font color="#FFFF00">// Zeichne Kreise</font></i>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Length(CircleMesh) - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">with</font></b> CircleMesh[i] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      glBindVertexArray(VBuffer.VAO);
      glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, size * <font color="#0077BB">3</font>);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</pre></code>
Mit einem Timer werden alle 1/2 Sekunden neue Vertex-Daten erzeugt und in das VRAM geladen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  za: integer = <font color="#0077BB">0</font>;
<b><font color="0000BB">begin</font></b>
  Inc(za);
  <b><font color="0000BB">if</font></b> za = <font color="#0077BB">5</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>                    <i><font color="#FFFF00">// Mesh 0 neu erzeugen und laden</font></i>
    CreateVertex(CircleMesh[<font color="#0077BB">0</font>], <font color="#0077BB">0</font>.<font color="#0077BB">5</font>);
    UpdateScene(<font color="#0077BB">0</font>);                       <i><font color="#FFFF00">// Daten mit dem VAO 0 binden.</font></i>
    ogc.Invalidate;                       <i><font color="#FFFF00">// Neu zeichnen.</font></i>
  <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">if</font></b> za = <font color="#0077BB">10</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>          <i><font color="#FFFF00">// Mesh 1 neu erzeugen und laden</font></i>
    CreateVertex(CircleMesh[<font color="#0077BB">1</font>], -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>);
    UpdateScene(<font color="#0077BB">1</font>);                       <i><font color="#FFFF00">// Daten mit dem VAO 1 binden</font></i>
    ogc.Invalidate;                       <i><font color="#FFFF00">// Neu zeichnen.</font></i>
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
