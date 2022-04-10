<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>05 - 3D</h1></b>
    <b><h2>20 - Fluchtpunktperspektive (Frustum)</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Will man die Scene realistisch proportional darstellen, nimmt man eine Frustum-Matrix.<br>
Dies hat den Einfluss, das Objekte kleiner erscheinen, je weiter die Scene von einem weg ist.<br>
In der Realität ist dies auch so, das Objekte kleiner erscheinen, je weiter sie von einem weg sind.<br>
<hr><br>
Der Frustum funktioniert ähnlich wie beim Ortho.<br>
Nur die Parameter sind ein wenig anders.<br>
Die Z-Werte müssen immer <b>positiv</b> sein.<br>
<br>
Mit den zwei letzten Parametern von Frustum und der World-Matrix muss man ein bisschen probieren, zum Teil wird sonst das Bild verzehrt.<br>
<br>
Alternativ kann man den Frustum auch mit <b>Perspective(...</b> einstellen.<br>
Dabei ist der erste Parameter der Betrachtungs-Winkel.<br>
Der zweite Parameter ist das Fensterverhältniss, mehr dazu und glViewPort.<br>
<pre><code>procedure TForm1.CreateScene;
const
  w = 1.0;</font>
begin
  Matrix.Identity;
  FrustumMatrix.Frustum(-w, w, -w, w, 2.5, 1000.0);</font>

//   FrustumMatrix.Perspective(45, 1.0, 2.5, 1000.0); // Alternativ

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200.0); // Die Scene in den sichtbaren Bereich verschieben.</font>
  WorldMatrix.Scale(5.0);                  // Und der Grösse anpassen.</font></pre></code>
Das Zeichnen ist das Selbe wie bei Ortho.<br>
<pre><code>  // --- Zeichne Würfel

  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.

        Matrix := FrustumMatrix * WorldMatrix * Matrix;        // Matrizen multiplizieren.

        Matrix.Uniform(Matrix_ID);                             // Matrix dem Shader übergeben.
        glDrawArrays(GL_TRIANGLES, 0, Length(CubeVertex) * 3); // Zeichnet einen kleinen Würfel.
      end;
    end;
  end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
layout (location = 11) in vec3 inCol; // Farbe</font>

out vec4 Color;                       // Farbe, an Fragment-Shader übergeben.

uniform mat4 Matrix;                  // Matrix für die Drehbewegung und Frustum.

void main(void)
{
  gl_Position = Matrix * vec4(inPos, 1.0);</font>
  Color = vec4(inCol, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
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
