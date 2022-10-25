# 03 - Vertex-Puffer
## 40 - Indices

<img src="image.png" alt="Selfhtml"><br><br>
Normalerweise, werden die Polygone der Reihenfolge der Vertex-Konstanten abgearbeitet.
Man kann aber auch selbst bestimmen, welche Koordinate abgearbeitet werden.
Dafür muss man eine Indices-Array kreieren, welche die Reihenfolge der Koordinaten bestimmt.

Der Unterschied zum einfachen Zeichenn ist, das ich noch eine Indicen-Array brauche.
Und das Zeichnen ist vor allem anders.
Man verwendet anstelle von <b>glDrawArrays(...</b>, <b>glDrawElements(...</b>, welche als dritten Parameter noch einen Zeiger auf die Indicen-Array bekommt.
<hr><br>
Die Deklaration der Vektor-Koordianten und Indicien Konstanten.
Beim Dreieck sieht man keinen Vorteil bei der Indicien-Version, da das Dreieck sowieso nur aus einem Polygon besteht.
Beim Quadrat, konnten so schon zwei Koordinaten eingespart werden, da man die Eckpunkte nur einmal angeben muss.
Bei der einfachen Variante bräuchte es dafür sechs Eckpunte, weil dort zwei Punkte doppelt vorhandnen sein müssen.
Bei einem Würfel ist der Vorteil noch grösser, da braucht es bei der einfachen Version 36 Punkte, bei der Indicien-Version, nur 8 Stück !

Mit den Indicen kann ich sagen, zeichen von Punkt 0-1-2 und von Punkt 0-2-3.


```3 - 2
| / |
0 - 1
```


```pascal
const
  // --- Dreieck
  // Vertex-Koordinaten
  Triangle: array[0..2] of TVertex3f =
    ((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0));
  // Indicien ( Reihenfolge )
  Triangle_Indices: array[0..2] of GLint = (0, 1, 2);

  // --- Quadrat
  // Vertex-Koordinaten
  Quad: array[0..3] of TVertex3f =
    ((-0.2, -0.6, 0.0), (0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (-0.2, -0.1, 0.0));
  // Indicien ( Reihenfolge )
  Quad_Indices: array[0..5] of GLint = (0, 1, 2, 0, 2, 3);
```

Bei <b>glDrawElements(...</b>, muss als dritten Parameter der Zeiger auf die Indicien-Array übergeben werden.
Ansonsten geht das Zeichen gleich, wie bei der einfachen Methode.
Der Polygonmodus wurde auf Linien umgestellt, so das man die Polygone besser sieht.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   // Linien
  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawElements(GL_TRIANGLES, Length(Triangle_Indices), GL_UNSIGNED_INT, @Triangle_Indices);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawElements(GL_TRIANGLES, Length(Quad_Indices), GL_UNSIGNED_INT, @Quad_Indices);
```

<hr><br>
<b>Vertex-Shader:</b>


```glsl
#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
}

```

<hr><br>
<b>Fragment-Shader:</b>

```glsl
#version 330

out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  vec3 col = vec3(1.0, 1.0, 0.0); // Gelb
  outColor = vec4(col, 1.0);
}

```


