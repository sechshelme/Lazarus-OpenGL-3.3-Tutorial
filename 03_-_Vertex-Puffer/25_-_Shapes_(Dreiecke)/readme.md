# 03 - Vertex-Puffer
## 25 - Shapes (Dreiecke)

![image.png](image.png)

Bis jetzt wurde alles mit kompletten Dreiecken gerendert und gezeichnet. Es gibt aber noch zwei andere Varianten um Dreiecke zu rendern.
Dies wurde beim Zeichnen mit <b>glDrawArrays(GL_TRIANGLES, ...</b> veranlasst. Diese Version wird in der Paraxis am meisten angewendet.
Man kann die Dreiecke auch als Streifen hintereinander rendern, dies gerschieht mit <b>glDrawArrays(GL_TRIANGLES_STRIP, ...</b>.
Oder wie ein Wedel, dabei ist der erste Vektor die Mitte, und der Rest die Eckpunkte. Dies geschieht dann mit <b>glDrawArrays(GL_TRIANGLES_FAN, ...</b>.

Das schreiben in die Grafikkarte, ist bei allen Varianten gleich, der Unterschied ist legendlich beim Zeichenen mit <b>glDrawArrays(...</b>.

Die Darstellung sieht folgendermassen aus:

<b>GL_TRIANGLES</b>

```4 - 3     2
| /     / |
5     0 - 1
```

<b>GL_TRIANGLES_STRIP</b>

```  5 - 3 - 1
 / \ / \ / \
6 - 4 - 2 - 0
```

<b>GL_TRIANGLES_FAN</b>

```  5 - 4
 / \ / \
6 - 0 - 3
 \ / \ /
  1 - 2
```


---
Die Deklaration der Vektor-Koordianten Konstanten, zur Vereinfachung habe ich nur 2D-Vektoren genommen. Natürlich können diese auch 3D sein.

```pascal
const
  // Einfache Dreiecke        ( Gelb )
  Triangles: array[0..5] of TVertex2f =
    ((0.1, 0.0), (0.6, 0.0), (0.6, 0.5), (0.5, 0.6), (0.0, 0.5), (0.0, 0.1));
  // Dreicke als Band, Strip  ( Rot )
  Triangle_Strip: array[0..6] of TVertex2f =
    ((0.6, 0.0), (0.5, 0.5), (0.4, 0.2), (0.3, 0.5), (0.2, 0.0), (0.1, 0.4), (0.0, 0.0));
  // Dreiecke als Wedel, Fan  ( Grün )
  Triangle_Fan: array[0..6] of TVertex2f =
    ((0.0, 0.0), (-0.2, -0.3), (0.2, -0.3), (0.3, 0.0), (0.2, 0.3), (-0.2, 0.3), (-0.3, 0.0));
```

Hier werden die Daten in die Grafikkarte geschrieben.
Es hat nichts besonderes.

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für GL_TRIANGLE
  glBindVertexArray(VBTriangles.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangles.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangles), @Triangles, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Daten für GL_TRIANGLE_STRIP
  glBindVertexArray(VBTriangle_Strip.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle_Strip.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle_Strip), @Triangle_Strip, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Daten für GL_TRIANGLE_FAN
  glBindVertexArray(VBTriangle_Fan.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle_Fan.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle_Fan), @Triangle_Fan, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;
```

Bei <b>glDrawArrays(...</b> ist der erste Parameter das wichtigste, hier wird angegeben, wie die Vektor-Koordinaten gezeichnet werden.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne GL_TRIANGLE
  glUniform3f(Color_ID, 1.0, 1.0, 0.0); // Gelb
  glUniform1f(X_ID, -0.9);
  glUniform1f(Y_ID, -0.7);
  glBindVertexArray(VBTriangles.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangles));

  // Zeichne GL_TRIANGLE_STRIP
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Rot
  glUniform1f(X_ID, 0.3);
  glUniform1f(Y_ID, -0.6);
  glBindVertexArray(VBTriangle_Strip.VAO);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, Length(Triangle_Strip));

  // Zeichne GL_TRIANGLE_FAN
  glUniform3f(Color_ID, 0.0, 1.0, 0.0);  // Grün
  glUniform1f(X_ID, 0.0);
  glUniform1f(Y_ID, 0.4);
  glBindVertexArray(VBTriangle_Fan.VAO);
  glDrawArrays(GL_TRIANGLE_FAN, 0, Length(Triangle_Fan));
```

---
<b>Vertex-Shader:</b>

Da die Koordinaten nur als 2D gespeichert sind, wird im Vertex-Shader der Z-Wert auf 0.0 gesetzt.

```glsl
#version 330

layout (location = 10) in vec2 inPos; // Vertex-Koordinaten in 2D
uniform float x;                      // Richtung von Uniform
uniform float y;
 
void main(void)
{
  vec2 pos = inPos;
  pos.x = pos.x + x;
  pos.y = pos.y + y;
  gl_Position = vec4(pos, 0.0, 1.0);  // Der zweiter Parameter (Z) auf 0.0
}

```

---
<b>Fragment-Shader:</b>

```glsl
#version 330

uniform vec3 Color;  // Farbe von Uniform
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Color, 1.0);
}

```


