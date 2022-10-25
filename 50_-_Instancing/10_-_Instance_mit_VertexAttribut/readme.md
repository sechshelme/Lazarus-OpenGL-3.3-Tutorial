# 50 - Instancing
## 10 - Instance mit VertexAttribut

<img src="image.png" alt="Selfhtml"><br><br>
Hier sind sogar 10'000'000 Instancen möglich, gegenüber der Uniform-Variante die bei gut 800 schon Schluss machte.
Bei noch höheren Werten macht der FPC-Compiler Schluss, wieviel das die Grafikkarte vertägt, kann ich nicht sagen.
Das es eine Diashow ist, das ist was anderes.
<hr><br>
Die Anzahl Instance

```pascal
const
  InstanceCount = 10000;
```

Für die Instancen werden VBOs gebraucht.

```pascal
type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex,
      I_Size, I_Matrix, I_Color: GLuint;
    end;
  end;
```

Die Deklaration, der Arrays ist gleich wie bei der Uniform-Übergaben.

```pascal
var
  VBQuad: TVB;

  Data: record
    Scale: array[0..InstanceCount - 1] of GLfloat;
    Matrix: array[0..InstanceCount - 1] of TMatrix;
    Color: array[0..InstanceCount - 1] of TVector3f;
  end;
```

VBO-Puffer für Instancen anlegen. Uniformen werden keine gebraucht.

```pascal
procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(4, @VBQuad.VBO);

  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Scale[i] := Random * 2 + 1.0;
    Data.Matrix[i].Identity;
    Data.Matrix[i].Translate(1.5 - Random * 3.0, 1.5 - Random * 3.0, 0.0);
    Data.Color[i] := vec3(Random, Random, Random);
  end;
end;
```

Für die Instancen werden die Puffer gefüllt.
Da für die Puffer nur Vektoren mit 1-4 Elemeten erlaubt sind, muss man die Matrix in 4 Vektoren unterteilen.
Dabei werden auch 4 Attribut-Indexe gebraucht.
Eine <b>glVertexAttribPointer(2, 16,...</b> geht leider nicht. Im Shader kann man es direkt als Matrix deklarieren.
So was geht leider nicht:

```pascal
  glVertexAttribPointer(2, 16, GL_FLOAT, False, 0, nil);
```

Mit <b>glVertexAttribDivisor(...</b> teilt man mit das es sich um ein Instance-Attribut handelt.
Der erste Parameter bestimmt, um welches Vertex-Attribut es sich handelt.
Der Zweite sagt, das der Zeiger im Vertex-Attribut bei jedem Durchgang um <b>1</b> erhöt wird.
Setzt man dort <b>0</b> ein, handelt es sich um ein gewöhnliches Attribut.
Was Werte >1 bedeuten ist bei <b>VertexAttribDivisor</b> beschrieben.

```pascal
procedure TForm1.InitScene;
var
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBQuad.VAO);

  // --- Normale Vektordaten
  // Daten für Vektoren
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // --- Instancen
  // Instance Size
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Size);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Scale), @Data.Scale, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 1, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(1, 1);

  // Instance Matrix
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Matrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Matrix), nil, GL_STATIC_DRAW); // Nur Speicher reservieren
  for i := 0 to 3 do begin
    glEnableVertexAttribArray(i + 2);
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, False, SizeOf(TMatrix), Pointer(i * 16));
    glVertexAttribDivisor(i + 2, 1);
  end;

  // Instance Color
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Color);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Color), @Data.Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(6);
  glVertexAttribPointer(6, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(6, 1);
end;
```

Die Instance Parameter werden einfache mit <b>glBufferSubData(....</b> übergeben.
Es werden nur die Matrizen aktualisiert, die anderen Werte bleiben gleich.
Will man eine andere Anzahl von Instance, dann muss man mit <b>glBufferData(...</b> mehr oder weniger Speicher reservieren.
Dafür braucht man keine Uniformen.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Matrix);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(Data.Matrix), @Data.Matrix);

  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, InstanceCount);

  ogc.SwapBuffers;
end;
```

Matrizen neu berechnen.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Matrix[i].RotateC(0.02);
  end;

  glBindVertexArray(VBQuad.VAO);
  ogcDrawScene(Sender);  // Neu zeichnen
end;
```

<hr><br>
<b>Vertex-Shader:</b>
Der Shader sieht sehr einfach aus.

```glsl
#version 330

#define Instance_Count 200

// Vektor-Daten
layout (location = 0) in vec2 inPos;

// Instancen
layout (location = 1) in float Size;
layout (location = 2) in mat4 mat;
layout (location = 6) in vec3 Color;

out vec3 col;

void main(void)
{
  gl_Position = mat * vec4((inPos * Size), 0.0, 1.0);

  col = Color;
}

```

<hr><br>
<b>Fragment-Shader:</b>

```glsl
#version 330

out vec4 outColor;   // ausgegebene Farbe

in vec3 col;

void main(void)
{
  outColor = vec4(col, 1.0);
}

```


