# 06 - Alpha Blending
## 05 - Die Reihenfolge ist wichtig

![image.png](image.png)

Bei Polygonen, welche Alphablending enthalten, ist es wichtig, in welcher Reihenfolge sie gezeichnet werden.
Das blaue Quadrat ist in beiden Fällen über das Rote Qudrat gezeichnet.
Links wurde zuerst das rote Qudrat gezeichnet, Rechts ist es genau umgekehrt. Die Z-Position ist in beiden Fällen die gleiche.
Im rechten Beispiel ist die darstellung falsch, weil das rote Rechteck später gezeichnet wurde. Der Z-Puffer erkennt nicht ob es um transparente Polygone handelt.
Das man den Effekt noch stärker sieht, kann man den Alpha-Kanal auf **0.0** stellen.

Man sollte sich angewöhnen, zuerst immer die untransparenten Polygone zu zeichnen und die durchsichtigen erst später.
Auch sollte man berücksichtigen, das man zuerst die Elemente zeichnet, die von einem weiter weg sind.

Ich weis, dies tönt einfacher, als es in der Praxis ist.
Bei komplexen Szenen kommt man nicht um das sortieren der Meshes.

---
Für den Vertex-Puffer wird nur ein einfaches Quadrat gebraucht.
Die Farbe und Alpha-Kanal werden per Uniform dem Shader übergeben.

```pascal
type
  TFace3f = array[0..2] of TVector3f;

const
  QuadVector: array[0..1] of TFace3f =
    (((-0.3, -0.4, 0.0), (-0.3, 0.4, 0.0), (0.3, 0.4, 0.0)),
    ((-0.3, -0.4, 0.0), (0.3, 0.4, 0.0), (0.3, -0.4, 0.0)));
```

Bei einem einfachen Quadrat ist InitScene sehr einfach gehalten.

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);                  // Hintergrundfarbe

  glEnable(GL_BLEND);                                // Alphablending an
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // Sortierung der Primitiven von hinten nach vorne.

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  // --- Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);                     // 10 ist die Location in inPos Shader.
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
end;
```

Zeichnen der 4 Rechtecke.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  col: TVector4f;
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.
  Shader.UseProgram;
  MatrixTrans.Identity;

  glBindVertexArray(VBQuad.VAO);

  // --- Links ( Richtige Darstellung )
  // Rot
  col := vec4(1.0, 0.0, 0.0, 1.0);
  glUniform4fv(Color_ID, 1, @col);   // Als Vektor
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(-0.5, 0.2, 0.1);
  MatrixTrans.Uniform(MatrixRot_ID);                      // MatrixTrans in den Shader.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  MatrixTrans := TempMatrix;

  // blau transparent
  col := vec4(0.0, 0.0, 1.0, 0.3);
  glUniform4fv(Color_ID, 1, @col);   // Als Vektor
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(-0.4, -0.2, -0.1);
  MatrixTrans.Uniform(MatrixRot_ID);                      // MatrixTrans in den Shader.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  MatrixTrans := TempMatrix;


  // --- Rechts ( Falsche Darstellung )
  // blau transparent
  col := vec4(0.0, 0.0, 1.0, 0.3);
  glUniform4fv(Color_ID, 1, @col);   // Als Vektor
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(0.4, -0.2, -0.1);
  MatrixTrans.Uniform(MatrixRot_ID);                      // MatrixTrans in den Shader.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  MatrixTrans := TempMatrix;

  // Rot
  col := vec4(1.0, 0.0, 0.0, 1.0);
  glUniform4fv(Color_ID, 1, @col);   // Als Vektor
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(0.5, 0.2, 0.1);
  MatrixTrans.Uniform(MatrixRot_ID);                      // MatrixTrans in den Shader.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVector) * 3);
  MatrixTrans := TempMatrix;

  ogc.SwapBuffers;
end;
```


---
Die Shader sind sehr einfach gehalten. Es hat nur zwei Uniform für die Matrix und dem Color mit Alpha.

**Vertex-Shader:**

```glsl
#version 330

layout (location = 10) in vec3 inPos;    // Vertex-Koordinaten
uniform mat4 mat;                        // Matrix von Uniform

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);  // Vektoren mit der Matrix multiplizieren.
}

```


---
**Fragment-Shader:**

```glsl
#version 330

uniform vec4 Color;
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = Color;
}

```


