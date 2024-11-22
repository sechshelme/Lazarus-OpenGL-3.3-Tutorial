# 05 - 3D
## 10 - Tiefenbuffer

![image.png](image.png)

Einen Tiefenpuffer braucht man, das Polygone nicht einfach willkürlich übereinander gezeichnet werden.
Mit dem Tiefenpuffer wird berechnet, das ein Polygon das sich hinter einem anderen befindet, nicht gezeichnet wird.
Diese Berechnung läuft auf Pixelebene.

Bei dem Würfelbeispiel, wird der kleine Würfel nicht mehr gezeichnet, da sich dieser hinter den Flächen des grossen Würfels befindet.

---
Hier wird den Tiefenpufferprüfung eingeschaltet, dies geschieht mit **glEnable(GL_DEPTH_TEST);**.
Die Art der Prüfung kann man mit **glDepthFunc(...** einstellen, wobei Default auf **GL_LESS** ist.
Mit **GL_LESS** wird geprüft, ob der Z-Wert geringer ist, und wen ja, darf der Pixel gezeichnet werden.


```pascal
procedure TForm1.CreateScene;
begin
  glEnable(GL_DEPTH_TEST);  // Tiefenprüfung einschalten.
  glDepthFunc(GL_LESS);     // Kann man weglassen, da Default.
```

Bei **glClear(...** ist noch etwas neues dazugekommen, **GL_DEPTH_BUFFER_BIT**.
Dies bewirkt, das bei **glClear(...** nicht nur der Frame-Puffer gelöscht wird, sondern auch der Tiefen-Puffer.
Jetzt darf der kleine Würfel nicht mehr sichtbar sein, da sich dieser hinter dem grossen versteckt.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Puffer löschen.

  Shader.UseProgram;

  // --- Zeichne Würfel

  glBindVertexArray(VBCube.VAO);

  WorldMatrix.Uniform(WorldMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3);

  TempMatrix := WorldMatrix;

  WorldMatrix.Scale(0.5);
  WorldMatrix.Uniform(WorldMatrix_ID);
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // wird nicht gezeichnet.

  WorldMatrix := TempMatrix;

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

uniform mat4 Matrix;                  // Matrix für die Drehbewegung

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  Color = vec4(inCol, 1.0);
}

```


---
**Fragment-Shader**

```glsl
#version 330

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}

```


