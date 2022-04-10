<html>
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>45 - Index-Puffer</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die Indicien, kann man auch von Anfang an ins VRAM laden, so müssen die Daten nich jedes mal mit <b>glDrawElements(...</b> neu übegeben werden.<br>
Dafür gibt es den <b> Index Buffer Objects</b> (IBO).<br>
Das Laden geschieht ähnlich wie mit den Vertex-Daten.<br>
<hr><br>
Die Deklaration der Vektor-Koordianten und Indicien Konstanten, dies ist gleich wie ohne Buffer.<br>
<pre><code><b><font color="0000BB">const</font></b>
  <i><font color="#FFFF00">// --- Dreieck</font></i>
  <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
  Triangle: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> TVertex3f =
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">7</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));
  <i><font color="#FFFF00">// Indicien ( Reihenfolge )</font></i>
  Triangle_Indices: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> GLint = (<font color="#0077BB">0</font>, <font color="#0077BB">1</font>, <font color="#0077BB">2</font>);

  <i><font color="#FFFF00">// --- Quadrat</font></i>
  <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
  Quad: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">3</font>] <b><font color="0000BB">of</font></b> TVertex3f =
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));
  <i><font color="#FFFF00">// Indicien ( Reihenfolge )</font></i>
  Quad_Indices: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> GLint = (<font color="#0077BB">0</font>, <font color="#0077BB">1</font>, <font color="#0077BB">2</font>, <font color="#0077BB">0</font>, <font color="#0077BB">2</font>, <font color="#0077BB">3</font>);</code></pre>
Der IBO muss noch deklariert werden.<br>
Das Erzeugen des IBI-Puffer geht gleich wie beim VBO-Puffer.<br>
Hier werden die IBO-Daten in den Buffer geladen, dies geschieht ähnlich, wie bei den Vertex-Daten.<br>
Der Unterschied ist der zweite Parameter, dieser muss <b>GL_ELEMENT_ARRAY_BUFFER</b> sein.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  <i><font color="#FFFF00">// --- Daten für das Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);

  <i><font color="#FFFF00">// VBO der Vertex-Koordinaten</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Triangle), @Triangle, GL_STATIC_DRAW);

  <i><font color="#FFFF00">// IBO binden und mit den Indices-Daten laden</font></i>
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBTriangle.IBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Triangle_Indices), @Triangle_Indices, GL_STATIC_DRAW);

  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// --- Daten für das Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);

  <i><font color="#FFFF00">// VBO der Vertex-Koordinaten</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);

  <i><font color="#FFFF00">// IBO binden und mit den Indices-Daten laden</font></i>
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, VBQuad.IBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Quad_Indices), @Quad_Indices, GL_STATIC_DRAW);

  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</code></pre>
Da die Indicien im IBO gespeichert sind muss der dritte Paramter bei <b>glDrawElements(...</b>, nil sein.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   <i><font color="#FFFF00">// Linien</font></i>
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glDrawElements(GL_TRIANGLES, Length(Triangle_Indices), GL_UNSIGNED_INT, <b><font color="0000BB">Nil</font></b>);  <i><font color="#FFFF00">// Hier Nil</font></i>

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawElements(GL_TRIANGLES, Length(Quad_Indices), GL_UNSIGNED_INT, <b><font color="0000BB">Nil</font></b>);      <i><font color="#FFFF00">// Hier Nil</font></i></code></pre>
IBO Freigabe ist glech wie bei dem VBO.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  Shader.Free;

  glDeleteBuffers(<font color="#0077BB">1</font>, @VBTriangle.IBO);  <i><font color="#FFFF00">// Indices-Buffer freigeben.</font></i>
  glDeleteBuffers(<font color="#0077BB">1</font>, @VBQuad.IBO);</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  <b><font color="0000BB">vec3</font></b> col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Mint</font></i>
  outColor = <b><font color="0000BB">vec4</font></b>(col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>

</html>
