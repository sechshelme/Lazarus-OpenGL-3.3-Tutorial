<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>06 - Alpha Blending</h1></b>
    <b><h2>15 - Reihenfolge sortiert mit Texturen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Da mit Texturen welche Alpha-Blending haben das gleiche Problem besteht, wie mit den Würfeln, muss man auch dort sortieren.<br>
Da die Position der Bäume keine Drehbewegung haben, reicht ein Vector für dessen Position, eine Matrix ist nicht nötig.<br>
Für den Boden wird eine Matrix gebraucht, da ich diesen drehe.<br>
<br>
Zusätzlich habe ich für den Boden noch eine Textur genommen, somit sieht die Scene recht realistisch aus.<br>
<br>
Wie Texturen funktionieren, in einem späteren Kapitel.<br>
<hr><br>
Den Speicher für die Position der Bäume reservieren.<br>
<pre><code>
procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to TreeCount - 1 do begin
    New(TreePosArray[i]);
  end;</pre></code>
Die Position der Bäume  wird zufällig bestimmt.<br>
<pre><code>procedure TForm1.InitScene;
const
  d = 10;</font>
var
  i: integer;
begin
  for i := 0 to TreeCount - 1 do begin
    TreePosArray[i]^.x := -d / 2 + Random * d;</font>
    TreePosArray[i]^.y := 0.0;</font>
    TreePosArray[i]^.z := -d / 2 + Random * d;</font>
  end;</pre></code>
Der Boden und die Bäume zeichen.<br>
Dabei ist es wichtig, das man zuerst den Boden zeichnet, weil die Bäume Alpha-Blending haben.<br>
Objecte mit Alpha-Blending sollte man immer zum Schluss zeichnen.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);

  procedure QuickSort(var ia: array of PTreePos; ALo, AHi: integer);
  var
    Lo, Hi: integer;
    dummy : PTreePos;
    Pivot: TTreePos;
  begin
    Lo := ALo;
    Hi := AHi;
    Pivot := ia[(Lo + Hi) div 2]^;</font>
    repeat
      while ia[Lo]^.z < Pivot.z do begin
        Inc(Lo);
      end;
      while ia[Hi]^.z > Pivot.z do begin
        Dec(Hi);
      end;
      if Lo <= Hi then begin
        dummy := ia[Lo];
        ia[Lo] := ia[Hi];
        ia[Hi] := dummy;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > ALo then begin
      QuickSort(ia, ALo, Hi);
    end;
    if Lo < AHi then begin
      QuickSort(ia, Lo, AHi);
    end;
  end;

var
  i: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);        // Frame und Tiefen-Puffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  // --- Zeichne Boden
  SandTextur.ActiveAndBind;                                   // Boden-Textur binden
  Matrix.Identity;
  Matrix.Translate(0.0, 1.0, 0.0);</font>
  Matrix.Scale(10.0);</font>
  Matrix.RotateA(Pi / 2);</font>

  Matrix := FrustumMatrix * WorldMatrix * GroundPos * Matrix; // Matrizen multiplizieren.

  Matrix.Uniform(Matrix_ID);                                  // Matrix dem Shader übergeben.
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));      // Zeichnet einen kleinen Würfel.

  // --- Zeichne Bäume
  QuickSort(TreePosArray, 0, TreeCount - 1);                  // Die Bäume sortieren.

  BaumTextur.ActiveAndBind;                                   // Baum-Textur binden

  for i := 0 to TreeCount - 1 do begin
    Matrix.Identity;
    Matrix.Translate(TreePosArray[i]^);                       // Die Bäume an die richtige Position bringen

    Matrix := FrustumMatrix * WorldMatrix * Matrix;           // Matrizen multiplizieren.

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));</font>
  end;

  ogc.SwapBuffers;
end;</pre></code>
Da sieht man, das es reicht nur den Vector zu drehen.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  rot = 0.0134;</font>
var
  i: integer;
begin
  for i := 0 to TreeCount - 1 do begin
    TreePosArray[i]^.RotateB(rot);
  end;
  GroundPos.RotateB(rot);

  ogc.Invalidate;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location =  0) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV;  // Textur-Koordinaten</font>

out vec2 UV0;

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Frustum.

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);</font>
  UV0         = inUV;                 // Textur-Koordinaten weiterleiten.
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in vec2 UV0;

uniform sampler2D Sampler;              // Der Sampler welchem 0 zugeordnet wird.

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );  // Die Farbe aus der Textur anhand der Koordinten auslesen.
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
