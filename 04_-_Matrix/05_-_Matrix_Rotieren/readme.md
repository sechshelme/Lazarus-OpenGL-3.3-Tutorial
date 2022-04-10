<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>04 - Matrix</h1></b>
    <b><h2>05 - Matrix Rotieren</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird eine <b>4x4 Matrix</b> verwendet, dies ist Standard bei allen Mesh Translationen.<br>
Im Timer wird eine Matrix-Rotation ausgeführt.<br>
Für diese einfache Roatation, könnte man auch eine <b>2x2-Matrix</b> nehmen, aber sobald man die Mesh auch verschieben will, braucht man <b>4x4-Matrix</b>, auch wird es sonst komplizierter im Shader.<br>
<hr><br>
Hier wird ein Matrix4x4-Typ deklariert.<br>
Für die Manipulationen einer Matrix eignet sich hervorragend ein <b>Type Helper</b>.<br>
<pre><code>type
  TMatrix = array[0..3, 0..3] of GLfloat;</font>

  TMatrixfHelper = Type Helper for TMatrix
    procedure Indenty;                  // Generiere eine Einheitsmatrix
    procedure Rotate(angele: single);   // Drehe Matrix
  end;</pre></code>
Die Matrix selbst, die rotiert wird.<br>
Und die ID für den Shader.<br>
<pre><code>var
  MatrixRot: TMatrix;     // Matrix
  MatrixRot_ID: GLint;    // ID für Matrix.</pre></code>
Hier wird eine Einheits-Matrix erzeugt, bei einer 4x4-Matrix, sieht dies so aus:<br>
<br>
//matrix+<br>
| 1 | 0 | 0 | 0 |<br>
| 0 | 1 | 0 | 0 |<br>
| 0 | 0 | 1 | 0 |<br>
| 0 | 0 | 0 | 1 |<br>
//matrix-<br>
<pre><code>procedure TMatrixfHelper.Indenty;
const
  MatrixIndenty: TMatrix = ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));</font>
begin
  Self := MatrixIndenty;
end;</pre></code>
Mit dieser Procedure, wird die Matrix um die Z-Achse rotiert.<br>
Der Winkel wird im <b>Bogenmass</b> angegeben.<br>
Für nicht Mathematiker, <b>360°</b> sind <b>2⋅π</b> ( 2⋅Pi ).<br>
<pre><code>procedure TMatrixfHelper.Rotate(angele: single);
var
  i: integer;
  x, y: GLfloat;
begin
  for i := 0 to 1 do begin</font>
    x := Self[i, 0];</font>
    y := Self[i, 1];</font>
    Self[i, 0] := x * cos(angele) - y * sin(angele);
    Self[i, 1] := x * sin(angele) + y * cos(angele);
  end;
end;
</pre></code>
In diesem Code sind zwei Zeilen relevant, eine mit <b>UniformLocation</b> für die Matrix-ID.<br>
In der anderen wird die Matrix, die gedreht wird, erst mal als Einheits-Matrix gesetzt.<br>
Dies ist wichtig, ansonsten sieht man keine Mesh mehr, da diese unendlich klein skaliert wird.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');</font>
  MatrixRot_ID := Shader.UniformLocation('mat'); // Ermittelt die ID von MatrixRot.</font>
  MatrixRot.Indenty;                             // MatrixRot auf Einheits-Matrix setzen.</pre></code>
Hier wird die Uniform-Variable <b>MatrixRot</b> dem Shader übergeben.<br>
Mit <b>glUniform4fv(...</b> kann man eine <b>4x4 Matrix</b> dem Shader übergeben.<br>
Für eine 2x2 Matrix wäre dies <b>glUniform2fv(...</b> und für die 3x3 <b>glUniform3fv(...</b>.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glUniformMatrix4fv(MatrixRot_ID, 1, False, @MatrixRot); // MatrixRot in den Shader.</font></pre></code>
Die Drehung der Matrix wird fortlaufend um den Wert <b>step</b> gedreht.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;          // Der Winkel ist im Bogenmass.</font>
begin
  MatrixRot.Rotate(step);        // MatrixRot rotieren.
  ogcDrawScene(Sender);          // Neu zeichnen.
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Hier ist die Uniform-Variable <b>mat</b> hinzugekommen, dies ist auch eine 4x4-Matrix, so wie im Haupt-Programm.<br>
Diese wird im Vertex-Shader deklariert, Bewegungen kommen immer in diesen Shader.<br>
<br>
Man sieht dort auch gut, das die <b>Vektoren</b> mit dieser <b>Matrix</b> multipliziert werden.<br>
Da diese Multiplikation im Shader ist, wird die Berechnung in der <b>GPU</b> ausgeführt, und somit wird die <b>CPU</b> entlastet.<br>
Aus diesem Grund haben Gaming-Grafikkarten solch eine grosse Leistung.<br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos;    // Vertex-Koordinaten</font>
uniform mat4 mat;                        // Matrix von Uniform

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);  // Vektoren mit der Matrix multiplizieren.</font>
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
