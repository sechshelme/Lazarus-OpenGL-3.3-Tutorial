# 45 - Schatten
## 00 - Eine einfache Mesh

![image.png](image.png)

Wen man mehrere Objekte mit Alpha-Blending hat, ist es wichtig, das man zuerst die Objekte zeichnet, die am weitesten weg sind.
Aus diesem Grund habe ich jeden Objekt eine eigene Matrix gegeben. Somit kann ich die Object anhand dieser Matrix sortieren, das sie später in richtiger Reihenfolge gezeichnet werden können.
---
Hier wird der Speicher für die Würfel angefordert.

```pascal
procedure TForm1.CreateScene;
const
  w = 1.0;
var
  i: integer;
begin
```

Startpositionen der einzelnen Würfel definieren.

```pascal
procedure TForm1.InitScene;
begin
  CreateTree;
  CreateWand;

```

Hier sieht man, das die Matrix der einzelnen Würfel berechnet werden, um sie anschliessend nach der Z-Tiefe zu sortieren.
Nach dem Sortieren werden die Würfel in der richtigen Reihenfolge gezeichnet.
Versuchsweise kann man die Sortierroutine ausklammern, dann sieht man sofort die fehlerhafte Darstellung.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
  Matrix: TMatrix;
begin

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  // --- Zeichne Schatten
  glBindFramebuffer(GL_FRAMEBUFFER, Shadow.FramebufferName);
  glClearColor(0.8, 0.8, 0.8, 1.0);
  with Shadow do begin
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glViewport(0, 0, TexturSize, TexturSize);
  end;

  with Tree do begin
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);

//    Matrix.Identity;
//    Matrix.Multiply(ObjectMatrix, Matrix);
//    Matrix.Multiply(WorldMatrix, Matrix);
    Matrix := FrustumMatrix * WorldMatrix * ObjectMatrix;
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));
  end;

  glBindFramebuffer(GL_FRAMEBUFFER, 0);
  glClearColor(0.3, 0.3, 1.0, 1.0);

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glViewport(0, 0, ClientWidth, ClientHeight);

  // --- Zeichne Baum
  with Tree do begin
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);

    Matrix :=ObjectMatrix;
    Matrix.Translate(0.5, 0.0, 0.0);
    Matrix := FrustumMatrix * WorldMatrix * Matrix;
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));
  end;

  // --- Zeichne Wall
  with Wall do begin
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);
    //    Textur.ActiveAndBind;
    Shadow.Textur.ActiveAndBind;

    Matrix.Identity;

    Matrix.Translate(-1.5, 0.0, -0.3);
    Matrix.RotateB(-pi / 2);
    Matrix := FrustumMatrix * WorldMatrix * Matrix;
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));
  end;

  ogc.SwapBuffers;
end;
```

Den Speicher von den CubePos wieder frei geben.

```pascal
procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
```

Gedreht wird nur der Baum.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  //    WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse
  Tree.ObjectMatrix.RotateC(0.0234);  // Drehe um Y-Achse

  ogc.Invalidate;
end;

```

---
<b>Shader für Baum:</b>

```glsl
$vertex
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


$fragment
#version 330

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor   = Color; // Die Ausgabe der Farbe
}

```

---
<b>Shader für Wand</b>

```glsl
$vertex
#version 330

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten

uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}


$fragment
#version 330

in vec2 UV0;

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
}

```


