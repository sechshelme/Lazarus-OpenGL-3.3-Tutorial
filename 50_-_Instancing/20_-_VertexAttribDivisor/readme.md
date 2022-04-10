<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>50 - Instancing</h1></b>
    <b><h2>20 - VertexAttribDivisor</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit <b>VertexAttribDivisor</b> kann man nicht nur bestimmen, das es sich im ein Instance-Attribut handelt.<br>
Man kann auch festlegen, das ein Attribut-Wert mehrmals verwendet wird, bevor er um eins weiter springt.<br>
Im Beispiel sieht man, das der Farb-Wert vier mal verwendet wird, bevor der nächste wert kommt.<br>
<hr><br>
Für die Farben werden nur 4 Werte benötigt. Diese werden als Konstante deklariert,<br>
da diese sich zur Laufzeit nicht mehr ändern.<br>
<pre><code>const
  Quad: array[0..1] of TFace3D =</font>
    (((-0.8, -0.8, 0.0), (-0.8, 0.8, 0.0), (0.8, 0.8, 0.0)),</font>
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));</font>

  Instance_Color: array[0..3] of TVector3f =</font>
    ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0));</pre></code>
Rechtecke gibt es 16 Stück, die Matrizen dafür sind dynamisch.<br>
<pre><code>var
  Instance_Matrix: array[0..15] of TMatrix;</font></pre></code>
Mit <b>glVertexAttribDivisor(...</b> kann man nicht nur bestimmen, das es sich um ein Instance-Attribut handelt.<br>
Sondern man kann auch sagen wie viel mal ein Attribut-Wert verwendet wird.<br>
Dies geschieht mit dem zweiten Parameter.<br>
<pre><code>procedure TForm1.InitScene;
var
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.Pos);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(0, 0);</font>

  // Instance Color
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iColor);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Instance_Color), @Instance_Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);</font>
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(1, 4); // Wert 4x verwenden.</font>

  // Instance Matrix
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iMatrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(TMatrix) * Length(Instance_Matrix), nil, GL_STATIC_DRAW);
  for i := 0 to 3 do begin</font>
    glEnableVertexAttribArray(i + 2);</font>
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, False, SizeOf(TMatrix), Pointer(i * 16));</font>
    glVertexAttribDivisor(i + 2, 1); // Wert 1x verwenden.</font>
  end;
end;</pre></code>
Matrizen drehen und anschliessend, neu laden.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  r: GLfloat = 0.0;</font>
var
  i: integer;
begin
  r += 0.01;</font>
  if r > 2 * pi then begin</font>
    r -= 2 * pi;</font>
  end;

  for i := 0 to 15 do begin</font>
    Instance_Matrix[i].Identity;
    Instance_Matrix[i].Scale(0.25, 0.05, 1.0);</font>
    Instance_Matrix[i].RotateC(Pi * 2 / 16 * i + r);</font>
    Instance_Matrix[i].TranslateLocalspace(2.0, 0.0, 0.0);</font>
  end;

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iMatrix);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(TMatrix) * Length(Instance_Matrix), @Instance_Matrix);

  ogc.Invalidate;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 position;</font>
layout (location = 1) in vec3 instance_color;
layout (location = 2) in mat4 instance_Matrix;

out vec4 Color;

void main(void) {
  gl_Position = instance_Matrix * vec4(position, 1.0);</font>
  Color       = vec4(instance_color, 1.0);</font>
}

</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in  vec4 Color;      // interpolierte Farbe vom Vertexshader
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
