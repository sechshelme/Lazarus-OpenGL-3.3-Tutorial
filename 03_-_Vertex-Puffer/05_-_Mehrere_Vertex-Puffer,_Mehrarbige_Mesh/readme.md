# 03 - Vertex-Puffer
## 05 - Mehrere Vertex-Puffer, Mehrarbige Mesh

![image.png](image.png)

Bis jetzt wurde immer nur ein Vertex-Puffer pro Mesh geladen, hier wird ein zweiter geladen, welcher die Farben der Vektoren enthält.
Somit werden die Mesh mehrfarbig.

---
Es sind zwei zusätzliche Vertex-Konstanten dazu gekommen, welche die Farben der Ecken enthält.

```pascal
const
  TriangleVector: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));
  TriangleColor: array[0..0] of TFace =   // Rot / Grün / Blau
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)));
  QuadVector: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
  QuadColor: array[0..1] of TFace =       // Rot / Grün / Gelb / Rot / Gelb / Mint
    (((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (1.0, 1.0, 0.0)),
    ((1.0, 0.0, 0.0), (1.0, 1.0, 0.0), (0.0, 1.0, 1.0)));
```

Für die Farbe ist ein zusätzliches **Vertex Buffer Object** (VBO) hinzugekommen.

```pascal
type
  TVB = record
    VAO,
    VBOvert,         // VBO für Vektor.
    VBOcol: GLuint;  // VBO für Farbe.
  end;
```

CreateScene wurde um zwei Zeilen erweitert.
Die VB0 für den Farben-Puffer müssen noch generiert werden.

```pascal
  glGenBuffers(1, @VBTriangle.VBOvert);
  glGenBuffers(1, @VBTriangle.VBOcol);   // neu hinzugekommen
  glGenBuffers(1, @VBQuad.VBOvert);
  glGenBuffers(1, @VBQuad.VBOcol);       // neu hinzugekommen
```

Hier fast der wichtigste Teil, pro **Vertex Array Object** (VAO) wird ein zweiter Puffer in das VRAM geladen.
Die 10 und 11, muss indentisch sein, mit dem **location** im Shader.

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleVector), @TriangleVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                         // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // 11 ist die Location in inCol Shader.
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 0, nil);

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadColor), @QuadColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 0, nil);
end;
```

Jetzt kommt wieder ein grosser Vorteil von OpenGL 3.3, das Zeichnen geht gleich einfach wie wen man nur ein VBO hat.

```pascal
  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
```

Am Ende müssen noch die zusätzlichen VBO-Puffer frei gegeben werden.
Freigaben müssen immer gleich viele sein wie Erzeugungen.

```pascal
  glDeleteBuffers(1, @VBTriangle.VBOvert);
  glDeleteBuffers(1, @VBTriangle.VBOcol);
  glDeleteBuffers(1, @VBQuad.VBOvert);
  glDeleteBuffers(1, @VBQuad.VBOcol);
```


---
**Vertex-Shader:**

Hier ist eine zweite Location hinzugekommen, wichtig ist, das die Location-Nummer übereinstimmt, mit denen beim Vertex-Laden.

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


