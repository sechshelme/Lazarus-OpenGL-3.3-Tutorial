# 50 - Instancing
## 05 - Instance mit Uniform

![image.png](image.png)

Man kann für jede Instance einen eigenen Uniform-Wert zu ordnen. Dafür packt man die Uniform-Werte in ein Array,
welches >= anzahl Instancen ist.

Dieses Verfahren hat zwei Nachteile.
1. Man muss die Anzahl Intancen von Anfang an wissen.
2. Die Anzahl Uniform-Werte ist begrenzt, bei diesem Beispiel und einem Intel4000 ist bei gut 800 Instancen Schluss.

Diese Nachteile kann man umgehen, wen man anstelle von Uniformen VertexAttrib verwendet, dazu im nächasten Thema.

---
Die Anzahl Instance

```pascal
const
  InstanceCount = 200;
```

Die Deklaration, der Paramter für die einzelnen Instancen.
Die Size könnte man mit der Matrix kombinieren, aber hier geht es um die Funktionsweise der Uniform-Übergaben.

```pascal
var
  Matrix_ID, Color_ID, Size_ID: GLint;

  VBQuad: TVB;

  Data: record
    Size: array[0..InstanceCount - 1] of GLfloat;
    Matrix: array[0..InstanceCount - 1] of TMatrix;
    Color: array[0..InstanceCount - 1] of TVector3f;
  end;
```

Das Auslesen der UniformID. Dies geschieht gleich wie bei einfachen Uniformen.
Die Instancen-Parameter mit zufälligen Werten belegen.

```pascal
procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Size_ID := Shader.UniformLocation('Size');
  Matrix_ID := Shader.UniformLocation('mat');
  Color_ID := Shader.UniformLocation('Color');

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBO);

  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Size[i] := Random() * 20 + 1.0;
    Data.Matrix[i].Identity;
    Data.Matrix[i].Translate(1.5 - Random * 3.0, 1.5- Random * 3.0, 0.0);
    Data.Color[i] := vec3(Random, Random, Random);
  end;
end;
```

Die Übergabe der Uniform-Werte. Da es sich um Arrays handelt, muss man noch die Länge der Array übergeben.
Auch sieht man gut, das mal **glDrawArraysInstanced(...** nur einmal aufrufen muss.
Würde man dies ohne Instancen lössen, müsste man die Uniformübergabe und glDraw... 200x aufrufen.
Da sieht man den Vorteil, es ist viel weniger Kominikation mit der Grafikkarte nötig.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  glUniform1fv(Size_ID, InstanceCount, @Data.Size);
  glUniformMatrix4fv(Matrix_ID, InstanceCount, False, @Data.Matrix);
  glUniform3fv(Color_ID, InstanceCount, @Data.Color);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, InstanceCount);

  ogc.SwapBuffers;
end;
```

Die Matrizen drehen.
Dies muss man 200x machen, aber es sind nicht 200 Übergaben zur Grafikkarte nötig.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Matrix[i].RotateC(0.02);
  end;

  ogcDrawScene(Sender);  // Neu zeichnen
end;
```


---
**Vertex-Shader:**
Hier sieht man, das mit **gl_InstanceID** auf die eizelnen Array-Elemente zugegriffen wird.

```glsl
#version 330

#define Instance_Count 200

layout (location = 0) in vec2 inPos;

uniform float Size[Instance_Count];
uniform mat4 mat[Instance_Count];
uniform vec3 Color[Instance_Count];

out vec3 col;

void main(void)
{
  gl_Position = mat[gl_InstanceID] * vec4((inPos * Size[gl_InstanceID]), 0.0, 1.0);

  col = Color[gl_InstanceID];
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


