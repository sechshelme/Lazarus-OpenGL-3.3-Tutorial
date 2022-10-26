# 35 - Geometrie-Shader
## 00 - Breite Linien

![image.png](image.png)

Dieses Beispiel zeigt, wie sich Textur-Koordinaten auf die Textur auswirken.
Bei der linken Textur, entsprechen die Textur-Koordinaten, denen der Vektoren, dies gibt ein Matrix ähnliches Muster, ausser das sie skaliert wird.
Rechts ist jede Koordinate von 0.0-1.0, somit wird die Textur um die Scheibe gezogen. Jedes Rechteck enthält die ganze Textur.
---
Hier sieht man gut, das die Textur-Koordinaten verschieden Werte bekommen.

```pascal
procedure TForm1.CalcCircle;
const
  Sektoren = 7;
  maxSek = Sektoren * 8;
  r = 1.6 / maxSek;
var
  i: integer;
begin
  SetLength(Linies, maxSek);
  SetLength(Linies_Prev, maxSek);
  SetLength(Linies_Next, maxSek);
  for i := 0 to maxSek - 1 do begin
    Linies[i, 0] := sin(Pi * 2 / Sektoren * i) * r * i;
    Linies[i, 1] := cos(Pi * 2 / Sektoren * i) * r * i;
  end;

  Linies_Prev[0] := vec2(0.0, 0.0);
  for i := 1 to maxSek - 1 do begin
    Linies_Prev[i] := Linies[i - 1];
  end;

  Linies_Next[maxSek - 1] := vec2(0.0, 0.0);
  for i := 0 to maxSek - 1 - 1 do begin
    Linies_Next[i] := Linies[i + 1];
  end;

end;
```

Vertex-Koordianten bekommen beide Meshes die gleichen, aber die Textur-Koordinaten weichen ab.

```pascal
procedure TForm1.InitScene;
begin
  TextureBuffer.ActiveAndBind;
  glClearColor(0.6, 0.6, 0.4, 1.0);

  // Ring Links
  glBindVertexArray(VBRingL.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Prev);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies_Prev), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Next);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies_Next), GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, False, 0, nil);
end;
```


```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  TextureBuffer.ActiveAndBind;

  Shader.UseProgram;

  ProdMatrix := ScaleMatrix * RotMatrix;

  // Zeichne linke Scheibe
  TempMatrix := ProdMatrix;
  //  ProdMatrix.Translate(-0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix := TempMatrix;

  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_LINE_STRIP, 0, Length(Linies) div 2);

  ogc.SwapBuffers;
end;
```

---
<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 0) in vec2 inPos;
layout (location = 1) in vec2 inPrev;
layout (location = 2) in vec2 inNext;

uniform mat4 mat;

out vec2 Prev;
out vec2 Next;

void main(void)
{
//  Prev = inPrev;
///  Next = inNext;

  Prev = (mat * vec4(inPrev, 0.0, 1.0)).xy;
  Next = (mat * vec4(inNext, 0.0, 1.0)).xy;

  gl_Position = mat * vec4(inPos, 0.0, 1.0);
}

```

---
<b>Fragment-Shader:</b>

```glsl
#version 330

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

in vec3 Color;

out vec4 FragColor;

void main()
{
//  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
  FragColor = vec4(Color, 1.0);
}

```

---
<b>muster.xpm:</b>

```glsl
/* XPM */
static char *XPM_mauer[] = {
  "8 8 3 1",
  "  c #882222",
  "* c #442222",
  "+ c #4422BB",
  "        ",
  " ****** ",
  " *    * ",
  " * ++ * ",
  " * ++ * ",
  " *    * ",
  " ****** ",
  "        "
};

```


