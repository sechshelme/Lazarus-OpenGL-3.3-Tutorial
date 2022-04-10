<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>50 - Instancing</h1></b>
    <b><h2>15 - Instancen nur in einer Array</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Vorher hatte es für jedes Instance-Attribut eine eigene Array gehabt.<br>
Jetzt sind alle Attribute in einer Array, dies macht den Code einiges übersichtlicher.<br>
Dafür ist die Übergabe mit <b>glVertexAttribPointer(...</b> ein wenig komplizierter.<br>
Siehe [[Lazarus - OpenGL 3.3 Tutorial - Vertex-Puffer - Nur eine Array]].<br>
<hr><br>
Die Deklaration der Array. Es ist nur noch eine Array.<br>
<pre><code>type
  TData = record
    Scale: GLfloat;
    Matrix: TMatrix;
    Color: TVector3f;
  end;

var
  Data: array[0..InstanceCount - 1] of TData;</pre></code>
Das es ein wenig einfacher wird, habe ich <b>ofs</b> verwendet.<br>
<pre><code>procedure TForm1.InitScene;
var
  ofs, i: integer;
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
  ofs := 0;</font>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data), @Data, GL_STATIC_DRAW);

  // Instance Size
  glEnableVertexAttribArray(1);</font>
  glVertexAttribPointer(1, 1, GL_FLOAT, False, SizeOf(TData), nil);
  glVertexAttribDivisor(1, 1);</font>
  Inc(ofs, SizeOf(GLfloat));

  // Instance Matrix
  for i := 0 to 3 do begin</font>
    glEnableVertexAttribArray(i + 2);</font>
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, False, SizeOf(TData), Pointer(ofs));
    glVertexAttribDivisor(i + 2, 1);</font>
    Inc(ofs, SizeOf(TVector4f));
  end;

  // Instance Color
  glEnableVertexAttribArray(6);</font>
  glVertexAttribPointer(6, 3, GL_FLOAT, False, SizeOf(TData), Pointer(ofs));
  glVertexAttribDivisor(6, 1);</font>
end;</pre></code>
An der Zeichenroutine ändert sich nichts.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(Data), @Data);

  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, InstanceCount);

  ogc.SwapBuffers;
end;</pre></code>
Matrizen neu berechnen.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data) - 1 do begin
    Data[i].Matrix.RotateC(0.02);</font>
  end;

  ogcDrawScene(Sender);  // Neu zeichnen
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
Am Shader hat sich nichts geändert.<br>
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
