# 05 - 3D
## 25 - Betrachtungs - Fenster (Viewport)

<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt hat sich die Scene im proportional des Ausgabe-fensters angepasst.
Das hat zu Folge, das ein Kreis ovalig wird, wen das Fenster nicht quadratisch ist.
Der Grund dafür ist, das die Ausgabe immer im Bereich von <b>-1.0</b> bis <b>+1.0</b> in der X und Y-Achse ist.

Um dies zu umgehen, wird bei jeder Grössenänderung des Fenster die Frustum-Matrix neu angepasst.
Entweder über <b>TMatrix.Frustum(...</b> oder noch einfacher wie im Beispiel mit <b>Matrix.Perspective(...</b> .
Dies geschieht im <b>OnResize</b>-Ereigniss von <b>TContext</b>.

Bei einer Orthogonalprojektion kann man dies mit <b>TMatrix.Ortho(...</b> anpassen.
<hr><br>
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

<hr><br>
<b>Vertex-Shader:</b>

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

<hr><br>
<b>Fragment-Shader</b>

```glsl
#version 330

in vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}

```


