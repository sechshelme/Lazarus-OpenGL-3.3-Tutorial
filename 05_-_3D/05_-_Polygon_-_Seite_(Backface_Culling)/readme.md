<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>05 - 3D</h1></b>
    <b><h2>05 - Polygon - Seite (Backface Culling)</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die Meshes ist hier noch 2D, aber <b>Backface Culling</b> wird in folgenden 3D-Beispielen gebraucht.<br>
<br>
Defaultmässig zeichnet OpenGL immer die Vorder und Rückseite eines Polygones. Für die meisten Meshes ist dies aber nicht nötig.<br>
Bei einem Würfel ist es nicht nötig, das die Innenseite der Polygone gezeichnet werden, da man diese sowieso nicht sieht.<br>
Dies spart Rechneleistung, weil jede Pixelüberprüfung Zeit kostet.<br>
Mit <b>glEnable(GL_CULL_FACE);</b> wird nur die Vorderseite der Polygone gezeichnet. Ausgenommen man schaltet es mit <b>glCullFace(...</b> um, so das nur die Rückseite gezeichnet wird.<br>
<br>
In diesem Beispiel, wird dies mit einem Timer demonstriert.<br>
<br>
Was dabei wichtig ist, die Polygone müssen immer im Gegenuhrzeigersinn gerendert werden. Auch dies könnte man <b>glFrontFace(...</b> umstellen.<br>
Dafür gibt es die Parameter <b>GL_CW</b> für Uhrzeigersinn, und den Default-Parameter <b>GL_CCW</b>.<br>
<hr><br>
Wen man die Konstanten genau anschaut, sieht man, das das Dreieck im Gegenuhrzegersinn und das Qaudrat im Uhrzeigersinn deklariert ist.<br>
<pre><code>const
  // Dreieck
  Triangle: array[0..0] of TFace =</font>
    (((-0.4, 0.1, 0.0), (0.4, 0.1, 0.0), (0.0, 0.7, 0.0)));</font>

  // Quadrat
  Quad: array[0..1] of TFace =</font>
    (((-0.2, -0.6, 0.0), (-0.2, -0.1, 0.0), (0.2, -0.1, 0.0)),
    ((-0.2, -0.6, 0.0), (0.2, -0.1, 0.0), (0.2, -0.6, 0.0)));</font></pre></code>
Hier wird die Backface Culling aktiviert:<br>
<pre><code>procedure TForm1.InitScene;
begin
  glEnable(GL_CULL_FACE);           // Überprüfung einschalten</pre></code>
Hier wird zwischen der Rück und Vorder-Seite umgesschalten.<br>
Man sagt immer, welche Seite nicht gezeichnet wird.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  CullFace: boolean = False;
begin
  if CullFace then begin
    glCullFace(GL_BACK);      // Rückseite nicht zeichnen.
  end else begin
    glCullFace(GL_FRONT);     // Vorderseite nicht zeichnen.
  end;
  CullFace := not CullFace;
  ogc.Invalidate;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>

void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  vec3 col = vec3(1.0, 0.0, 0.0);</font>
  outColor = vec4(col, 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
