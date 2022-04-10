<html>
<img src="image.png" alt="Selfhtml"><br><br>
Bis jetzt wurde alles mit kompletten Dreiecken gerendert und gezeichnet. Es gibt aber noch zwei andere Varianten um Dreiecke zu rendern.<br>
Dies wurde beim Zeichnen mit <b>glDrawArrays(GL_TRIANGLES, ...</b> veranlasst. Diese Version wird in der Paraxis am meisten angewendet.<br>
Man kann die Dreiecke auch als Streifen hintereinander rendern, dies gerschieht mit <b>glDrawArrays(GL_TRIANGLES_STRIP, ...</b>.<br>
Oder wie ein Wedel, dabei ist der erste Vektor die Mitte, und der Rest die Eckpunkte. Dies geschieht dann mit <b>glDrawArrays(GL_TRIANGLES_FAN, ...</b>.<br>
<br>
Das schreiben in die Grafikkarte, ist bei allen Varianten gleich, der Unterschied ist legendlich beim Zeichenen mit <b>glDrawArrays(...</b>.<br>
<br>
Die Darstellung sieht folgendermassen aus:<br>
<br>
<b>GL_TRIANGLES</b><br>
<pre><code>4 - 3     2
| /     / |
5     0 - 1</code></pre>
<b>GL_TRIANGLES_STRIP</b><br>
<pre><code>  5 - 3 - 1
 / \ / \ / \
6 - 4 - 2 - 0</code></pre>
<b>GL_TRIANGLES_FAN</b><br>
<pre><code>  5 - 4
 / \ / \
6 - 0 - 3
 \ / \ /
  1 - 2</code></pre>
<br>
<hr><br>
Die Deklaration der Vektor-Koordianten Konstanten, zur Vereinfachung habe ich nur 2D-Vektoren genommen. Natürlich können diese auch 3D sein.<br>
<pre><code><b><font color="0000BB">const</font></b>
  <i><font color="#FFFF00">// Einfache Dreiecke        ( Gelb )</font></i>
  Triangles: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVertex2f =
    ((<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>));
  <i><font color="#FFFF00">// Dreicke als Band, Strip  ( Rot )</font></i>
  Triangle_Strip: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">6</font>] <b><font color="0000BB">of</font></b> TVertex2f =
    ((<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));
  <i><font color="#FFFF00">// Dreiecke als Wedel, Fan  ( Grün )</font></i>
  Triangle_Fan: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">6</font>] <b><font color="0000BB">of</font></b> TVertex2f =
    ((<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">3</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">3</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));</code></pre>
Hier werden die Daten in die Grafikkarte geschrieben.<br>
Es hat nichts besonderes.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  <i><font color="#FFFF00">// Daten für GL_TRIANGLE</font></i>
  glBindVertexArray(VBTriangles.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangles.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangles), @Triangles, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Daten für GL_TRIANGLE_STRIP</font></i>
  glBindVertexArray(VBTriangle_Strip.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle_Strip.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle_Strip), @Triangle_Strip, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Daten für GL_TRIANGLE_FAN</font></i>
  glBindVertexArray(VBTriangle_Fan.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle_Fan.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle_Fan), @Triangle_Fan, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</code></pre>
Bei <b>glDrawArrays(...</b> ist der erste Parameter das wichtigste, hier wird angegeben, wie die Vektor-Koordinaten gezeichnet werden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne GL_TRIANGLE</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Gelb</font></i>
  glUniform1f(X_ID, -<font color="#0077BB">0</font>.<font color="#0077BB">9</font>);
  glUniform1f(Y_ID, -<font color="#0077BB">0</font>.<font color="#0077BB">7</font>);
  glBindVertexArray(VBTriangles.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Triangles));

  <i><font color="#FFFF00">// Zeichne GL_TRIANGLE_STRIP</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Rot</font></i>
  glUniform1f(X_ID, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>);
  glUniform1f(Y_ID, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>);
  glBindVertexArray(VBTriangle_Strip.VAO);
  glDrawArrays(GL_TRIANGLE_STRIP, <font color="#0077BB">0</font>, Length(Triangle_Strip));

  <i><font color="#FFFF00">// Zeichne GL_TRIANGLE_FAN</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Grün</font></i>
  glUniform1f(X_ID, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  glUniform1f(Y_ID, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>);
  glBindVertexArray(VBTriangle_Fan.VAO);
  glDrawArrays(GL_TRIANGLE_FAN, <font color="#0077BB">0</font>, Length(Triangle_Fan));</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Da die Koordinaten nur als 2D gespeichert sind, wird im Vertex-Shader der Z-Wert auf 0.0 gesetzt.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

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

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> Color;  <i><font color="#FFFF00">// Farbe von Uniform</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>

</html>
