<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>05 - 3D</h1></b>
    <b><h2>00 - Erster-Wuerfel</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Jetzt wird das erste mal 3D gerendert.<br>
Dafür wird ein einfacher Würfel genommen, welcher sechs unterschiedlich farbige Flächen hat.<br>
<br>
In diesem Beispiel wird bewusst noch auf den Tiefenbuffer verzichtet.<br>
Somit sieht man gut, was passiert wen man diesen nicht berücksichtigt.<br>
<hr><br>
Hier sind die Koordinaten und die Farben des Würfels deklariert.<br>
<pre><code>type
  TCube = array[0..11] of Tmat3x3;</font>

const
  CubeVertex: TCube = (
    ((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),</font>
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),</font>
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),</font>
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),</font>
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),</font>
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));</font>

  CubeColor: TCube = (
    ((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.0, 0.0)), ((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.0, 0.0)),</font>
    ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 1.0, 0.0)), ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 1.0, 0.0)),</font>
    ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0)), ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0)),</font>
    ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 1.0, 1.0)), ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 1.0, 1.0)),</font>
    // oben
    ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 1.0, 0.0)), ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 1.0, 0.0)),</font>
    // unten
    ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 1.0)), ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 1.0)));</font></pre></code>
Ohne Tiefenbuffer wird einfach alles gezeichnet, auch wen es verdeckt hinter einem anderen Object ist.<br>
Das man dies gut sieht, zeichne ich einen kleinen Würfel in den Grossen.<br>
Der Kleine übermahlt einfach den grossen.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
var
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Shader.UseProgram;

  // --- Zeichne Würfel

  glBindVertexArray(VBCube.VAO);

  WorldMatrix.Uniform(WorldMatrix_ID);                     // Matrix dem Shader übergeben
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3);   // Zeichne grossen Würfel

  TempMatrix := WorldMatrix;                               // Matrix sichern

  WorldMatrix.Scale(0.5);                                  // Matrix kleiner scalieren
  WorldMatrix.Uniform(WorldMatrix_ID);                     // Matrix dem Shader übergeben
  glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3);   // Zeichne kleinen Würfel

  WorldMatrix := TempMatrix;                               // Matrix laden

  ogc.SwapBuffers;
end;</pre></code>
Mit einem Timer wird der Würfel gedreht und neu gezeichnet.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse</font>
  WorldMatrix.RotateB(0.0234);  // Drehe um Y-Achse</font>

  ogc.Invalidate;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 11) in vec3 inCol; // Farbe</font>

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

uniform mat4 Matrix;                  // Matrix für die Drehbewegung

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);</font>
  Color = vec4(inCol, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in vec4 Color;      // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void)
{
  outColor = Color; // Die Ausgabe der Farbe
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
