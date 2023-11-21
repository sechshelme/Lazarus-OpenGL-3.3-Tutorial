# 05 - 3D
## 25 - Betrachtungs - Fenster (Viewport)

![image.png](image.png)

Bis jetzt hat sich die Scene im proportional des Ausgabe-fensters angepasst.
Das hat zu Folge, das ein Kreis ovalig wird, wen das Fenster nicht quadratisch ist.
Der Grund dafür ist, das die Ausgabe immer im Bereich von **-1.0** bis **+1.0** in der X und Y-Achse ist.

Um dies zu umgehen, wird bei jeder Grössenänderung des Fenster die Frustum-Matrix neu angepasst.
Entweder über **TMatrix.Frustum(...** oder noch einfacher wie im Beispiel mit **Matrix.Perspective(...** .
Dies geschieht im **OnResize**-Ereigniss von **TContext**.

Bei einer Orthogonalprojektion kann man dies mit **TMatrix.Ortho(...** anpassen.

---
Hier wird das OnResize-Ereigniss einer neuen Funktion zugeordnet.

```pascal
procedure TForm1.FormCreate(Sender: TObject);
begin
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;   // neues Ereigniss
```

Hier wird bei einer Grössenänderung des Fenster die Perspektive angepasst.
Dabei ist der zweite Parameter relevant.

```pascal
procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;
```


---
**Vertex-Shader:**

```glsl
#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
layout (location = 11) in vec3 inCol; // Farbe

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Frustum.

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

in vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}

```


