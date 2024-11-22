# 03 - Vertex-Puffer
## 15 - Nur eine Array

![image.png](image.png)

Man kann die Vertex-Daten, auch alles in einen Daten-Block schreiben. Hier werden die Vector- und Color - Daten alle in einen Block geschrieben.
In den vorherigen Beispielen hat es für die Vector- und  Color - Daten eine separate TFace-Array gehabt.
Hier werden zwei Möglichkeiten vorgestellt, wie die Daten in der Array sind.
Variante1: **Vec0, Col0, ..., Vecn, Coln**
Variante2: **Vec0, ..., Vecn, Col0, ..., Coln**
Die hat noch den Vorteil, das nur ein **VBO** angelegt werden muss, obwohl mehrere Attribute in der Array sind.

---
Die zwei Daten-Varianten:
Variante 0: **XYZ RGB XYZ RGB XYZ RGB XYZ RGB XYZ RGB XYZ RGB**
Variante 1: **XYZ XYZ XYZ XYZ XYZ XYZ RGB RGB RGB RGB RGB RGB**

Bei dem zweiten Quadrat, sind die Y-Werte gespiegelt, es sollten zwei Quadrate sichtbar sein.

```pascal
const
  QuadVektor0: array[0..1] of TFace2 =
    // Vec, Col, Vec, Col, ....
    (((-0.2, 0.6, 0.0, 1.0, 0.0, 0.0), (-0.2, 0.1, 0.0, 0.0, 1.0, 0.0), (0.2, 0.1, 0.0, 1.0, 1.0, 0.0)),
    ((-0.2, 0.6, 0.0, 1.0, 0.0, 0.0), (0.2, 0.1, 0.0, 1.0, 1.0, 0.0), (0.2, 0.6, 0.0, 0.0, 1.0, 1.0)));
  QuadVektor1: array[0..3] of TFace =
    // Vec
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)),
    // Col
    ((1.0, 0.0, 1.0), (1.0, 1.0, 0.0), (1.0, 1.0, 1.0)),
    ((1.0, 0.0, 1.0), (1.0, 1.0, 1.0), (0.0, 1.0, 1.0)));
```

Hier die wichtigste Änderung:
Relevant sind die zwei letzten Parameter von **glVertexAttribPointer(...**
Was irritiert der einte Parameter ist direkt ein Integer, der andere braucht eine Typenumwandlung auf einen Pointer.
Der zweitletzte Parameter (stride), gibt das **Byte** Offset, zum nächsten Attribut-Wert an, repektive die Schritt/Block-grösse.
Der letzte Parameter (pointer), gibt die Position zum ersten Attribut-Wert an.
Die Werte sind immer als **Byte**, somit muss man bei einem **glFloat** immer **4x** rechnen.

Varinate 0:
Die Vektoren beginnen bei 0, Die Grösse ist 24Byte = 6 glFloat x 4 entspricht **XYZRGB**.
Die Farben beginnen beim 12Byte. Die Grösse ist mit 24Byte gleich wie bei den Vektoren.

Varinate 1:
Da die Vektoren hintereinander stehen, darf dieser Default (0) sein.
Die Farben beginnen beim 72Byte.

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // --- Daten für Quadrat 0
  glBindVertexArray(VBQuad0.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad0.VBO); // Nur ein VBO erforderlich
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor0), @QuadVektor0, GL_STATIC_DRAW);

  // Vektor
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 24, nil);  // nil = Pointer(0)

  // Farbe
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 24, Pointer(12));

  // --- Daten für Quadrat 1
  glBindVertexArray(VBQuad1.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad1.VBO); // Nur ein VBO erforderlich
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVektor1), @QuadVektor1, GL_STATIC_DRAW);

  // Vektor
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, GL_FALSE, 12, nil);

  // Farbe
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 3, GL_FLOAT, GL_FALSE, 12, Pointer(72));
end;
```

Das Zeichnen ist gleich, wie wen man separate Datenblöcke hätte. 
Es wurde das **Length(...** entfernt, da die einte Array zwei und die andere vier Elemente hat.
Was aber sicher ist, das beide Quadrate aus sechs Vektoren bestehen.

```pascal
  // Zeichne Quadrat 0
  glBindVertexArray(VBQuad0.VAO);
  glDrawArrays(GL_TRIANGLES, 0, 6);  // 6 Vertex pro Quadrat

  // Zeichne Quadrat 1
  glBindVertexArray(VBQuad1.VAO);
  glDrawArrays(GL_TRIANGLES, 0, 6);  // 6 Vertex pro Quadrat
```


---
**Vertex-Shader:**

Im Shader gibt es keine Änderung, da es diesem egal ist, wie **glVertexAttribPointer(...** die Daten übergibt.

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


