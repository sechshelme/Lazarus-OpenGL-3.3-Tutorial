# 55 - Diverses
## 05 - ColorMask

![e image.png](e image.png)

Man kann das Zeichen von gewissen Farben aktivieren / deaktivieren

---

```pascal
  glGenBuffers(1, @VBTriangle.VBOvert);
  glGenBuffers(1, @VBTriangle.VBOcol);
  glGenBuffers(1, @VBQuad.VBOvert);
  glGenBuffers(1, @VBQuad.VBOcol);
```

Hintergrund schwar, das man den Effekt bessser sieht.

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.0, 0.0, 0.0, 1.0); // schwarz
```

Für den Hintergrund alle Farben.
Für die Mesh je nach Menü-Stellung.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glColorMask(True, True, True, True);  // Alle Farben
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;
  glColorMask(   // Je nach Menü
    RedMenuItem.Checked,
    GreenMenuItem.Checked,
    BlueMenuItem.Checked, True);

  // Zeichne Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(TriangleVector) * 3);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);

  ogc.SwapBuffers;
end;
```


---
**Vertex-Shader:**

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


