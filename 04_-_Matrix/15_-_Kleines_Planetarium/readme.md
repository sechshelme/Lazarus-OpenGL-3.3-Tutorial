<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>04 - Matrix</h1></b>
    <b><h2>15 - Kleines Planetarium</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Kleines Planetarium, welches die Handhabung von Matrizen demonstriert.<br>
Das es übersichtlicher wird, habe ich die Sonne und die Planeten in eine Klasse gepackt.<br>
<br>
Da dieses Beispiel auf einer 2D-Ebene läuft, wird nur eine <b>3x3</b>-Matrix verwendet, auch die Vektor-Koordinaten sind 2D.<br>
Einzig der Vertex-Shader wird ein wenig komplizierter, da die Z-Achse nicht verwendet wird.<br>
<br>
Am Shader wird nur eine Matrix übergeben, welche von der CPU berechnet wird.<br>
Diese Matrix wird aus verschiedene Transformen berechnet.<br>
<hr><br>
Es gibt nur eine ID, da die ganze Matrizen-Berechnung mit der CPU ausgeführt werden.<br>
<pre><code>var
  Matrix_ID: GLint;  // ID für Matrix.</pre></code>
Rendern der Sonne und der Paneten.<br>
Dies sind nur farbige Kreise. Der Rest wird später über Matrizen brechnet.<br>
<pre><code>constructor TPlanet.Create(col: TVector3f);
const
  maxSektor = 17;  // Anzahl Sektoren der Kreise.</font>
var
  i, j: integer;
begin
  inherited Create;

  with Mesh do begin
    size := maxSektor;
    SetLength(Vector, size);
    SetLength(Color, size);
    for i := 0 to size - 1 do begin</font>
      for j := 0 to 2 do begin</font>
        Color[i, j] := vec3(col[0] + (Random / 4), col[1] + (Random / 4), col[2] + (Random / 4));
      end;

      Vector[i, 0] := vec2(0.0, 0.0);</font>
      Vector[i, 1] := vec2(sin(Pi * 2 / size * i), cos(Pi * 2 / size * i));</font>
      Vector[i, 2] := vec2(sin(Pi * 2 / size * (i + 1)), cos(Pi * 2 / size * (i + 1)));</font>
    end;
  end;</pre></code>
Legt die Matrix für die Umlaufbahnen fest.<br>
<pre><code>procedure TPlanet.SetMondR(AValue: GLfloat);
begin
  MondTransMatrix.Translate(AValue, 0.0);  // Distanz Erde - Mond. ( Erde Mond ist ein Doppelplanet )</font>
end;

procedure TPlanet.SetUmlaufR(AValue: GLfloat);
begin
  UmlaufTransMatrix.Translate(AValue, 0.0); // Distanz Sonne / Planet.</font>
end;</pre></code>
Hier werden die Bahnen der Planeten berechnet und anschliessend gezeichnet.<br>
<pre><code>procedure TPlanet.Draw;
begin
  UmlaufRotMatrix.Rotate(FUmlaufSpeed);
  PlanetRotMatrix.Rotate(fPlanetSpeed);
  MondRotMatrix.Rotate(FMondSpeed);

  TempMatrix := PlanetRotMatrix;
  TempMatrix.Scale(fPlanetScale);

  TempMatrix := UmlaufRotMatrix * UmlaufTransMatrix * MondRotMatrix * MondTransMatrix * TempMatrix;

  TempMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VAO);
  glDrawArrays(GL_TRIANGLES, 0, Mesh.size * 3);</font>
end;</pre></code>
Die Parameter für die Sonne und Planeten.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Sonne := TPlanet.Create(vec3(0.8, 0.8, 0.0));</font>
  with Sonne do begin
    PlanetSpeed := 0.06;</font>
    PlanetScale := 0.1;</font>
  end;

  Venus := TPlanet.Create(vec3(0.5, 0.5, 0.2));</font>
  with Venus do begin
    PlanetScale := 0.035;</font>
    PlanetSpeed := 0.2;</font>
    UmlaufSpeed := 0.01;</font>
    UmlaufR := 0.2;</font>
  end;

  Erde := TPlanet.Create(vec3(0.0, 0.2, 1.0));</font>
  with Erde do begin
    PlanetScale := 0.04;</font>
    PlanetSpeed := 0.2;</font>
    MondSpeed := 0.04;</font>
    UmlaufSpeed := 0.008;</font>
    MondR := 0.04;</font>
    UmlaufR := 0.4;</font>
  end;

  Mond := TPlanet.Create(vec3(0.5, 0.5, 0.5));</font>
  with Mond do begin
    PlanetScale := 0.02;</font>
    MondSpeed := 0.04;</font>
    UmlaufSpeed := 0.008;</font>
    MondR := -0.04;</font>
    UmlaufR := 0.4;</font>
  end;

  Mars := TPlanet.Create(vec3(0.8, 0.2, 0.2));</font>
  with Mars do begin
    PlanetScale := 0.025;</font>
    PlanetSpeed := 0.3;</font>
    UmlaufSpeed := 0.006;</font>
    UmlaufR := 0.6;</font>
  end;</pre></code>
Sonne und Planeten zeichnen<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Sonne und Planeten
  Sonne.Draw;
  Venus.Draw;
  Erde.Draw;
  Mond.Draw;
  Mars.Draw;

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Bei der Multiplikation, wird die Z-Achse ignoriert, aus diesem Grund wird <b>glPosition.xyw</b> verwendet.<br>
Anschliessend wird Z auf <b>0.0</b> gesetzt.<br>
<pre><code>#version 330</font>

layout (location = 10) in vec2 inPos; // Vertex-Koordinaten in 2D.</font>
layout (location = 11) in vec3 inCol; // Farbe</font>

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben.

uniform mat3 mat;                     // Matrix von Uniform.


void main(void)
{
  gl_Position.xyw = mat * vec3(inPos, 1.0);</font>
  gl_Position.z   = 0.0;</font>
  Color = vec4(inCol, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in vec4 Color;      // interpolierte Farbe vom Vertexshader
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
