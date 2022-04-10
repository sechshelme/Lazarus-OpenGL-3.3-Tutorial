<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>35 - Geometrie-Shader</h1></b>
    <b><h2>00 - Breite Linien</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Dieses Beispiel zeigt, wie sich Textur-Koordinaten auf die Textur auswirken.<br>
Bei der linken Textur, entsprechen die Textur-Koordinaten, denen der Vektoren, dies gibt ein Matrix ähnliches Muster, ausser das sie skaliert wird.<br>
Rechts ist jede Koordinate von 0.0-1.0, somit wird die Textur um die Scheibe gezogen. Jedes Rechteck enthält die ganze Textur.<br>
<hr><br>
Hier sieht man gut, das die Textur-Koordinaten verschieden Werte bekommen.<br>
<pre><code>procedure TForm1.CalcCircle;
const
  Sektoren = 7;</font>
  maxSek = Sektoren * 8;</font>
  r = 1.6 / maxSek;</font>
var
  i: integer;
begin
  SetLength(Linies, maxSek);
  SetLength(Linies_Prev, maxSek);
  SetLength(Linies_Next, maxSek);
  for i := 0 to maxSek - 1 do begin
    Linies[i, 0] := sin(Pi * 2 / Sektoren * i) * r * i;
    Linies[i, 1] := cos(Pi * 2 / Sektoren * i) * r * i;
  end;

  Linies_Prev[0] := vec2(0.0, 0.0);</font>
  for i := 1 to maxSek - 1 do begin
    Linies_Prev[i] := Linies[i - 1];</font>
  end;

  Linies_Next[maxSek - 1] := vec2(0.0, 0.0);</font>
  for i := 0 to maxSek - 1 - 1 do begin
    Linies_Next[i] := Linies[i + 1];</font>
  end;

end;</pre></code>
Vertex-Koordianten bekommen beide Meshes die gleichen, aber die Textur-Koordinaten weichen ab.<br>
<pre><code>procedure TForm1.InitScene;
begin
  TextureBuffer.ActiveAndBind;
  glClearColor(0.6, 0.6, 0.4, 1.0);</font>

  // Ring Links
  glBindVertexArray(VBRingL.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Prev);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies_Prev), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);</font>
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBO.Next);
  glBufferData(GL_ARRAY_BUFFER, Length(Linies) * SizeOf(TVector2f), Pointer(Linies_Next), GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);</font>
  glVertexAttribPointer(2, 2, GL_FLOAT, False, 0, nil);
end;</pre></code>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
var
  TempMatrix: TMatrix;
begin
  glClear(GL_COLOR_BUFFER_BIT);

  TextureBuffer.ActiveAndBind;

  Shader.UseProgram;

  ProdMatrix := ScaleMatrix * RotMatrix;

  // Zeichne linke Scheibe
  TempMatrix := ProdMatrix;
  //  ProdMatrix.Translate(-0.5, 0.0, 0.0);
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix := TempMatrix;

  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_LINE_STRIP, 0, Length(Linies) div 2);

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec2 inPos;</font>
layout (location = 1) in vec2 inPrev;</font>
layout (location = 2) in vec2 inNext;</font>

uniform mat4 mat;

out vec2 Prev;
out vec2 Next;

void main(void)
{
//  Prev = inPrev;
///  Next = inNext;

  Prev = (mat * vec4(inPrev, 0.0, 1.0)).xy;</font>
  Next = (mat * vec4(inNext, 0.0, 1.0)).xy;</font>

  gl_Position = mat * vec4(inPos, 0.0, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

in vec3 Color;

out vec4 FragColor;

void main()
{
//  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
  FragColor = vec4(Color, 1.0);</font>
}
</pre></code>
<hr><br>
<b>muster.xpm:</b><br>
<pre><code>/* XPM */
static char *XPM_mauer[] = {
  "8 8 3 1",</font>
  "  c #882222",</font>
  "* c #442222",</font>
  "+ c #4422BB",</font>
  "        ",
  " ****** ",
  " *    * ",
  " * ++ * ",
  " * ++ * ",
  " *    * ",
  " ****** ",
  "        "
};
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
