# 03 - Vertex-Puffer
## 65 - Integer Uebergabe

![e image.png](e image.png)

Bis jetzt wurde immer nur ein Vertex-Puffer pro Mesh geladen, hier wird ein zweiter geladen, welcher die Farben der Vektoren enthält.
Somit werden die Mesh mehrfarbig.

---
Hier ist noch ein Integer-Array dazugekommen.

```pascal
type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

  TColorIndexs = array[0..2] of GLint;

const
  TriangleVector: array[0..0] of TFace = (
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColorIndex: array[0..0] of TColorIndexs = (
    (0, 1, 2));
  QuadVector: array[0..1] of TFace = (
    ((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColorIndex: array[0..1] of TColorIndexs = (
    (0, 1, 2),
    (0, 2, 1));
```

Achtung, bei Integer in einem Attribut, muss

```pascal
glVertexAttribIPointer(11, 1, GL_INT, 0, nil);
```

anstelle

```pascal
glVertexAttribPointer(11, 1, GL_FLOAT, GL_FALSE, 0, nil);
```

verwendet werden !
Mehr Infos: https://stackoverflow.com/questions/28014864/why-do-different-variations-of-glvertexattribpointer-exist

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcolIndex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColorIndex), @TriangleColorIndex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribIPointer(11, 1, GL_INT, 0, nil);

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcolIndex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColorIndex), @QuadColorIndex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribIPointer(11, 1, GL_INT, 0, nil);
end;
```


---
**Vertex-Shader:**
Hier wird das Integer Attribut verwendet.

```glsl
#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
layout (location = 11) in int  inCol; // Farb-Index

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
  vec3 c;

  switch (inCol)
  {
    case 0:  c = vec3(1.0, 0.0, 0.0);
             break;
    case 1:  c = vec3(0.0, 1.0, 0.0);
             break;
    case 2:  c = vec3(0.0, 0.0, 1.0);
             break;
  }

  Color = vec4(c, 1.0);
}

```


---
**Fragment-Shader**

```glsl
#version 330

in vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}

```


