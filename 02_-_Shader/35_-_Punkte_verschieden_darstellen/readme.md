<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>35 - Punkte verschieden darstellen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann auch Punkte mit dem Shader darstellen, dies kann man auf verschiedene Weise.<br>
Im Fragment-Shader kann man das Zeichen der Punkte manipulieren.<br>
<hr><br>
Die Deklaration der Koordianten und Punktgrösse.<br>
<pre><code>var
  Point: array of TVertex2f;
  PointSize: array of GLfloat;</pre></code>
Daten für die Punkte in die Grafikkarte übertragen<br>
<pre><code>procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe</font>

  // Daten für Punkt Position
  glBindVertexArray(VBPoint.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex2f) * Length(Point), Pointer(Point), GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);</font>
  glVertexAttribPointer(10, 2, GL_FLOAT, False, 0, nil);

  // Daten für Punkt Grösse
  glBindVertexArray(VBPoint.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO_Size);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * Length(PointSize), Pointer(PointSize), GL_STATIC_DRAW);
  glEnableVertexAttribArray(11);</font>
  glVertexAttribPointer(11, 1, GL_FLOAT, False, 0, nil);
end;</pre></code>
Zeichnen der Punkte<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
const
  ofs = 0.4;</font>
begin
  glEnable(GL_PROGRAM_POINT_SIZE);

  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBPoint.VAO);
  // gelb
  glUniform1i(PointTyp_ID, 0);</font>
  glUniform3f(Color_ID, 1.0, 1.0, 0.0);</font>
  glUniform1f(X_ID, -ofs);
  glUniform1f(Y_ID, -ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));</font>

  // rot
  glUniform1i(PointTyp_ID, 1);</font>
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);</font>
  glUniform1f(X_ID, ofs);
  glUniform1f(Y_ID, -ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));</font>

  // grün
  glUniform1i(PointTyp_ID, 2);</font>
  glUniform3f(Color_ID, 0.0, 1.0, 0.0);</font>
  glUniform1f(X_ID, ofs);
  glUniform1f(Y_ID, ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));</font>

  // blau
  glUniform1i(PointTyp_ID, 3);</font>
  glUniform3f(Color_ID, 0.0, 0.0, 1.0);</font>
  glUniform1f(X_ID, -ofs);
  glUniform1f(Y_ID, ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));</font>

  ogc.SwapBuffers;
end;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec2  inPos;  // Vertex-Koordinaten in 2D</font>
layout (location = 11) in float inSize; // Vertex-Koordinaten in 2D</font>
uniform float x;                        // Richtung von Uniform
uniform float y;
 
void main(void)
{
  vec2 pos = inPos;
  pos.x = pos.x + x;
  pos.y = pos.y + y;
  gl_PointSize = inSize;
  gl_Position  = vec4(pos, 0.0, 1.0);   // Der zweiter Parameter (Z) auf 0.0</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code>#version 330</font>

uniform vec3 Color  ;  // Farbe von Uniform
out     vec4 outColor; // ausgegebene Farbe

uniform int PointTyp;

void main(void)
{
  vec2  p = gl_PointCoord * 2.0 - vec2(1.0);</font>
  float r = sqrt(dot(p, p));

  float theta = atan(p.y, p.x);

  switch (PointTyp){
    case 0: if(dot(gl_PointCoord - 0.5, gl_PointCoord - 0.5) > 0.25)</font>
              discard;
            else
              outColor = vec4(Color, 1.0);</font>
            break;
    case 1: if(dot(p, p) > cos(theta * 5))
              discard;
            else
              outColor = vec4(Color, 1.0);</font>
            break;
    case 2: if(dot(p, p) > r || dot(p, p) < r * 0.75)</font>
              discard;
            else
              outColor = vec4(Color, 1.0);</font>
            break;
    case 3: if(dot(p, p) > 5.0 / cos(theta - 20 * r))</font>
              discard;
            else
              outColor = vec4(Color, 1.0);</font>
            break;
    default: discard;

  }
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
