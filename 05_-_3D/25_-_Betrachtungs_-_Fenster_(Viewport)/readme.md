<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>05 - 3D</h1></b>
    <b><h2>25 - Betrachtungs - Fenster (Viewport)</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt hat sich die Scene im proportional des Ausgabe-fensters angepasst.<br>
Das hat zu Folge, das ein Kreis ovalig wird, wen das Fenster nicht quadratisch ist.<br>
Der Grund dafür ist, das die Ausgabe immer im Bereich von <b>-1.0</b> bis <b>+1.0</b> in der X und Y-Achse ist.<br>
<br>
Um dies zu umgehen, wird bei jeder Grössenänderung des Fenster die Frustum-Matrix neu angepasst.<br>
Entweder über <b>TMatrix.Frustum(...</b> oder noch einfacher wie im Beispiel mit <b>Matrix.Perspective(...</b> .<br>
Dies geschieht im <b>OnResize</b>-Ereigniss von <b>TContext</b>.<br>
<br>
Bei einer Orthogonalprojektion kann man dies mit <b>TMatrix.Ortho(...</b> anpassen.<br>
<hr><br>
Hier wird das OnResize-Ereigniss einer neuen Funktion zugeordnet.<br>
<pre><code>procedure TForm1.FormCreate(Sender: TObject);
begin
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;   // neues Ereigniss</pre></code>
Hier wird bei einer Grössenänderung des Fenster die Perspektive angepasst.<br>
Dabei ist der zweite Parameter relevant.<br>
<pre><code>procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);</font>
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
