# 20 - Texturen
## 30 - Texturen und Matrixen

![image.png](image.png)

Die Textur-Koordinaten kann man im Shader auch mit einer Matrix multipizieren.
Dies geschieht ähnlich, wie bei den Vertex-Koordinanten, der grösste Unterschied dabei ist, das es sich um 2D-Koordinaten handelt.

Dabei ist zu beachten, das beim Drehen/Verschieben die Transformationen in umgekehrter Reihenfolge verläuft,
im Gegensatz zu Vertex-Koordinaten.

---
Das die Textur in der Mitte des Rechteckes dreht, muss sie um 0.5 verschoben werden.

```pascal
procedure TForm1.CreateScene;
begin
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(1.1);

  TexturRotMatrix.Identity;

  // Textur verschieben
  TexturTransMatrix.Identity;
  TexturTransMatrix.Translate(-0.5, -0.0);

  // Startwerte Texturtransformation
  with TexturTransform do begin
    scale := 1.0;
    direction := True;
  end;
```

Matrizen multiplizieren und den Shader übergeben.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  Matrix: TMatrix2D;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Textur.ActiveAndBind;
  Shader.UseProgram;

  ScaleMatrix.Uniform(Matrix_ID);  // Matrix für die Vektoren.

  // --- Texturmatrizen multiplizieren und übergeben.
  Matrix := TexturRotMatrix * TexturTransMatrix;
  Matrix.Uniform(texMatrix_ID);

  // --- Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));

  ogc.SwapBuffers;
end;
```

Berechnen der Matrix-Bewegungen.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
const
  sstep = 1.03;  // Schritt für Skalierung
  rstep = 0.01;  // Schritt für Rotation
  winkel: single = 0.0;

begin
  with TexturTransform do begin
    if direction then begin
      scale *= sstep;
      if scale > 15.0 then begin
        direction := False;
      end;
    end else begin
      scale /= sstep;
      if scale < 1.0 then begin
        direction := True;
      end;
    end;

    winkel := winkel + rstep;
    if winkel > 2 * pi then begin
      winkel := winkel - 2 * pi;
    end;

    // Matrix Skalieren und Rotieren.
    TexturRotMatrix.Identity;
    TexturRotMatrix.Scale(scale);
    TexturRotMatrix.Rotate(winkel);
  end;
  ogcDrawScene(Sender);
end;
```


---
Hier sieht man, wie die Texturkoordinaten anhand der Matrix manipuliert werden.

**Vertex-Shader:**

```glsl
#version 330

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten

uniform mat4 mat;
uniform mat3 texMat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);

  // Texturkoordinaten transformieren
  UV0 = (texMat * vec3(inUV, 1.0)).xy;
}

```


---
**Fragment-Shader:**

```glsl
#version 330

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );
}

```


