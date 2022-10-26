# 05 - 3D
## 05 - Polygon - Seite (Backface Culling)

![image.png](image.png)

Die Meshes ist hier noch 2D, aber <b>Backface Culling</b> wird in folgenden 3D-Beispielen gebraucht.

Defaultmässig zeichnet OpenGL immer die Vorder und Rückseite eines Polygones. Für die meisten Meshes ist dies aber nicht nötig.
Bei einem Würfel ist es nicht nötig, das die Innenseite der Polygone gezeichnet werden, da man diese sowieso nicht sieht.
Dies spart Rechneleistung, weil jede Pixelüberprüfung Zeit kostet.
Mit <b>glEnable(GL_CULL_FACE);</b> wird nur die Vorderseite der Polygone gezeichnet. Ausgenommen man schaltet es mit <b>glCullFace(...</b> um, so das nur die Rückseite gezeichnet wird.

In diesem Beispiel, wird dies mit einem Timer demonstriert.

Was dabei wichtig ist, die Polygone müssen immer im Gegenuhrzeigersinn gerendert werden. Auch dies könnte man <b>glFrontFace(...</b> umstellen.
Dafür gibt es die Parameter <b>GL_CW</b> für Uhrzeigersinn, und den Default-Parameter <b>GL_CCW</b>.
---
Wen man die Konstanten genau anschaut, sieht man, das das Dreieck im Gegenuhrzegersinn und das Qaudrat im Uhrzeigersinn deklariert ist.

```pascal
const
  // Dreieck
  Triangle: array[0..0] of TFace =
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));

  // Quadrat
  Quad: array[0..1] of TFace =
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));
```

Hier wird die Backface Culling aktiviert:

```pascal
procedure TForm1.InitScene;
begin
  glEnable(GL_CULL_FACE);           // Überprüfung einschalten
```

Hier wird zwischen der Rück und Vorder-Seite umgesschalten.
Man sagt immer, welche Seite nicht gezeichnet wird.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
const
  CullFace: boolean = False;
begin
  if CullFace then begin
    glCullFace(GL_BACK);      // Rückseite nicht zeichnen.
  end else begin
    glCullFace(GL_FRONT);     // Vorderseite nicht zeichnen.
  end;
  CullFace := not CullFace;
  ogc.Invalidate;
end;
```

---
<b>Vertex-Shader:</b>


```glsl
#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten

void main(void)
{
  gl_Position = vec4(inPos, 1.0);
}

```

---
<b>Fragment-Shader:</b>

```glsl
#version 330

out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  vec3 col = vec3(1.0, 0.0, 0.0);
  outColor = vec4(col, 1.0);
}

```


