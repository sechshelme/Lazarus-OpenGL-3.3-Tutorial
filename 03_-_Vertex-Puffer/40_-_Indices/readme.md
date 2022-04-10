<html>
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>40 - Indices</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Normalerweise, werden die Polygone der Reihenfolge der Vertex-Konstanten abgearbeitet.<br>
Man kann aber auch selbst bestimmen, welche Koordinate abgearbeitet werden.<br>
Dafür muss man eine Indices-Array kreieren, welche die Reihenfolge der Koordinaten bestimmt.<br>
<br>
Der Unterschied zum einfachen Zeichenn ist, das ich noch eine Indicen-Array brauche.<br>
Und das Zeichnen ist vor allem anders.<br>
Man verwendet anstelle von <b>glDrawArrays(...</b>, <b>glDrawElements(...</b>, welche als dritten Parameter noch einen Zeiger auf die Indicen-Array bekommt.<br>
<hr><br>
Die Deklaration der Vektor-Koordianten und Indicien Konstanten.<br>
Beim Dreieck sieht man keinen Vorteil bei der Indicien-Version, da das Dreieck sowieso nur aus einem Polygon besteht.<br>
Beim Quadrat, konnten so schon zwei Koordinaten eingespart werden, da man die Eckpunkte nur einmal angeben muss.<br>
Bei der einfachen Variante bräuchte es dafür sechs Eckpunte, weil dort zwei Punkte doppelt vorhandnen sein müssen.<br>
Bei einem Würfel ist der Vorteil noch grösser, da braucht es bei der einfachen Version 36 Punkte, bei der Indicien-Version, nur 8 Stück !<br>
<br>
Mit den Indicen kann ich sagen, zeichen von Punkt 0-1-2 und von Punkt 0-2-3.<br>
<br>
<pre><code>3 - 2
| / |
0 - 1</code></pre>
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
Bei <b>glDrawElements(...</b>, muss als dritten Parameter der Zeiger auf die Indicien-Array übergeben werden.<br>
Ansonsten geht das Zeichen gleich, wie bei der einfachen Methode.<br>
Der Polygonmodus wurde auf Linien umgestellt, so das man die Polygone besser sieht.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   <i><font color="#FFFF00">// Linien</font></i>
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glDrawElements(GL_TRIANGLES, Length(Triangle_Indices), GL_UNSIGNED_INT, @Triangle_Indices);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawElements(GL_TRIANGLES, Length(Quad_Indices), GL_UNSIGNED_INT, @Quad_Indices);</code></pre>
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
  <b><font color="0000BB">vec3</font></b> col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Gelb</font></i>
  outColor = <b><font color="0000BB">vec4</font></b>(col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>

</html>
