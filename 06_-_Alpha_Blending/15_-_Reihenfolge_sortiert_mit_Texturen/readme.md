# 06 - Alpha Blending
## 15 - Reihenfolge sortiert mit Texturen

<img src="image.png" alt="Selfhtml"><br><br>
Da mit Texturen welche Alpha-Blending haben das gleiche Problem besteht, wie mit den Würfeln, muss man auch dort sortieren.
Da die Position der Bäume keine Drehbewegung haben, reicht ein Vector für dessen Position, eine Matrix ist nicht nötig.
Für den Boden wird eine Matrix gebraucht, da ich diesen drehe.

Zusätzlich habe ich für den Boden noch eine Textur genommen, somit sieht die Scene recht realistisch aus.

Wie Texturen funktionieren, in einem späteren Kapitel.
<hr><br>
Den Speicher für die Position der Bäume reservieren.

```pascal

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to TreeCount - 1 do begin
    New(TreePosArray[i]);
  end;
```

Die Position der Bäume  wird zufällig bestimmt.

```pascal
procedure TForm1.InitScene;
const
  d = 10;
var
  i: integer;
begin
  for i := 0 to TreeCount - 1 do begin
    TreePosArray[i]^.x := -d / 2 + Random * d;
    TreePosArray[i]^.y := 0.0;
    TreePosArray[i]^.z := -d / 2 + Random * d;
  end;
```

Der Boden und die Bäume zeichen.
Dabei ist es wichtig, das man zuerst den Boden zeichnet, weil die Bäume Alpha-Blending haben.
Objecte mit Alpha-Blending sollte man immer zum Schluss zeichnen.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);

  procedure QuickSort(var ia: array of PTreePos; ALo, AHi: integer);
  var
    Lo, Hi: integer;
    dummy : PTreePos;
    Pivot: TTreePos;
  begin
    Lo := ALo;
    Hi := AHi;
    Pivot := ia[(Lo + Hi) div 2]^;
    repeat
      while ia[Lo]^.z &lt; Pivot.z do begin
        Inc(Lo);
      end;
      while ia[Hi]^.z &gt; Pivot.z do begin
        Dec(Hi);
      end;
      if Lo <= Hi then begin
        dummy := ia[Lo];
        ia[Lo] := ia[Hi];
        ia[Hi] := dummy;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo &gt; Hi;
    if Hi &gt; ALo then begin
      QuickSort(ia, ALo, Hi);
    end;
    if Lo &lt; AHi then begin
      QuickSort(ia, Lo, AHi);
    end;
  end;

var
  i: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);        // Frame und Tiefen-Puffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  // --- Zeichne Boden
  SandTextur.ActiveAndBind;                                   // Boden-Textur binden
  Matrix.Identity;
  Matrix.Translate(0.0, 1.0, 0.0);
  Matrix.Scale(10.0);
  Matrix.RotateA(Pi / 2);

  Matrix := FrustumMatrix * WorldMatrix * GroundPos * Matrix; // Matrizen multiplizieren.

  Matrix.Uniform(Matrix_ID);                                  // Matrix dem Shader übergeben.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));      // Zeichnet einen kleinen Würfel.

  // --- Zeichne Bäume
  QuickSort(TreePosArray, 0, TreeCount - 1);                  // Die Bäume sortieren.

  BaumTextur.ActiveAndBind;                                   // Baum-Textur binden

  for i := 0 to TreeCount - 1 do begin
    Matrix.Identity;
    Matrix.Translate(TreePosArray[i]^);                       // Die Bäume an die richtige Position bringen

    Matrix := FrustumMatrix * WorldMatrix * Matrix;           // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));
  end;

  ogc.SwapBuffers;
end;
```

Da sieht man, das es reicht nur den Vector zu drehen.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
const
  rot = 0.0134;
var
  i: integer;
begin
  for i := 0 to TreeCount - 1 do begin
    TreePosArray[i]^.RotateB(rot);
  end;
  GroundPos.RotateB(rot);

  ogc.Invalidate;
end;
```

<hr><br>
<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location =  0) in vec3 inPos; // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;  // Textur-Koordinaten

out vec2 UV0;

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Frustum.

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  UV0         = inUV;                 // Textur-Koordinaten weiterleiten.
}

```

<hr><br>
<b>Fragment-Shader</b>

```glsl
#version 330

in vec2 UV0;

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
}

```


