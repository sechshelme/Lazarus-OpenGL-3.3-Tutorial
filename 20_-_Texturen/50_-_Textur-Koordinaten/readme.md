<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>50 - Textur-Koordinaten</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Dieses Beispiel zeigt, wie sich Textur-Koordinaten auf die Textur auswirken.<br>
Bei der linken Textur, entsprechen die Textur-Koordinaten, denen der Vektoren, dies gibt ein Matrix ähnliches Muster, ausser das sie skaliert wird.<br>
Rechts ist jede Koordinate von 0.0-1.0, somit wird die Textur um die Scheibe gezogen. Jedes Rechteck enthält die ganze Textur.<br>
<hr><br>
Hier sieht man gut, das die Textur-Koordinaten verschieden Werte bekommen.<br>
<pre><code>procedure TForm1.CalcCircle;
const
  TextureVertex: array[0..5] of TVector2f =    // Textur-Koordinaten
    ((0.0, 0.0), (1.0, 1.0), (0.0, 1.0),</font>
    (0.0, 0.0), (1.0, 0.0), (1.0, 1.0));</font>

  Sektoren = 16;</font>
  r0 = 0.5;</font>
  r1 = 1.0;</font>
var
  i: integer;
  w0, w1: single;

begin
  SetLength(Disc, Sektoren * 3 * 2);</font>

  for i := 0 to Sektoren - 1 do begin
    w0 := pi * 2 / Sektoren * (i + 0);</font>
    w1 := pi * 2 / Sektoren * (i + 1);</font>

    // 1. Dreieck

    Disc[i * 2 * 3 + 0].Vertex := vec3(sin(w0) * r0, cos(w0) * r0, 0.0);</font>
    Disc[i * 2 * 3 + 1].Vertex := vec3(sin(w0) * r1, cos(w0) * r1, 0.0);</font>
    Disc[i * 2 * 3 + 2].Vertex := vec3(sin(w1) * r1, cos(w1) * r1, 0.0);</font>

    Disc[i * 2 * 3 + 0].TexkoorL := Disc[i * 2 * 3 + 0].Vertex.xy;</font>
    Disc[i * 2 * 3 + 0].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 1].TexkoorL := Disc[i * 2 * 3 + 1].Vertex.xy;</font>
    Disc[i * 2 * 3 + 1].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 2].TexkoorL := Disc[i * 2 * 3 + 2].Vertex.xy;</font>
    Disc[i * 2 * 3 + 2].TexkoorL.scale(5.0);

    Disc[i * 2 * 3 + 0].TexkoorR := TextureVertex[3];</font>
    Disc[i * 2 * 3 + 1].TexkoorR := TextureVertex[4];</font>
    Disc[i * 2 * 3 + 2].TexkoorR := TextureVertex[5];</font>

    // 2. Dreieck

    Disc[i * 2 * 3 + 3].Vertex := vec3(sin(w0) * r0, cos(w0) * r0, 0.0);</font>
    Disc[i * 2 * 3 + 4].Vertex := vec3(sin(w1) * r1, cos(w1) * r1, 0.0);</font>
    Disc[i * 2 * 3 + 5].Vertex := vec3(sin(w1) * r0, cos(w1) * r0, 0.0);</font>

    Disc[i * 2 * 3 + 3].TexkoorL := Disc[i * 2 * 3 + 3].Vertex.xy;</font>
    Disc[i * 2 * 3 + 3].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 4].TexkoorL := Disc[i * 2 * 3 + 4].Vertex.xy;</font>
    Disc[i * 2 * 3 + 4].TexkoorL.scale(5.0);
    Disc[i * 2 * 3 + 5].TexkoorL := Disc[i * 2 * 3 + 5].Vertex.xy;</font>
    Disc[i * 2 * 3 + 5].TexkoorL.scale(5.0);

    Disc[i * 2 * 3 + 3].TexkoorR := TextureVertex[0];</font>
    Disc[i * 2 * 3 + 4].TexkoorR := TextureVertex[1];</font>
    Disc[i * 2 * 3 + 5].TexkoorR := TextureVertex[2];</font>
  end;
end;</pre></code>
Vertex-Koordianten bekommen beide Meshes die gleichen, aber die Textur-Koordinaten weichen ab.<br>
<pre><code>procedure TForm1.InitScene;
begin
  TextureBuffer.ActiveAndBind;
  glClearColor(0.6, 0.6, 0.4, 1.0);</font>

  // Ring Links
  glBindVertexArray(VBRingL.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 28, Pointer(0));</font>

  glBindBuffer(GL_ARRAY_BUFFER, VBRingL.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 28, Pointer(12));</font>

  // Ring Rechts
  glBindVertexArray(VBRingR.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBRingR.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);</font>
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 28, Pointer(0));</font>

  glBindBuffer(GL_ARRAY_BUFFER, VBRingR.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, Length(Disc) * SizeOf(TDiscVector), Pointer(Disc), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 28, Pointer(20));</font>
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
  ProdMatrix.Translate(-0.5, 0.0, 0.0);</font>
  ProdMatrix.Uniform(Matrix_ID);
  ProdMatrix := TempMatrix;

  glBindVertexArray(VBRingL.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Disc) * 3); // Zeichnet die linke Scheibe</font>

  // Zeichne rechte Scheibe
  ProdMatrix.Translate(0.5, 0.0, 0.0);</font>
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBRingR.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Disc) * 3); // Zeichnet die rechte Scheibe</font>

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten</font>

uniform mat4 mat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>
  UV0 = inUV;                           // Textur-Koordinaten weiterleiten.
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in vec2 UV0;

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
  FragColor.a = 1.0;</font>
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
