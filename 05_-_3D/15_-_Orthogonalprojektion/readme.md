<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>05 - 3D</h1></b>
    <b><h2>15 - Orthogonalprojektion</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Eine OpenGL-Scene wird immer in einem Bereich von <b>-1</b> bis <b>+1</b> in allen drei Achsen gezeichnet. Ist etwas ausserhalb dieses Bereiches, wird dies ignoriert.<br>
Um dies zu umgehen multipliziert man die Scene mit einer Ortho-Matrix.<br>
Für diesen Zweck habe ich eine Funtkion <b>TMatrix.Ortho(...</b>. Mit den sechs Parametern in der Funktion, kann man den gewünschten Bereich einstellen.<br>
<br>
Zusätzlich ist noch eine Welt-Matrix hinzugekommen. Damit wird die ganze Scene in den sichtbaren Bereich bewegt,<br>
<hr><br>
Deklaration der drei Matrixen.<br>
<pre><code>var
  OrthoMatrix,         // Matrix für Ortho.
  WorldMatrix,         // Matrix für Welt.
  Matrix: TMatrix;     // Matrix, welche dem Shader übergeben wird.
  Matrix_ID: GLint;    // ID der Matrix für den Shader.</pre></code>
So sieht die Funktion aus: <b>Ortho(left, right, bottom, top, znear, zfar);</b>.<br>
Hier wird die OrthoMatrix erzeugt, und mit neuen Werten eingestellt.<br>
Im Beispiel ist dies eine Seitenlänge in allen Achsen um 24.0 (2 * 12.0).<br>
<br>
Die Skalierung der Welt-Matrix hat den Effekt, das die ganze Scene gezoomt wird.<br>
<pre><code>procedure TForm1.CreateScene;
const
  w = 12.0;  // Seiten-Länge</font>
begin
  Matrix.Identity;
  WorldMatrix.Identity;
  WorldMatrix.Scale(0.75);                    // Welt-Matrix zoomen
  OrthoMatrix.Ortho(-w, w, -w, +w, -w, +w);   // Den Ortho-Bereich einstellen.</pre></code>
Hier werden die einzelnen kleinen Würfel gezeichnet, dabei sieht man gut, wie alle drei Matrizen mutipliziert werden.<br>
Die Matrizen könnte man auch im Shader multiplizieren, dafür müsste man einfach für jede Matrix eine Uniform deklarieren.<br>
Dies hat aber den Nachteil, das die Multiplikation bei jedem Vektor ausgeführt wird, bei Meshes mit hoher Vektor-Zahl merkt man dies bemerklich.<br>
<br>
Hier sieht man auch gut, das man eine Mesh nach dem Binden mehrmals gezeichnet werden kann.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y, z: integer;
const
  d = 1.8;  // Abstand der Würfel.</font>
  s = 4;</font>
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);

  // --- Zeichne Würfel

  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.

        Matrix := OrthoMatrix * WorldMatrix * Matrix;          // Matrizen multiplizieren.

        Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
        glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.
      end;
    end;
  end;

  ogc.SwapBuffers;
end;</pre></code>
Kamera um die Mesh bewegen.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateA(0.0123);  // Drehe um X-Achse</font>
  WorldMatrix.RotateB(0.0234);  // Drehe um Y-Achse</font></pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 11) in vec3 inCol; // Farbe</font>

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Ortho

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);</font>
  Color = vec4(inCol, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
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
