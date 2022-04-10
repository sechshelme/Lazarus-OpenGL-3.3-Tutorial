<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>20 - Texturen</h1></b>
    <b><h2>30 - Texturen und Matrixen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die Textur-Koordinaten kann man im Shader auch mit einer Matrix multipizieren.<br>
Dies geschieht ähnlich, wie bei den Vertex-Koordinanten, der grösste Unterschied dabei ist, das es sich um 2D-Koordinaten handelt.<br>
<br>
Dabei ist zu beachten, das beim Drehen/Verschieben die Transformationen in umgekehrter Reihenfolge verläuft,<br>
im Gegensatz zu Vertex-Koordinaten.<br>
<hr><br>
Das die Textur in der Mitte des Rechteckes dreht, muss sie um 0.5 verschoben werden.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  ScaleMatrix.Identity;
  ScaleMatrix.Scale(1.1);</font>

  TexturRotMatrix.Identity;

  // Textur verschieben
  TexturTransMatrix.Identity;
  TexturTransMatrix.Translate(-0.5, -0.0);</font>

  // Startwerte Texturtransformation
  with TexturTransform do begin
    scale := 1.0;</font>
    direction := True;
  end;</pre></code>
Matrizen multiplizieren und den Shader übergeben.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
var
  Matrix: TMatrix2D;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Textur.ActiveAndBind;
  Shader.UseProgram;

  ScaleMatrix.Uniform(Matrix_ID);  // Matrix für die Vektoren.

  // --- Texturmatrizen multiplizieren und übergeben.
  Matrix := TexturRotMatrix * TexturTransMatrix;
  Matrix.Uniform(texMatrix_ID);

  // --- Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(QuadVertex));</font>

  ogc.SwapBuffers;
end;</pre></code>
Berechnen der Matrix-Bewegungen.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  sstep = 1.03;  // Schritt für Skalierung</font>
  rstep = 0.01;  // Schritt für Rotation</font>
  winkel: single = 0.0;</font>

begin
  with TexturTransform do begin
    if direction then begin
      scale *= sstep;
      if scale > 15.0 then begin</font>
        direction := False;
      end;
    end else begin
      scale /= sstep;
      if scale < 1.0 then begin</font>
        direction := True;
      end;
    end;

    winkel := winkel + rstep;
    if winkel > 2 * pi then begin</font>
      winkel := winkel - 2 * pi;</font>
    end;

    // Matrix Skalieren und Rotieren.
    TexturRotMatrix.Identity;
    TexturRotMatrix.Scale(scale);
    TexturRotMatrix.Rotate(winkel);
  end;
  ogcDrawScene(Sender);
end;</pre></code>
<hr><br>
Hier sieht man, wie die Texturkoordinaten anhand der Matrix manipuliert werden.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location =  0) in vec3 inPos;   // Vertex-Koordinaten</font>
layout (location = 10) in vec2 inUV;    // Textur-Koordinaten</font>

uniform mat4 mat;
uniform mat3 texMat;

out vec2 UV0;

void main(void)
{
  gl_Position = mat * vec4(inPos, 1.0);</font>

  // Texturkoordinaten transformieren
  UV0 = (texMat * vec3(inUV, 1.0)).xy;</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

in vec2 UV0;

uniform sampler2D Sampler;

out vec4 FragColor;

void main()
{
  FragColor = texture( Sampler, UV0 );
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
