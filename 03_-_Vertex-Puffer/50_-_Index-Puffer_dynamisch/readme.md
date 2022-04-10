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
<pre><code>type
  TVertex3f = array[0..2] of GLfloat;</font>

  TMesh = record                        // Record für die Mesh-Daten, welcher auch size enthält.
    Vector, Color: array of TVertex3f;  // Vertex-Daten.
    Vec_Count: integer;                 // Die Grösse der Vertex-Daten.
    Indicies: array of GLint;           // Indicies-Daten.
    Indicies_Count: integer;            // Die Grösser der Indicies-Array.
    VBuffer: TVB;                       // VBO und VAO der Mesh.
  end;</pre></code>
Mit dieser Funktion werden die Vertex-Daten und die Indicen berechnet.<br>
Es wird ein Kreis mit zufälliger Anzahl Sektoren erzeugt, somit hat man unterschiedlich lange Vertex-Daten.<br>
Mit <b>ofsx</b> wird das Mesh in der X-Achse verschoben.<br>
<pre><code>procedure TForm1.CreateVertex_and_Indicien(var Mesh: TMesh; ofsx: GLfloat);
const
  r = 0.5;  // Radius des Kreises.</font>
var
  i: integer;
begin
  with Mesh do begin
    Vec_Count := Random(maxSektor - 3) + 3;</font>
    Indicies_Count := Vec_Count * 3;</font>
    Inc(Vec_Count);

    SetLength(Vector, Vec_Count);
    SetLength(Color, Vec_Count);
    SetLength(Indicies, Indicies_Count);

    for i := 0 to Vec_Count - 1 do begin
      Color[i, 0] := Random();</font>
      Color[i, 1] := Random();</font>
      Color[i, 2] := Random();</font>
    end;

    for i := 0 to Vec_Count - 2 do begin
      Vector[i, 0] := sin(Pi * 2 / (Vec_Count - 1) * i) * r + ofsx;</font>
      Vector[i, 1] := cos(Pi * 2 / (Vec_Count - 1) * i) * r;</font>
      Vector[i, 2] := 0;</font>

      Indicies[i * 3 + 0] := Vec_Count - 1;
      Indicies[i * 3 + 1] := i;</font>
      Indicies[i * 3 + 2] := i + 1;</font>
    end;

    // Das letzte Array-Element ist das Zentrum.
    Vector[Vec_Count - 1, 0] := ofsx;</font>
    Vector[Vec_Count - 1, 1] := 0;</font>
    Vector[Vec_Count - 1, 2] := 0;</font>

    // Der Letzte Index muss auf den ersten Vektor zeigen.
    Indicies[Indicies_Count - 1] := 0;</font>
  end;
end;</pre></code>
Hier werden schon mal die ersten Vertex-Daten und Indicien erzeugt.<br>
Später werden neue Daten in einem Timer erzeugt.<br>
Mit UpdateScene werden sie dann in das VRAM geladen.<br>
<pre><code>procedure TForm1.FormCreate(Sender: TObject);
begin
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  Randomize;

  CreateScene;

  CreateVertex_and_Indicien(CircleMesh[0], 0.5);   // Vertex-Daten erzeugen.</font>
  CreateVertex_and_Indicien(CircleMesh[1], -0.5);</font>

  UpdateScene(0);                                  // Daten in VRAM schreiben.
  UpdateScene(1);                                  // Daten in VRAM schreiben.
  Timer1.Enabled := True;
end;</pre></code>
Da die Vertex-Daten erst zur Laufzeit geladen/geändert werden, wird mit <b>glBufferData(...</b> nur der Speicher dafür reserviert.<br>
<pre><code>procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;

  for i := 0 to Length(CircleMesh) - 1 do begin
    with CircleMesh[i] do begin
      glGenVertexArrays(1, @VBuffer.VAO);</font>
      glGenBuffers(1, @VBuffer.VBOvert);</font>
      glGenBuffers(1, @VBuffer.VBOcol);</font>
      glGenBuffers(1, @VBuffer.IBO);</font>

      glBindVertexArray(VBuffer.VAO);

      // Vektor
      glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOvert);
      glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex3f) * (maxSektor + 1), nil, GL_DYNAMIC_DRAW); // Nur Speicher reservieren.
      glEnableVertexAttribArray(10);</font>
      glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

      // Farbe
      glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOcol);
      glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex3f) * (maxSektor + 1), nil, GL_DYNAMIC_DRAW);
      glEnableVertexAttribArray(11);</font>
      glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

      // Indicien
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBuffer.IBO);
      glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLint) * maxSektor * 3, nil, GL_DYNAMIC_DRAW);
    end;
  end;
end;</pre></code>
Da der Speicher im VRAM schon reserviert ist, kann man mit <b>glBufferSubData(...</b> nur noch die Vertex-Daten in das VRAM schreiben/ersetzen.<br>
<br>
Nach dem schreiben ins VRAM , kann mit <b>SetLength(...</b> die Daten im RAM entfernt werden.<br>
Wen die Daten einmal im VRAM sind, werden sie im RAM nicht mehr gebraucht.<br>
<br>
Mit <b>MeshNr</b> wird die Mesh angegben, welche neu in das VRAM kopiert werden soll.<br>
<pre><code>procedure TForm1.UpdateScene(MeshNr: integer);
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);</font>

  with CircleMesh[MeshNr] do begin
    glBindVertexArray(VBuffer.VAO);

    // Vektor
    glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOvert);
    glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(TVertex3f) * Vec_Count, Pointer(Vector)); 
    SetLength(Vector, 0);                                                                

    // Farbe
    glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOcol);
    glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(TVertex3f) * Vec_Count, Pointer(Color));
    SetLength(Color, 0);</font>

    // Indicien
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBuffer.IBO);
    glBufferSubData(GL_ELEMENT_ARRAY_BUFFER, 0, sizeof(GLint) * Indicies_Count, Pointer(Indicies)); // Daten ins VRAM schreiben.
    SetLength(Indicies, 0);                                                                         // Daten im RAM entfernen.
  end;
end;</pre></code>
Gezeichnet wird dann mit <b>glDrawElements(...</b>, wobei der letzte Paramter nur noch <b>Nil</b> ist, da sich die Daten bereits im VRAM befinden.<br>
<pre><code>  // Zeichne Kreise
  for i := 0 to Length(CircleMesh) - 1 do begin
    with CircleMesh[i] do begin
      glBindVertexArray(VBuffer.VAO);
      glDrawElements(GL_TRIANGLES, Indicies_Count, GL_UNSIGNED_INT, nil);  // Hier Nil
    end;
  end;</pre></code>
Mit einem Timer werden alle 1/2 Sekunden neue Vertex-Daten erzeugt und in das VRAM geladen.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  za: integer = 0;</font>
begin
  Inc(za);
  if za = 5 then begin                             // Mesh 0 neu erzeugen und laden
    CreateVertex_and_Indicien(CircleMesh[0], 0.5);</font>
    UpdateScene(0);                                // Daten mit dem VAO 0 binden.
    ogc.Invalidate;                                // Neu zeichnen.
  end else if za = 10 then begin                   // Mesh 1 neu erzeugen und laden
    CreateVertex_and_Indicien(CircleMesh[1], -0.5);</font>
    UpdateScene(1);                                // Daten mit dem VAO 1 binden
    ogc.Invalidate;                                // Neu zeichnen.
    za := 0;</font>
  end;
end;</pre></code>
<hr><br>
Bei den Shadern gibt es nichts besonders.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 11) in vec3 inCol; // Farbe</font>

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
  Color = vec4(inCol, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
