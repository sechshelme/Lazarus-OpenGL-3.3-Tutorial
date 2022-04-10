<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>50 - Instancing</h1></b>
    <b><h2>10 - Instance mit VertexAttribut</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier sind sogar 10'000'000 Instancen möglich, gegenüber der Uniform-Variante die bei gut 800 schon Schluss machte.<br>
Bei noch höheren Werten macht der FPC-Compiler Schluss, wieviel das die Grafikkarte vertägt, kann ich nicht sagen.<br>
Das es eine Diashow ist, das ist was anderes.<br>
<hr><br>
Die Anzahl Instance<br>
<pre><code>const
  InstanceCount = 10000;</font></pre></code>
Für die Instancen werden VBOs gebraucht.<br>
<pre><code>type
  TVB = record
    VAO: GLuint;
    VBO: record
      Vertex,
      I_Size, I_Matrix, I_Color: GLuint;
    end;
  end;</pre></code>
Die Deklaration, der Arrays ist gleich wie bei der Uniform-Übergaben.<br>
<pre><code>var
  VBQuad: TVB;

  Data: record
    Scale: array[0..InstanceCount - 1] of GLfloat;
    Matrix: array[0..InstanceCount - 1] of TMatrix;
    Color: array[0..InstanceCount - 1] of TVector3f;
  end;</pre></code>
VBO-Puffer für Instancen anlegen. Uniformen werden keine gebraucht.<br>
<pre><code>procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;

  glGenVertexArrays(1, @VBQuad.VAO);</font>

  glGenBuffers(4, @VBQuad.VBO);</font>

  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Scale[i] := Random * 2 + 1.0;</font>
    Data.Matrix[i].Identity;
    Data.Matrix[i].Translate(1.5 - Random * 3.0, 1.5 - Random * 3.0, 0.0);</font>
    Data.Color[i] := vec3(Random, Random, Random);
  end;
end;</pre></code>
Für die Instancen werden die Puffer gefüllt.<br>
Da für die Puffer nur Vektoren mit 1-4 Elemeten erlaubt sind, muss man die Matrix in 4 Vektoren unterteilen.<br>
Dabei werden auch 4 Attribut-Indexe gebraucht.<br>
Eine <b>glVertexAttribPointer(2, 16,...</b> geht leider nicht. Im Shader kann man es direkt als Matrix deklarieren.<br>
So was geht leider nicht:<br>
<pre><code>  glVertexAttribPointer(2, 16, GL_FLOAT, False, 0, nil);</pre></code>
Mit <b>glVertexAttribDivisor(...</b> teilt man mit das es sich um ein Instance-Attribut handelt.<br>
Der erste Parameter bestimmt, um welches Vertex-Attribut es sich handelt.<br>
Der Zweite sagt, das der Zeiger im Vertex-Attribut bei jedem Durchgang um <b>1</b> erhöt wird.<br>
Setzt man dort <b>0</b> ein, handelt es sich um ein gewöhnliches Attribut.<br>
Was Werte >1 bedeuten ist bei <b>VertexAttribDivisor</b> beschrieben.<br>
<pre><code>procedure TForm1.InitScene;
var
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  glBindVertexArray(VBQuad.VAO);

  // --- Normale Vektordaten
  // Daten für Vektoren
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // --- Instancen
  // Instance Size
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Size);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Scale), @Data.Scale, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);</font>
  glVertexAttribPointer(1, 1, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(1, 1);</font>

  // Instance Matrix
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Matrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Matrix), nil, GL_STATIC_DRAW); // Nur Speicher reservieren
  for i := 0 to 3 do begin</font>
    glEnableVertexAttribArray(i + 2);</font>
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, False, SizeOf(TMatrix), Pointer(i * 16));</font>
    glVertexAttribDivisor(i + 2, 1);</font>
  end;

  // Instance Color
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Color);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Color), @Data.Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(6);</font>
  glVertexAttribPointer(6, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(6, 1);</font>
end;</pre></code>
Die Instance Parameter werden einfache mit <b>glBufferSubData(....</b> übergeben.<br>
Es werden nur die Matrizen aktualisiert, die anderen Werte bleiben gleich.<br>
Will man eine andere Anzahl von Instance, dann muss man mit <b>glBufferData(...</b> mehr oder weniger Speicher reservieren.<br>
Dafür braucht man keine Uniformen.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Matrix);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(Data.Matrix), @Data.Matrix);

  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, InstanceCount);

  ogc.SwapBuffers;
end;</pre></code>
Matrizen neu berechnen.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Matrix[i].RotateC(0.02);</font>
  end;

  glBindVertexArray(VBQuad.VAO);
  ogcDrawScene(Sender);  // Neu zeichnen
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
Der Shader sieht sehr einfach aus.<br>
<pre><code>#version 330</font>

#define Instance_Count 200</font>

// Vektor-Daten
layout (location = 0) in vec2 inPos;</font>

// Instancen
layout (location = 1) in float Size;</font>
layout (location = 2) in mat4 mat;</font>
layout (location = 6) in vec3 Color;</font>

out vec3 col;

void main(void)
{
  gl_Position = mat * vec4((inPos * Size), 0.0, 1.0);</font>

  col = Color;
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
