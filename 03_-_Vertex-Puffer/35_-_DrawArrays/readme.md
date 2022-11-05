# 03 - Vertex-Puffer
## 35 - DrawArrays

![image.png](image.png)

Mit ** glDrawArrays(...** muss man nicht die ganze Meshes auf einmal zeichnen, man kann auch nur ein Teil davon zeichnen.
Hier im Beispiel, wir das Quadrat in zwei Teilen gezeichnet, so hat man die Möglichkeit zwischendurch zB. die Farbe zu ändern.

---
Hier wird das Qudarat in zwei Teilen gezeichnet und zwischendurch die Uniform-Variable Color geändert.
Dafür gibt es in **glDrawArrays(...** zwei Parameter.
Der Zweite gibt das Offset der Vertex-Array an, und der Dritte, wie viele Vertex-Daten.
Das erste Polygon, fängt bei 0 und ist 3 Vertex lang.
Das zweite Polygon fängt bei 3 an und ist auch 3 Vertex lang.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glUniform3f(Color_ID, 0.0, 0.0, 1.0);
  glDrawArrays(GL_TRIANGLES, 0, 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Farbe ändern
  glDrawArrays(GL_TRIANGLES, 0, 3);      // zweites Polygon
  glUniform3f(Color_ID, 1.0, 0.0, 1.0);  // Farbe ändern
  glDrawArrays(GL_TRIANGLES, 3, 3);      // zweites Polygon

  ogc.SwapBuffers;
end;
```


---
**Vertex-Shader:**

```glsl
#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
 
void main(void)
{
  gl_Position = vec4(inPos, 1.0);
}

```


---
**Fragment-Shader:**

```glsl
#version 330

uniform vec3 Color;  // Farbe von Uniform
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Color, 1.0); // Das 1.0 ist der Alpha-Kanal, hat hier keine Bedeutung.
}

```


