<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>15 - Erste Bewegung</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Ohne Bewegung ist OpenGL langweilig.<br>
Hier werden dem Shader ein X- und ein Y-Wert übergeben. Diese Werte werden mit einem Timer verändert.<br>
Damit die Änderung auch sichtbar wird, wird <b>DrawScene</b> danach manuell ausgelöst.<br>
<hr><br>
Hinzugekommen sind die Deklarationen der IDs für die X- und Y-Koordinaten.<br>
<b>TrianglePos</b> bestimmt die Bewegung und Richtung des Dreiecks.<br>
<pre><code>var
  X_ID, Y_ID: GLint;      // ID für X und Y.
  Color_ID: GLint;

  TrianglePos: record
    x, y: GLfloat;        // Position
    xr, yr: boolean;      // Richtung
  end;</pre></code>
Den Timer immer erst nach dem Initialisieren starten!<br>
Im Objektinspektor <b>muss</b> dessen Eigenschaft <b>Enable=(False)</b> sein!<br>
Ansonsten ist ein SIGSEV vorprogrammiert, da Shader aktviert werden, die es noch gar nicht gibt.<br>
<pre><code>procedure TForm1.FormCreate(Sender: TObject);
begin
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
  Timer1.Enabled := True;   // Timer starten
end;</pre></code>
Dieser Code wurde um zwei <b>UniformLocation</b>-Zeilen erweitert.<br>
Diese ermitteln die IDs, wo sich <b>x</b> und <b>y</b> im Shader befinden.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');</font>
  X_ID := Shader.UniformLocation('x'); // Ermittelt die ID von x.</font>
  Y_ID := Shader.UniformLocation('y'); // Ermittelt die ID von y.</font></pre></code>
Hier werden die Uniform-Variablen x und y dem Shader übergeben.<br>
Beim Dreieck sind das die Positions-Koordinaten.<br>
Beim Quad ist es 0, 0 und somit bleibt das Quadrat stehen.<br>
Mit <b>glUniform1f(...</b> kann man einen Float-Wert dem Shader übergeben.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  // Zeichne Dreieck
  glUniform3f(Color_ID, 1.0, 1.0, 0.0); // Gelb</font>
  with TrianglePos do begin  // Beim Dreieck, die xy-Werte.
    glUniform1f(X_ID, x);
    glUniform1f(Y_ID, y);
  end;
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Triangle) * 3);

  // Zeichne Quadrat
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);  // Rot</font>
  glUniform1f(X_ID, 0.0);  // Beim Quadrat keine Verschiebung, daher 0.0, 0.0 .</font>
  glUniform1f(Y_ID, 0.0);</font>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);</font></pre></code>
Den Timer vor dem Freigeben anhalten.<br>
<pre><code>procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;</pre></code>
Im Timer wird die Position berechnet, so dass sich das Dreieck bewegt.<br>
Anschliessend wird neu gezeichnet.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  stepx: GLfloat = 0.010;</font>
  stepy: GLfloat = 0.0133;</font>
begin
  with TrianglePos do begin
    if xr then begin
      x := x - stepx;
      if x < -0.5 then begin</font>
        xr := False;
      end;
    end else begin
      x := x + stepx;
      if x > 0.5 then begin</font>
        xr := True;
      end;
    end;
    if yr then begin
      y := y - stepy;
      if y < -1.0 then begin</font>
        yr := False;
      end;
    end else begin
      y := y + stepy;
      if y > 0.3 then begin</font>
        yr := True;
      end;
    end;
  end;
  ogcDrawScene(Sender);  // Neu zeichnen
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Hier sind die Uniform-Variablen <b>x</b> und <b>y</b> hinzugekommen.<br>
Diese werden im Vertex-Shader deklariert. Bewegungen kommen immer in diesen Shader.<br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
uniform float x;                      // Richtung von Uniform
uniform float y;
 
void main(void)
{
  vec3 pos;
  pos.x = inPos.x + x;
  pos.y = inPos.y + y;
  pos.z = inPos.z;
  gl_Position = vec4(pos, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

uniform vec3 Color;  // Farbe von Uniform
out vec4 outColor;   // ausgegebene Farbe

void main(void)
{
  outColor = vec4(Color, 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
