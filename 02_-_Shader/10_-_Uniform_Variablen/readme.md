<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>10 - Uniform Variablen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird die Farbe des Meshes über eine Unifom-Variable an den Shader übergeben, somit kann die Farbe zur Laufzeit geändert werden.<br>
Unifom-Variablen dienen dazu, um Parameter den Shader-Objecte zu übergeben. Meistens sind dies Matrixen, oder wie hier im Beispiel die Farben.<br>
Oder auch Beleuchtung-Parameter, zB. die Position des Lichtes.<br>
<hr><br>
Deklaration der ID, welche auf die Unifom-Variable im Shader zeigt, und die Variable, welche die Farbe für den Vektor enthält.<br>
Da man die Farbe als Vektor übergibt, habe ich dafür den Typ <b>TVertex3f</b> gewählt. Seine Komponenten beschreiben den Rot-, Grün- und Blauanteil der Farbe.<br>
<pre><code>var
  Color_ID: GLint;      // ID
  MyColor: TVertex3f;   // Farbe</pre></code>
Dieser Code wurde um eine Zeile <b>UniformLocation</b> erweitert.<br>
Diese ermittelt die ID, wo sich <b>Color</b> im Shader befindet.<br>
<br>
Vor dem Ermitteln muss mit <b>UseProgram</b> der Shader aktviert werden, von dem man lesen will.<br>
Im Hintergrund wird dabei <b>glGetUniformLocation(ProgrammID,...</b> aufgerufen.<br>
Der Vektor von MyColor ist in RGB (Rot, Grün, Blau).<br>
<br>
Der String in <b>UniformLocation</b> muss indentisch mit dem Namen der Uniform-Variable im Shader sein. <b>Wichtig:</b> Es muss auf Gross- und Kleinschreibung geachtet werden.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color'); // Ermittelt die ID von "Color".</font>
  // MyColor Blau zuweisen.
  MyColor[0] := 0.0;</font>
  MyColor[1] := 0.0;</font>
  MyColor[2] := 1.0;</font></pre></code>
Hier wird die Uniform-Variable übergeben. Für diese vec3-Variable gibt es zwei Möglichkeiten.<br>
Mit <b>glUniform3fv...</b> kann man sie als ganzen Vektor übergeben.<br>
Mit <b>glUniform3f(...</b> kann man die Komponenten der Farben auch einzeln übergeben.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  glUniform3fv(Color_ID, 1, @MyColor);   // Als Vektor</font>
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Einzel</font>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);</font>

  ogc.SwapBuffers;
end;</pre></code>
Folgende Prozedur weist dem Vektor <b<MyColor</b> eine andere Farbe zu.<br>
Dafür wird ein einfaches Menü verwendet.<br>
<pre><code>procedure TForm1.MenuItemClick(Sender: TObject);
begin
  case TMainMenu(Sender).Tag of
    0: begin   // Rot</font>
      MyColor[0] := 1.0;</font>
      MyColor[1] := 0.0;</font>
      MyColor[2] := 0.0;</font>
    end;
    1: begin   // Grün</font>
      MyColor[0] := 0.0;</font>
      MyColor[1] := 1.0;</font>
      MyColor[2] := 0.0;</font>
    end;
    2: begin   // Blau</font>
      MyColor[0] := 0.0;</font>
      MyColor[1] := 0.0;</font>
      MyColor[2] := 1.0;</font>
    end;
  end;
  ogc.Invalidate;   // Manuelle Aufruf von DrawScene.
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
 
void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<br>
Hier ist die Uniform-Variable <b>Color</b> hinzugekommen.<br>
Diese habe ich nur im Fragment-Shader deklariert, da diese nur hier gebraucht wird.<br>
<pre><code>#version 330</font>

uniform vec3 Color;  // Farbe von Uniform
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Color, 1.0); // Das 1.0 ist der Alpha-Kanal, hat hier keine Bedeutung.</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
