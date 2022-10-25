# 03 - Vertex-Puffer
## 30 - Shapes (Linien und Punkte)

<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt wurde alles mit kompletten Dreiecken gerendert und gezeichnet. Es gibt aber noch zwei andere Varianten um Dreiecke zu rendern.
Dies wurde beim Zeichnen mit <b>glDrawArrays(GL_TRIANGLES, ...</b> veranlasst. Diese Version wird in der Paraxis am meisten angewendet.
Man kann die Dreiecke auch als Streifen hintereinander rendern, dies gerschieht mit <b>glDrawArrays(GL_TRIANGLES_STRIP, ...</b>.
Oder wie ein Wedel, dabei ist der erste Vektor die Mitte, und der Rest die Eckpunkte. Dies geschieht dann mit <b>glDrawArrays(GL_TRIANGLES_FAN, ...</b>.

Das schreiben in die Grafikkarte, ist bei allen Varianten gleich, der Unterschied ist legendlich beim Zeichenen mit <b>glDrawArrays(...</b>.
<hr><br>
Die Deklaration der Vektor-Koordianten Konstanten, zur Vereinfachung habe ich nur 2D-Vektoren genommen. Natürlich können diese auch 3D sein.

```pascal
var
  Linies: array of TVertex2f; // XY-Koordinaten
```

Hier werden die Daten in die Grafikkarte geschrieben.
Es hat nichts besonderes, da für jede Mesh die gleichen Koordinaten verwendet werden.

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für GL_TRIANGLE
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex2f) * Length(Linies), Pointer(Linies), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);
end;
```

Bei <b>glDrawArrays(...</b> ist der erste Parameter das wichtigste, hier wird angegeben, wie die Vektor-Koordinaten gezeichnet werden.
Hier werden vier Möglichkeiten gezeigt, dazu werden immer die gleichen Vertex-Koordinaten verwendet. Daher sieht man den Unterschied gut.

Mit <b>glLineWidth(...</b> kann die Linienbreite angegeben werden, default ist <b>1.0</b> .
Mit <b>glPointSize(...</b> kann der Durchmesser der Punkte angegeben werden, default ist <b>1.0</b> .
Für die Punkte gibt es noch eine andere Möglichkeit, man kann den Durchmesser auch im Shader angegeben, dazu später.

Wen mit <b>glPolygonMode(...</b> auf Punkte oder Linien umgestellt wird, haben diese beiden Parameter auch einen Einfluss.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  ofs = 0.4;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glBindVertexArray(VBTriangle.VAO);

  // Zeichne GL_LINES
  glLineWidth(3);                        // Linie 3 Pixel breit.
  glUniform3f(Color_ID, 1.0, 1.0, 0.0) ; // Gelb
  glUniform1f(X_ID, -ofs);               // links-
  glUniform1f(Y_ID, -ofs);               // unten
  glDrawArrays(GL_LINES, 0, Length(Linies));

  // Zeichne GL_LINE_STRIP
  glLineWidth(1);                        // Linie 1 Pixel breit.
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Rot
  glUniform1f(X_ID, ofs);                // rechts-
  glUniform1f(Y_ID, -ofs);               // unten
  glDrawArrays(GL_LINE_STRIP, 0, Length(Linies));

  // Zeichne GL_LINE_LOOP
  glLineWidth(6);                        // Linie 6 Pixel breit.
  glUniform3f(Color_ID, 0.0, 1.0, 0.0);  // Grün
  glUniform1f(X_ID, ofs);                // rechts-
  glUniform1f(Y_ID, ofs);                // oben
  glDrawArrays(GL_LINE_LOOP, 0, Length(Linies));

  // Zeichne GL_POINTS
  glPointSize(5);                        // Punkte Durchmesser 5 Pixel.
  glUniform3f(Color_ID, 0.0, 0.0, 1.0);  // Blau
  glUniform1f(X_ID, -ofs);               // links-
  glUniform1f(Y_ID, ofs);                // oben
  glDrawArrays(GL_POINTS, 0, Length(Linies));
```

<hr><br>
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

<hr><br>
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


