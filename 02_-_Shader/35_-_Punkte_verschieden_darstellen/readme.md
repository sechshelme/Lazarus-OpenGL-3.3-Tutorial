<img src="image.png" alt="Selfhtml"><br><br>
Man kann auch Punkte mit dem Shader darstellen, dies kann man auf verschiedene Weise.<br>
Im Fragment-Shader kann man das Zeichen der Punkte manipulieren.<br>
<hr><br>
Die Deklaration der Koordianten und Punktgrösse.<br>
<pre><code><b><font color="0000BB">var</font></b>
  Point: <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> TVertex2f;
  PointSize: <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> GLfloat;</pre></code>
Daten für die Punkte in die Grafikkarte übertragen<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  <i><font color="#FFFF00">// Daten für Punkt Position</font></i>
  glBindVertexArray(VBPoint.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex2f) * Length(Point), Pointer(Point), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Daten für Punkt Grösse</font></i>
  glBindVertexArray(VBPoint.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO_Size);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * Length(PointSize), Pointer(PointSize), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">11</font>);
  glVertexAttribPointer(<font color="#0077BB">11</font>, <font color="#0077BB">1</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</pre></code>
Zeichnen der Punkte<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">const</font></b>
  ofs = <font color="#0077BB">0</font>.<font color="#0077BB">4</font>;
<b><font color="0000BB">begin</font></b>
  glEnable(GL_PROGRAM_POINT_SIZE);

  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBPoint.VAO);
  <i><font color="#FFFF00">// gelb</font></i>
  glUniform1i(PointTyp_ID, <font color="#0077BB">0</font>);
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  glUniform1f(X_ID, -ofs);
  glUniform1f(Y_ID, -ofs);
  glDrawArrays(GL_POINTS, <font color="#0077BB">0</font>, Length(Point));

  <i><font color="#FFFF00">// rot</font></i>
  glUniform1i(PointTyp_ID, <font color="#0077BB">1</font>);
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  glUniform1f(X_ID, ofs);
  glUniform1f(Y_ID, -ofs);
  glDrawArrays(GL_POINTS, <font color="#0077BB">0</font>, Length(Point));

  <i><font color="#FFFF00">// grün</font></i>
  glUniform1i(PointTyp_ID, <font color="#0077BB">2</font>);
  glUniform3f(Color_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  glUniform1f(X_ID, ofs);
  glUniform1f(Y_ID, ofs);
  glDrawArrays(GL_POINTS, <font color="#0077BB">0</font>, Length(Point));

  <i><font color="#FFFF00">// blau</font></i>
  glUniform1i(PointTyp_ID, <font color="#0077BB">3</font>);
  glUniform3f(Color_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  glUniform1f(X_ID, -ofs);
  glUniform1f(Y_ID, ofs);
  glDrawArrays(GL_POINTS, <font color="#0077BB">0</font>, Length(Point));

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b>  inPos;  <i><font color="#FFFF00">// Vertex-Koordinaten in 2D</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">float</font></b> inSize; <i><font color="#FFFF00">// Vertex-Koordinaten in 2D</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">float</font></b> x;                        <i><font color="#FFFF00">// Richtung von Uniform</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">float</font></b> y;
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  <b><font color="0000BB">vec2</font></b> pos = inPos;
  pos.x = pos.x + x;
  pos.y = pos.y + y;
  gl_PointSize = inSize;
  gl_Position  = <b><font color="0000BB">vec4</font></b>(pos, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);   <i><font color="#FFFF00">// Der zweiter Parameter (Z) auf 0.0</font></i>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> Color  ;  <i><font color="#FFFF00">// Farbe von Uniform</font></i>
<b><font color="0000BB">out</font></b>     <b><font color="0000BB">vec4</font></b> outColor; <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">int</font></b> PointTyp;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  <b><font color="0000BB">vec2</font></b>  p = gl_PointCoord * <font color="#0077BB">2</font>.<font color="#0077BB">0</font> - <b><font color="0000BB">vec2</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">float</font></b> r = sqrt(dot(p, p));

  <b><font color="0000BB">float</font></b> theta = atan(p.y, p.x);

  <b><font color="0000BB">switch</font></b> (PointTyp){
    <b><font color="0000BB">case</font></b> <font color="#0077BB">0</font>: <b><font color="0000BB">if</font></b>(dot(gl_PointCoord - <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, gl_PointCoord - <font color="#0077BB">0</font>.<font color="#0077BB">5</font>) > <font color="#0077BB">0</font>.<font color="#0077BB">25</font>)
              <b><font color="0000BB">discard</font></b>;
            <b><font color="0000BB">else</font></b>
              outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
            <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">case</font></b> <font color="#0077BB">1</font>: <b><font color="0000BB">if</font></b>(dot(p, p) > cos(theta * <font color="#0077BB">5</font>))
              <b><font color="0000BB">discard</font></b>;
            <b><font color="0000BB">else</font></b>
              outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
            <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">case</font></b> <font color="#0077BB">2</font>: <b><font color="0000BB">if</font></b>(dot(p, p) > r || dot(p, p) < r * <font color="#0077BB">0</font>.<font color="#0077BB">75</font>)
              <b><font color="0000BB">discard</font></b>;
            <b><font color="0000BB">else</font></b>
              outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
            <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">case</font></b> <font color="#0077BB">3</font>: <b><font color="0000BB">if</font></b>(dot(p, p) > <font color="#0077BB">5</font>.<font color="#0077BB">0</font> / cos(theta - <font color="#0077BB">20</font> * r))
              <b><font color="0000BB">discard</font></b>;
            <b><font color="0000BB">else</font></b>
              outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
            <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">default</font></b>: <b><font color="0000BB">discard</font></b>;

  }
}
</pre></code>

