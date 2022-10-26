# 03 - Vertex-Puffer
## 50 - Index-Puffer dynamisch

![image.png](image.png)

Indicien kann man auch zur Laufzeit im VRAM verändern, dies geht fast gleich, wie bei den Vertex-Daten.
Man macht dies auch mit <b>glBufferSubData(...</b>.
---
Dafür nimmt man für die Indicen auch eine dynamische Array.
Auch für diese Array wird die Länge gespeichert, da man diese nach dem Laden ins VRAM aus dem RAM entfernen kann.

```pascal
type
  TVertex3f = array[0..2] of GLfloat;

  TMesh = record                        // Record für die Mesh-Daten, welcher auch size enthält.
    Vector, Color: array of TVertex3f;  // Vertex-Daten.
    Vec_Count: integer;                 // Die Grösse der Vertex-Daten.
    Indicies: array of GLint;           // Indicies-Daten.
    Indicies_Count: integer;            // Die Grösser der Indicies-Array.
    VBuffer: TVB;                       // VBO und VAO der Mesh.
  end;
```

Mit dieser Funktion werden die Vertex-Daten und die Indicen berechnet.
Es wird ein Kreis mit zufälliger Anzahl Sektoren erzeugt, somit hat man unterschiedlich lange Vertex-Daten.
Mit <b>ofsx</b> wird das Mesh in der X-Achse verschoben.

```pascal
procedure TForm1.CreateVertex_and_Indicien(var Mesh: TMesh; ofsx: GLfloat);
const
  r = 0.5;  // Radius des Kreises.
var
  i: integer;
begin
  with Mesh do begin
    Vec_Count := Random(maxSektor - 3) + 3;
    Indicies_Count := Vec_Count * 3;
    Inc(Vec_Count);

    SetLength(Vector, Vec_Count);
    SetLength(Color, Vec_Count);
    SetLength(Indicies, Indicies_Count);

    for i := 0 to Vec_Count - 1 do begin
      Color[i, 0] := Random();
      Color[i, 1] := Random();
      Color[i, 2] := Random();
    end;

    for i := 0 to Vec_Count - 2 do begin
      Vector[i, 0] := sin(Pi * 2 / (Vec_Count - 1) * i) * r + ofsx;
      Vector[i, 1] := cos(Pi * 2 / (Vec_Count - 1) * i) * r;
      Vector[i, 2] := 0;

      Indicies[i * 3 + 0] := Vec_Count - 1;
      Indicies[i * 3 + 1] := i;
      Indicies[i * 3 + 2] := i + 1;
    end;

    // Das letzte Array-Element ist das Zentrum.
    Vector[Vec_Count - 1, 0] := ofsx;
    Vector[Vec_Count - 1, 1] := 0;
    Vector[Vec_Count - 1, 2] := 0;

    // Der Letzte Index muss auf den ersten Vektor zeigen.
    Indicies[Indicies_Count - 1] := 0;
  end;
end;
```

Hier werden schon mal die ersten Vertex-Daten und Indicien erzeugt.
Später werden neue Daten in einem Timer erzeugt.
Mit UpdateScene werden sie dann in das VRAM geladen.

```pascal
procedure TForm1.FormCreate(Sender: TObject);
begin
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  Randomize;

  CreateScene;

  CreateVertex_and_Indicien(CircleMesh[0], 0.5);   // Vertex-Daten erzeugen.
  CreateVertex_and_Indicien(CircleMesh[1], -0.5);

  UpdateScene(0);                                  // Daten in VRAM schreiben.
  UpdateScene(1);                                  // Daten in VRAM schreiben.
  Timer1.Enabled := True;
end;
```

Da die Vertex-Daten erst zur Laufzeit geladen/geändert werden, wird mit <b>glBufferData(...</b> nur der Speicher dafür reserviert.

```pascal
procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  for i := 0 to Length(CircleMesh) - 1 do begin
    with CircleMesh[i] do begin
      glGenVertexArrays(1, @VBuffer.VAO);
      glGenBuffers(1, @VBuffer.VBOvert);
      glGenBuffers(1, @VBuffer.VBOcol);
      glGenBuffers(1, @VBuffer.IBO);

      glBindVertexArray(VBuffer.VAO);

      // Vektor
      glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOvert);
      glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex3f) * (maxSektor + 1), nil, GL_DYNAMIC_DRAW); // Nur Speicher reservieren.
      glEnableVertexAttribArray(10);
      glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);

      // Farbe
      glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOcol);
      glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex3f) * (maxSektor + 1), nil, GL_DYNAMIC_DRAW);
      glEnableVertexAttribArray(11);
      glVertexAttribPointer(11, 3, GL_FLOAT, False, 0, nil);

      // Indicien
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBuffer.IBO);
      glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(GLint) * maxSektor * 3, nil, GL_DYNAMIC_DRAW);
    end;
  end;
end;
```

Da der Speicher im VRAM schon reserviert ist, kann man mit <b>glBufferSubData(...</b> nur noch die Vertex-Daten in das VRAM schreiben/ersetzen.

Nach dem schreiben ins VRAM , kann mit <b>SetLength(...</b> die Daten im RAM entfernt werden.
Wen die Daten einmal im VRAM sind, werden sie im RAM nicht mehr gebraucht.

Mit <b>MeshNr</b> wird die Mesh angegben, welche neu in das VRAM kopiert werden soll.

```pascal
procedure TForm1.UpdateScene(MeshNr: integer);
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);

  with CircleMesh[MeshNr] do begin
    glBindVertexArray(VBuffer.VAO);

    // Vektor
    glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOvert);
    glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(TVertex3f) * Vec_Count, Pointer(Vector)); 
    SetLength(Vector, 0);                                                                

    // Farbe
    glBindBuffer(GL_ARRAY_BUFFER, VBuffer.VBOcol);
    glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(TVertex3f) * Vec_Count, Pointer(Color));
    SetLength(Color, 0);

    // Indicien
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBuffer.IBO);
    glBufferSubData(GL_ELEMENT_ARRAY_BUFFER, 0, sizeof(GLint) * Indicies_Count, Pointer(Indicies)); // Daten ins VRAM schreiben.
    SetLength(Indicies, 0);                                                                         // Daten im RAM entfernen.
  end;
end;
```

Gezeichnet wird dann mit <b>glDrawElements(...</b>, wobei der letzte Paramter nur noch <b>Nil</b> ist, da sich die Daten bereits im VRAM befinden.

```pascal
  // Zeichne Kreise
  for i := 0 to Length(CircleMesh) - 1 do begin
    with CircleMesh[i] do begin
      glBindVertexArray(VBuffer.VAO);
      glDrawElements(GL_TRIANGLES, Indicies_Count, GL_UNSIGNED_INT, nil);  // Hier Nil
    end;
  end;
```

Mit einem Timer werden alle 1/2 Sekunden neue Vertex-Daten erzeugt und in das VRAM geladen.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
const
  za: integer = 0;
begin
  Inc(za);
  if za = 5 then begin                             // Mesh 0 neu erzeugen und laden
    CreateVertex_and_Indicien(CircleMesh[0], 0.5);
    UpdateScene(0);                                // Daten mit dem VAO 0 binden.
    ogc.Invalidate;                                // Neu zeichnen.
  end else if za = 10 then begin                   // Mesh 1 neu erzeugen und laden
    CreateVertex_and_Indicien(CircleMesh[1], -0.5);
    UpdateScene(1);                                // Daten mit dem VAO 1 binden
    ogc.Invalidate;                                // Neu zeichnen.
    za := 0;
  end;
end;
```

---
Bei den Shadern gibt es nichts besonders.

<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
layout (location = 11) in vec3 inCol; // Farbe

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  Color = vec4(inCol, 1.0);
}

```

---
<b>Fragment-Shader:</b>

```glsl
#version 330

in vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}

```


