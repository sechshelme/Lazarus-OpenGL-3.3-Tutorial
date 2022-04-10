<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>50 - Instancing</h1></b>
    <b><h2>05 - Instance mit Uniform</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann für jede Instance einen eigenen Uniform-Wert zu ordnen. Dafür packt man die Uniform-Werte in ein Array,<br>
welches >= anzahl Instancen ist.<br>
<br>
Dieses Verfahren hat zwei Nachteile.<br>
1. Man muss die Anzahl Intancen von Anfang an wissen.<br>
2. Die Anzahl Uniform-Werte ist begrenzt, bei diesem Beispiel und einem Intel4000 ist bei gut 800 Instancen Schluss.<br>
<br>
Diese Nachteile kann man umgehen, wen man anstelle von Uniformen VertexAttrib verwendet, dazu im nächasten Thema.<br>
<hr><br>
Die Anzahl Instance<br>
<pre><code>const
  InstanceCount = 200;</font></pre></code>
Die Deklaration, der Paramter für die einzelnen Instancen.<br>
Die Size könnte man mit der Matrix kombinieren, aber hier geht es um die Funktionsweise der Uniform-Übergaben.<br>
<pre><code>var
  Matrix_ID, Color_ID, Size_ID: GLint;

  VBQuad: TVB;

  Data: record
    Size: array[0..InstanceCount - 1] of GLfloat;
    Matrix: array[0..InstanceCount - 1] of TMatrix;
    Color: array[0..InstanceCount - 1] of TVector3f;
  end;</pre></code>
Das Auslesen der UniformID. Dies geschieht gleich wie bei einfachen Uniformen.<br>
Die Instancen-Parameter mit zufälligen Werten belegen.<br>
<pre><code>procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;
  Size_ID := Shader.UniformLocation('Size');</font>
  Matrix_ID := Shader.UniformLocation('mat');</font>
  Color_ID := Shader.UniformLocation('Color');</font>

  glGenVertexArrays(1, @VBQuad.VAO);</font>

  glGenBuffers(1, @VBQuad.VBO);</font>

  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Size[i] := Random() * 20 + 1.0;</font>
    Data.Matrix[i].Identity;
    Data.Matrix[i].Translate(1.5 - Random * 3.0, 1.5- Random * 3.0, 0.0);</font>
    Data.Color[i] := vec3(Random, Random, Random);
  end;
end;</pre></code>
Die Übergabe der Uniform-Werte. Da es sich um Arrays handelt, muss man noch die Länge der Array übergeben.<br>
Auch sieht man gut, das mal <b>glDrawArraysInstanced(...</b> nur einmal aufrufen muss.<br>
Würde man dies ohne Instancen lössen, müsste man die Uniformübergabe und glDraw... 200x aufrufen.<br>
Da sieht man den Vorteil, es ist viel weniger Kominikation mit der Grafikkarte nötig.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  glUniform1fv(Size_ID, InstanceCount, @Data.Size);
  glUniformMatrix4fv(Matrix_ID, InstanceCount, False, @Data.Matrix);
  glUniform3fv(Color_ID, InstanceCount, @Data.Color);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, InstanceCount);

  ogc.SwapBuffers;
end;</pre></code>
Die Matrizen drehen.<br>
Dies muss man 200x machen, aber es sind nicht 200 Übergaben zur Grafikkarte nötig.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Matrix[i].RotateC(0.02);</font>
  end;

  ogcDrawScene(Sender);  // Neu zeichnen
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
Hier sieht man, das mit <b>gl_InstanceID</b> auf die eizelnen Array-Elemente zugegriffen wird.<br>
<pre><code>#version 330</font>

#define Instance_Count 200</font>

layout (location = 0) in vec2 inPos;</font>

uniform float Size[Instance_Count];
uniform mat4 mat[Instance_Count];
uniform vec3 Color[Instance_Count];

out vec3 col;

void main(void)
{
  gl_Position = mat[gl_InstanceID] * vec4((inPos * Size[gl_InstanceID]), 0.0, 1.0);</font>

  col = Color[gl_InstanceID];
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

out vec4 outColor;   // ausgegebene Farbe

in vec3 col;

void main(void)
{
  outColor = vec4(col, 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
