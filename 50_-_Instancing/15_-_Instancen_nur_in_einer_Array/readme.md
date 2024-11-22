# 50 - Instancing
## 15 - Instancen nur in einer Array

![image.png](image.png)

Vorher hatte es für jedes Instance-Attribut eine eigene Array gehabt.
Jetzt sind alle Attribute in einer Array, dies macht den Code einiges übersichtlicher.
Dafür ist die Übergabe mit **glVertexAttribPointer(...** ein wenig komplizierter.
Siehe [[Lazarus - OpenGL 3.3 Tutorial - Vertex-Puffer - Nur eine Array]].

---
Die Deklaration der Array. Es ist nur noch eine Array.

```pascal
type
  PData = ^TData;
  TData = record
    Scale: GLfloat;
    Matrix: TMatrix;
    Color: TVector3f;
  end;

var
  Data: array[0..InstanceCount - 1] of TData;
```

Das es ein wenig einfacher wird, habe ich **ofs** verwendet.

```pascal
procedure TForm1.InitScene;
var
  ofs, i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBQuad.VAO);

  // --- Normale Vektordaten
  // Daten für Vektoren
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, nil);

  // --- Instancen
  ofs := 0;
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data), PData(Data), GL_STATIC_DRAW);

  // Instance Size
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 1, GL_FLOAT, GL_FALSE, SizeOf(TData), nil);
  glVertexAttribDivisor(1, 1);
  Inc(ofs, SizeOf(GLfloat));

  // Instance Matrix
  for i := 0 to 3 do begin
    glEnableVertexAttribArray(i + 2);
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, GL_FALSE, SizeOf(TData),PGLvoid(ofs));
    glVertexAttribDivisor(i + 2, 1);
    Inc(ofs, SizeOf(TVector4f));
  end;

  // Instance Color
  glEnableVertexAttribArray(6);
  glVertexAttribPointer(6, 3, GL_FLOAT, GL_FALSE, SizeOf(TData), PGLvoid(ofs));
  glVertexAttribDivisor(6, 1);
end;
```

An der Zeichenroutine ändert sich nichts.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(Data), @Data);

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
  for i := 0 to Length(Data) - 1 do begin
    Data[i].Matrix.RotateC(0.02);
  end;

  ogcDrawScene(Sender);  // Neu zeichnen
end;
```


---
**Vertex-Shader:**
Am Shader hat sich nichts geändert.

```glsl
#version 330

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


---
**Fragment-Shader:**

```glsl
#version 330

out vec4 outColor;   // ausgegebene Farbe

in vec3 col;

void main(void)
{
  outColor = vec4(col, 1.0);
}

```


