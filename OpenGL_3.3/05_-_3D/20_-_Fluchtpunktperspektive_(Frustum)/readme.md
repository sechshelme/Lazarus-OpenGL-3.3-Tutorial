# 05 - 3D
## 20 - Fluchtpunktperspektive (Frustum)

![image.png](image.png)

Will man die Scene realistisch proportional darstellen, nimmt man eine Frustum-Matrix.
Dies hat den Einfluss, das Objekte kleiner erscheinen, je weiter die Scene von einem weg ist.
In der Realität ist dies auch so, das Objekte kleiner erscheinen, je weiter sie von einem weg sind.

---
Der Frustum funktioniert ähnlich wie beim Ortho.
Nur die Parameter sind ein wenig anders.
Die Z-Werte müssen immer **positiv** sein.

Mit den zwei letzten Parametern von Frustum und der World-Matrix muss man ein bisschen probieren, zum Teil wird sonst das Bild verzehrt.

Alternativ kann man den Frustum auch mit **Perspective(...** einstellen.
Dabei ist der erste Parameter der Betrachtungs-Winkel.
Der zweite Parameter ist das Fensterverhältniss, mehr dazu und glViewPort.

```pascal
procedure TForm1.CreateScene;
const
  w = 1.0;
begin
  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);
//   FrustumMatrix.Perspective(45, 1.0, 2.5, 1000.0); // Alternativ

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.
  WorldMatrix.Scale(5.0);                  // Und der Grösse anpassen.
```

Das Zeichnen ist das Selbe wie bei Ortho.

```pascal
  // --- Zeichne Würfel

  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.

        Matrix := FrustumMatrix * WorldMatrix * Matrix;        // Matrizen multiplizieren.

        Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
        glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.
      end;
    end;
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

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}

```


