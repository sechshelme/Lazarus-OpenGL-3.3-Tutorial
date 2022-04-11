<html>
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>30 - Shapes (Linien und Punkte)</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt wurde alles mit kompletten Dreiecken gerendert und gezeichnet. Es gibt aber noch zwei andere Varianten um Dreiecke zu rendern.<br>
Dies wurde beim Zeichnen mit <b>glDrawArrays(GL_TRIANGLES, ...</b> veranlasst. Diese Version wird in der Paraxis am meisten angewendet.<br>
Man kann die Dreiecke auch als Streifen hintereinander rendern, dies gerschieht mit <b>glDrawArrays(GL_TRIANGLES_STRIP, ...</b>.<br>
Oder wie ein Wedel, dabei ist der erste Vektor die Mitte, und der Rest die Eckpunkte. Dies geschieht dann mit <b>glDrawArrays(GL_TRIANGLES_FAN, ...</b>.<br>
<br>
Das schreiben in die Grafikkarte, ist bei allen Varianten gleich, der Unterschied ist legendlich beim Zeichenen mit <b>glDrawArrays(...</b>.<br>
<hr><br>
Die Deklaration der Vektor-Koordianten Konstanten, zur Vereinfachung habe ich nur 2D-Vektoren genommen. Natürlich können diese auch 3D sein.<br>
<pre><code=scal><b><font color="0000BB">var</font></b>
  Linies: <b><font color="0000BB">array</font></b> <b><font color="0000BB">of</font></b> TVertex2f; <i><font color="#FFFF00">// XY-Koordinaten</font></i></code></pre>
Hier werden die Daten in die Grafikkarte geschrieben.<br>
Es hat nichts besonderes, da für jede Mesh die gleichen Koordinaten verwendet werden.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>
<br>
  <i><font color="#FFFF00">// Daten für GL_TRIANGLE</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TVertex2f) * Length(Linies), Pointer(Linies), GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</code></pre>
Bei <b>glDrawArrays(...</b> ist der erste Parameter das wichtigste, hier wird angegeben, wie die Vektor-Koordinaten gezeichnet werden.<br>
Hier werden vier Möglichkeiten gezeigt, dazu werden immer die gleichen Vertex-Koordinaten verwendet. Daher sieht man den Unterschied gut.<br>
<br>
Mit <b>glLineWidth(...</b> kann die Linienbreite angegeben werden, default ist <b>1.0</b> .<br>
Mit <b>glPointSize(...</b> kann der Durchmesser der Punkte angegeben werden, default ist <b>1.0</b> .<br>
Für die Punkte gibt es noch eine andere Möglichkeit, man kann den Durchmesser auch im Shader angegeben, dazu später.<br>
<br>
Wen mit <b>glPolygonMode(...</b> auf Punkte oder Linien umgestellt wird, haben diese beiden Parameter auch einen Einfluss.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">const</font></b>
  ofs = <font color="#0077BB">0</font>.<font color="#0077BB">4</font>;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glBindVertexArray(VBTriangle.VAO);
<br>
  <i><font color="#FFFF00">// Zeichne GL_LINES</font></i>
  glLineWidth(<font color="#0077BB">3</font>);                        <i><font color="#FFFF00">// Linie 3 Pixel breit.</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>) ; <i><font color="#FFFF00">// Gelb</font></i>
  glUniform1f(X_ID, -ofs);               <i><font color="#FFFF00">// links-</font></i>
  glUniform1f(Y_ID, -ofs);               <i><font color="#FFFF00">// unten</font></i>
  glDrawArrays(GL_LINES, <font color="#0077BB">0</font>, Length(Linies));
<br>
  <i><font color="#FFFF00">// Zeichne GL_LINE_STRIP</font></i>
  glLineWidth(<font color="#0077BB">1</font>);                        <i><font color="#FFFF00">// Linie 1 Pixel breit.</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Rot</font></i>
  glUniform1f(X_ID, ofs);                <i><font color="#FFFF00">// rechts-</font></i>
  glUniform1f(Y_ID, -ofs);               <i><font color="#FFFF00">// unten</font></i>
  glDrawArrays(GL_LINE_STRIP, <font color="#0077BB">0</font>, Length(Linies));
<br>
  <i><font color="#FFFF00">// Zeichne GL_LINE_LOOP</font></i>
  glLineWidth(<font color="#0077BB">6</font>);                        <i><font color="#FFFF00">// Linie 6 Pixel breit.</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Grün</font></i>
  glUniform1f(X_ID, ofs);                <i><font color="#FFFF00">// rechts-</font></i>
  glUniform1f(Y_ID, ofs);                <i><font color="#FFFF00">// oben</font></i>
  glDrawArrays(GL_LINE_LOOP, <font color="#0077BB">0</font>, Length(Linies));
<br>
  <i><font color="#FFFF00">// Zeichne GL_POINTS</font></i>
  glPointSize(<font color="#0077BB">5</font>);                        <i><font color="#FFFF00">// Punkte Durchmesser 5 Pixel.</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Blau</font></i>
  glUniform1f(X_ID, -ofs);               <i><font color="#FFFF00">// links-</font></i>
  glUniform1f(Y_ID, ofs);                <i><font color="#FFFF00">// oben</font></i>
  glDrawArrays(GL_POINTS, <font color="#0077BB">0</font>, Length(Linies));</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Da die Koordinaten nur als 2D gespeichert sind, wird im Vertex-Shader der Z-Wert auf 0.0 gesetzt.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten in 2D</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">float</font></b> x;                      <i><font color="#FFFF00">// Richtung von Uniform</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">float</font></b> y;
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  <b><font color="0000BB">vec2</font></b> pos = inPos;
  pos.x = pos.x + x;
  pos.y = pos.y + y;
  gl_Position = <b><font color="0000BB">vec4</font></b>(pos, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Der zweiter Parameter (Z) auf 0.0</font></i>
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> Color;  <i><font color="#FFFF00">// Farbe von Uniform</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<br>
</html>
