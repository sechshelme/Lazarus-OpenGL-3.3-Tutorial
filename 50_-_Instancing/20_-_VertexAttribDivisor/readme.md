# 50 - Instancing
## 20 - VertexAttribDivisor

<img src="image.png" alt="Selfhtml"><br><br>
Mit <b>VertexAttribDivisor</b> kann man nicht nur bestimmen, das es sich im ein Instance-Attribut handelt.
Man kann auch festlegen, das ein Attribut-Wert mehrmals verwendet wird, bevor er um eins weiter springt.
Im Beispiel sieht man, das der Farb-Wert vier mal verwendet wird, bevor der nächste wert kommt.
<hr><br>
Für die Farben werden nur 4 Werte benötigt. Diese werden als Konstante deklariert,
da diese sich zur Laufzeit nicht mehr ändern.

```pascal
const
  Quad: array[0..1] of TFace3D =
    (((-0.8, -0.8, 0.0), (-0.8, 0.8, 0.0), (0.8, 0.8, 0.0)),
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));

  Instance_Color: array[0..3] of TVector3f =
    ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0));
```

Rechtecke gibt es 16 Stück, die Matrizen dafür sind dynamisch.

```pascal
var
  Instance_Matrix: array[0..15] of TMatrix;
```

Mit <b>glVertexAttribDivisor(...</b> kann man nicht nur bestimmen, das es sich um ein Instance-Attribut handelt.
Sondern man kann auch sagen wie viel mal ein Attribut-Wert verwendet wird.
Dies geschieht mit dem zweiten Parameter.

```pascal
procedure TForm1.InitScene;
var
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.Pos);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(0, 0);

  // Instance Color
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iColor);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Instance_Color), @Instance_Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(1, 4); // Wert 4x verwenden.

  // Instance Matrix
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iMatrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(TMatrix) * Length(Instance_Matrix), nil, GL_STATIC_DRAW);
  for i := 0 to 3 do begin
    glEnableVertexAttribArray(i + 2);
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, False, SizeOf(TMatrix), Pointer(i * 16));
    glVertexAttribDivisor(i + 2, 1); // Wert 1x verwenden.
  end;
end;
```

Matrizen drehen und anschliessend, neu laden.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
const
  r: GLfloat = 0.0;
var
  i: integer;
begin
  r += 0.01;
  if r &gt; 2 * pi then begin
    r -= 2 * pi;
  end;

  for i := 0 to 15 do begin
    Instance_Matrix[i].Identity;
    Instance_Matrix[i].Scale(0.25, 0.05, 1.0);
    Instance_Matrix[i].RotateC(Pi * 2 / 16 * i + r);
    Instance_Matrix[i].TranslateLocalspace(2.0, 0.0, 0.0);
  end;

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iMatrix);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(TMatrix) * Length(Instance_Matrix), @Instance_Matrix);

  ogc.Invalidate;
end;
```

<hr><br>
<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 instance_color;
layout (location = 2) in mat4 instance_Matrix;

out vec4 Color;

void main(void) {
  gl_Position = instance_Matrix * vec4(position, 1.0);
  Color       = vec4(instance_color, 1.0);
}


```

<hr><br>
<b>Fragment-Shader</b>

```glsl
#version 330

in  vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}

```


