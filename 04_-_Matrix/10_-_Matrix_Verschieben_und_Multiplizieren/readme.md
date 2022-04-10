<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>04 - Matrix</h1></b>
    <b><h2>10 - Matrix Verschieben und Multiplizieren</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird die Mesh verschoben, und anschliessend gedreht.<br>
<br>
Dazu werden zwei 4x4 Matrixen verwendet, eine für das Verschieben und die andere für die Drehung.<br>
Eine dritte Matrix ist noch für das Produkt von den zweit Matrixen, welche dann am Shader übergeben wird.<br>
Im Timer wird Matrix-Rotation ausgeführt.<br>
<br>
Für Matrixen, wird ab jetzt ein Type Helper aus der Unit <b>OpenGLMatrix</b> verwendent, dies macht das Ganze übersichtlicher.<br>
Dafür muss einfach die Unit <b>oglMatrix</b> bei uses eingebunden werden.<br>
In der Regel muss dann die Matrix mit <b>TMatrix.Indenty</b> auf die Einheits-Matrix gesetzt werden.<br>
<hr><br>
Die Deklaration der drei Matrixen.<br>
Und die ID für den Shader. Die ID wird nur eine gebraucht, da nur das Produkt dem Shader übergeben wird.<br>
<pre><code>var
  RotMatrix, TransMatrix, prodMatrix: TMatrix;   // Matrizen von der Unit oglMatrix.
  Matrix_ID: GLint;                              // ID für Matrix.</pre></code>
Hier werden die drei Matrixen auf die gesetzt.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');</font>
  Matrix_ID := Shader.UniformLocation('mat');</font>
  RotMatrix.Identity;                   // Zuerst ist eine Einheitsmatrix erwünscht.
  TransMatrix.Identity;
  prodMatrix.Identity;
  TransMatrix.Translate(0.5, 0.0, 0.0); // TransMatrix um 0.5 nach links verschieben.</font></pre></code>
Hier wird das Produkt von TransMatrix und RotMatrix den Shader übergeben.<br>
Mit der Klasse geht dies einfacht mit <b>Matrix.Uniform(ID)</b><br>
<br>
Matrizen multiplizieren geht am einfachsten mit der überladenen Multiplikation-Funktion.<br>
<pre><code>Matrix := Matrix * Matrix;
Matrix := Matrix * Matrix * Matrix;</pre></code>
Dabei wird die Mesh zuerst gedreht und dann verschoben.<br>
<b>Die Reihenfolge der Multiplikatoren ist sehr wichtig !</b><br>
<br>
Einfach mal TransMatrix und RotMatrix vertauschen, dann sieht man ganz ein anderes Ergebniss.<br>
Dann wird zuerst die Mesh verschoben und dann das Ganze um den Mittelpunkt gedreht.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  prodMatrix := TransMatrix * RotMatrix;       // Matrix multiplizieren.
  prodMatrix.Uniform(Matrix_ID);               // prodMatrix in den Shader schreiben.</pre></code>
Die Drehung der Matrix wird fortlaufend um den Wert <b>step</b> gedreht.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;</font>
begin
  RotMatrix.RotateC(step); // RotMatrix rotieren
  ogcDrawScene(Sender);    // Neu zeichnen
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Hier ist die Uniform-Variable <b>mat</b> hinzugekommen.<br>
Diese wird im Vertex-Shader deklariert, Bewegungen kommen immer in diesen Shader.<br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
uniform mat4 mat;                     // Matrix von Uniform

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

uniform vec3 Color;  // Farbe von Uniform
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Color, 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
