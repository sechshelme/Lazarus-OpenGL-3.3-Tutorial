# 06 - Alpha Blending
## 20 - Alpha-Kanal abfragen und ingnorieren

![image.png](image.png)

Bei Texturen mit Alphablending gibt es noch eine einfacher Variante als sortieren.
Voraus gesetzt der Alphakanal ist voll transparent.

Wen es transparent ist, wird einfach kein Pixel gezeichnet und dadurch wird auch der Z-Buffer nicht aktualisiert.
Dies spielt sich im FragmentShader ab.
---
Es empfieht sich trotzdem immer die Objecte mit Alpha-Blending zum Schluss zu zeichnen.
Aber es muss nicht mehr sortiert werden.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);

var
  i: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);        // Frame und Tiefen-Puffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  // --- Zeichne Boden
  SandTextur.ActiveAndBind;                                   // Boden-Textur binden
  Matrix.Identity;
  Matrix.Translate(0.0, 1.0, 0.0);
  Matrix.Scale(10.0);
  Matrix.RotateA(Pi / 2);

  Matrix := FrustumMatrix * WorldMatrix * GroundPos * Matrix; // Matrizen multiplizieren.

  Matrix.Uniform(Matrix_ID);                                  // Matrix dem Shader übergeben.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));          // Zeichnet einen kleinen Würfel.

  // --- Zeichne Bäume
  BaumTextur.ActiveAndBind;                                   // Baum-Textur binden

  for i := 0 to TreeCount - 1 do begin
    Matrix.Identity;
    Matrix.Translate(TreePosArray[i]);                        // Die Bäume an die richtige Position bringen

    Matrix := FrustumMatrix * WorldMatrix * Matrix;           // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));
  end;

  ogc.SwapBuffers;
end;
```

---
<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location =  0) in vec3 inPos; // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;  // Textur-Koordinaten

out vec2 UV0;

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Frustum.

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);
  UV0         = inUV;                 // Textur-Koordinaten weiterleiten.
}

```

---
<b>Fragment-Shader</b>
Hier wird abgefragt, ob der Pixel transparent ist, wen ja wird er nicht ausgegeben und
dadurch wird der Z-Buffer nicht aktualisiert. Dadurch werden Objecte hinter der transparent Textur trozdem gezeichnet.

Da die Kanten der Baume nicht voll transparent sind, habe ich einen Mittelwert von 0.5 genommen.
Da muss man abschätzen, wie streng die Prüfung sein soll.

```glsl
#version 330

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
  vec4 c = texture( Sampler, UV0 );
  if (c.a &gt; 0.5) {
    FragColor =  c;
  } else {
    discard; // Wen transparent, Pixel nicht ausgeben.
  }
}

```


