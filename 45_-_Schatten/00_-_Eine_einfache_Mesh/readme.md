<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>45 - Schatten</h1></b>
    <b><h2>00 - Eine einfache Mesh</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Wen man mehrere Objekte mit Alpha-Blending hat, ist es wichtig, das man zuerst die Objekte zeichnet, die am weitesten weg sind.<br>
Aus diesem Grund habe ich jeden Objekt eine eigene Matrix gegeben. Somit kann ich die Object anhand dieser Matrix sortieren, das sie später in richtiger Reihenfolge gezeichnet werden können.<br>
<hr><br>
Hier wird der Speicher für die Würfel angefordert.<br>
<pre><code>procedure TForm1.CreateScene;
const
  w = 1.0;</font>
var
  i: integer;
begin</pre></code>
Startpositionen der einzelnen Würfel definieren.<br>
<pre><code>procedure TForm1.InitScene;
begin
  CreateTree;
  CreateWand;
</pre></code>
Hier sieht man, das die Matrix der einzelnen Würfel berechnet werden, um sie anschliessend nach der Z-Tiefe zu sortieren.<br>
Nach dem Sortieren werden die Würfel in der richtigen Reihenfolge gezeichnet.<br>
Versuchsweise kann man die Sortierroutine ausklammern, dann sieht man sofort die fehlerhafte Darstellung.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
  Matrix: TMatrix;
begin

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  // --- Zeichne Schatten
  glBindFramebuffer(GL_FRAMEBUFFER, Shadow.FramebufferName);
  glClearColor(0.8, 0.8, 0.8, 1.0);</font>
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

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));</font>
  end;

  glBindFramebuffer(GL_FRAMEBUFFER, 0);</font>
  glClearColor(0.3, 0.3, 1.0, 1.0);</font>

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glViewport(0, 0, ClientWidth, ClientHeight);

  // --- Zeichne Baum
  with Tree do begin
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);

    Matrix :=ObjectMatrix;
    Matrix.Translate(0.5, 0.0, 0.0);</font>
    Matrix := FrustumMatrix * WorldMatrix * Matrix;
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));</font>
  end;

  // --- Zeichne Wall
  with Wall do begin
    Shader.UseProgram;
    glBindVertexArray(VB.VAO);
    //    Textur.ActiveAndBind;
    Shadow.Textur.ActiveAndBind;

    Matrix.Identity;

    Matrix.Translate(-1.5, 0.0, -0.3);</font>
    Matrix.RotateB(-pi / 2);</font>
    Matrix := FrustumMatrix * WorldMatrix * Matrix;
    Matrix.Uniform(Matrix_ID);

    glDrawArrays(GL_TRIANGLES, 0, Length(vec));</font>
  end;

  ogc.SwapBuffers;
end;</pre></code>
Den Speicher von den CubePos wieder frei geben.<br>
<pre><code>procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin</pre></code>
Gedreht wird nur der Baum.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
begin
  //    WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse
  Tree.ObjectMatrix.RotateC(0.0234);  // Drehe um Y-Achse</font>

  ogc.Invalidate;
end;
</pre></code>
<hr><br>
<b>Shader für Baum:</b><br>
<pre><code>$vertex
#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 11) in vec3 inCol; // Farbe</font>

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Frustum.

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);</font>
  Color = vec4(inCol, 1.0);</font>
}


$fragment
#version 330</font>

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor   = Color; // Die Ausgabe der Farbe
}
</pre></code>
<hr><br>
<b>Shader für Wand</b><br>
<pre><code>$vertex
#version 330</font>

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten</font>

uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}


$fragment
#version 330</font>

in vec2 UV0;

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
