# 03 - Vertex-Puffer
## 10 - Vertex-Puffer in 2D

![image.png](image.png)

Wen man nur eine 2D-Mesh hat, kann man die Vektor-Koordinaten auch als **2D** in das VRAM laden.
Man kann sich dabei den **Z-Wert** sparen. Matrix-Operation mit eine 4x4 Matrix funktionieren wie wen es 3D wäre.
Für die Farbe wird hier nur eine **1D-Array** verwendet, da die Mesh nur Rot-Töne enthält. **Grün** und **Blau** wird im Shader auf **0.0** gesetzt.

Man könnte zusätzlich noch einen **VBO** für **Rot** und **Grün** erzeugen. Somit könnte man jede Farbe einzeln in eine Array schreiben.

---
Ein 2D-Vertex ist noch dazu gekommen.

```pascal
type
  TVertex2f = array[0..1] of GLfloat;
```

Die Vector-Konstanten sind nur noch 2D, der Z-Wert fehlt.
Die Farbe ist nur noch ein einfacher **float**, da nur Rot ausgegeben wird.

```pascal
const
  TriangleVector: array[0..0] of TFace2D =                     // Nur noch eine 2D-Array (XY).
    (((-0.4, 0.1), (0.4, 0.1), (0.0, 0.7)));
  TriangleColor: array[0..0] of TVertex3f = ((1.0, 0.5, 0.0)); // Nur eine Float-Array.
  QuadVector: array[0..1] of TFace2D =
    (((-0.2, -0.6), (-0.2, -0.1), (0.2, -0.1)),
    ((-0.2, -0.6), (0.2, -0.1), (0.2, -0.6)));
  QuadColor: array[0..1] of TVertex3f =
    ((0.5, 0.0, 1.0), (0.5, 1.0, 0.0));
```

Bei **glVertexAttribPointer(...** wurde der zweite Parameter, von **3** auf **2** ersetzt.
Bei einer Farb-Übergabe mit Alpha-Blending (RGBA), kann es auch eine **4** sein.
Hier wird sogar nur eine **1** verwendet, da die Rot-Töne nur eine einfache Array ist.

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
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, 0, nil); // Der zweite Wert ist eine 2 für 2D.

  // Farbe
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOcol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TriangleColor), @TriangleColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);                         // Der zweite Wert ist eine 1 für eine Farbe (Rot).
  glVertexAttribPointer(11, 1, GL_FLOAT, GL_FALSE, 0, nil);
```


---
**Vertex-Shader:**

Der Z-Wert des Vektors wird konstant auf **0.0** gesetzt.
Eine Z-Bewegung der ganzen Mesh ist mit einer Matrix trozdem noch möglich. ZB. für Sprite-Darstellung.
Die **in**-Variable könnte man auch auf **vec3** belassen, wie bei einem normalen 3D-Shader. Es wird dann automatisch ein **0.0** für den Z-Wert gesetzt.

Die Farbe kommt nur noch in einem **float** an, aus diesem Grund hat **Grün** und **Blau** eine feste Konstante **0.0**.

```glsl
#version 330

layout (location = 10) in vec2 inPos;     // Vertex-Koordinaten, nur XY.
layout (location = 11) in float inCol;    // Farbe, es kommt nur Rot.

out vec4 Color;                           // Farbe, an Fragment-Shader übergeben.

void main(void)
{
  gl_Position = vec4(inPos, 0.0, 1.0);    // Z ist immer 0.0
  Color = vec4(inCol, 0.0, 0.0, 1.0);     // Der Rot- und Grün - Teil, ist 0.0
}

```


---
**Fragment-Shader**

```glsl
#version 330

in vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor; // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}

```


