# 20 - Texturen
## 50 - Textur-Koordinaten

![image.png](image.png)

Dieses Beispiel zeigt, wie sich Textur-Koordinaten auf die Textur auswirken.
Bei der linken Textur, entsprechen die Textur-Koordinaten, denen der Vektoren, dies gibt ein Matrix ähnliches Muster, ausser das sie skaliert wird.
Rechts ist jede Koordinate von 0.0-1.0, somit wird die Textur um die Scheibe gezogen. Jedes Rechteck enthält die ganze Textur.

---
Hier sieht man gut, das die Textur-Koordinaten verschieden Werte bekommen.

```pascal
procedure TForm1.CalcCircle;
const
  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));

  Sektoren = 16;
  r0 = 0.5;
  r1 = 1.0;
var
  i: integer;
  w0, w1: single;

begin
  SetLength(Disc, Sektoren * 3 * 2);

  for i := 0 to Sektoren - 1 do begin
    w0 := pi * 2 / Sektoren * (i + 0);
    w1 := pi * 2 / Sektoren * (i + 1);

    // 1. Dreieck

    Disc[i * 2 * 3 + 0].Vertex := vec3(sin(w0) * r0, cos(w0) * r0, 0.0);
    Disc[i * 2 * 3 + 1].Vertex := vec3(sin(w0) * r1, cos(w0) * r1, 0.0);
    Disc[i * 2 * 3 + 2].Vertex := vec3(sin(w1) * r1, cos(w1) * r1, 0.0);

    Disc[i * 2 * 3 + 0].TexkoorL := Disc[i * 2 * 3 + 0].Vertex.xy;
    Disc[i * 2 * 3 + 0].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 1].TexkoorL := Disc[i * 2 * 3 + 1].Vertex.xy;
    Disc[i * 2 * 3 + 1].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 2].TexkoorL := Disc[i * 2 * 3 + 2].Vertex.xy;
    Disc[i * 2 * 3 + 2].TexkoorL.scale(5.0);

    Disc[i * 2 * 3 + 0].TexkoorR := TextureVertex[3];
    Disc[i * 2 * 3 + 1].TexkoorR := TextureVertex[4];
    Disc[i * 2 * 3 + 2].TexkoorR := TextureVertex[5];

    // 2. Dreieck

    Disc[i * 2 * 3 + 3].Vertex := vec3(sin(w0) * r0, cos(w0) * r0, 0.0);
    Disc[i * 2 * 3 + 4].Vertex := vec3(sin(w1) * r1, cos(w1) * r1, 0.0);
    Disc[i * 2 * 3 + 5].Vertex := vec3(sin(w1) * r0, cos(w1) * r0, 0.0);

    Disc[i * 2 * 3 + 3].TexkoorL := Disc[i * 2 * 3 + 3].Vertex.xy;
    Disc[i * 2 * 3 + 3].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 4].TexkoorL := Disc[i * 2 * 3 + 4].Vertex.xy;
    Disc[i * 2 * 3 + 4].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 5].TexkoorL := Disc[i * 2 * 3 + 5].Vertex.xy;
    Disc[i * 2 * 3 + 5].TexkoorL.scale(5.0);

    Disc[i * 2 * 3 + 3].TexkoorR := TextureVertex[0];
    Disc[i * 2 * 3 + 4].TexkoorR := TextureVertex[1];
    Disc[i * 2 * 3 + 5].TexkoorR := TextureVertex[2];
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
  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 28, Pointer(0));

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 28, Pointer(12));

  // Ring Rechts
  glBindVertexArray(VBRingR.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRingR.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 28, Pointer(0));

  glBindBuffer(GL_ARRAY_BUFFER, VBRingR.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 28, Pointer(20));
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
  ProdMatrix.Translate(-0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix := TempMatrix;

  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Disc) * 3); // Zeichnet die linke Scheibe

  // Zeichne rechte Scheibe
  ProdMatrix.Translate(0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBRingR.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Disc) * 3); // Zeichnet die rechte Scheibe

  ogc.SwapBuffers;
end;
```


---
**Vertex-Shader:**

```glsl
#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten

uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}

```


---
**Fragment-Shader:**

```glsl
#version 330

in vec2 UV0;

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
  FragColor.a = 1.0;
}

```


---
**muster.xpm:**

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


