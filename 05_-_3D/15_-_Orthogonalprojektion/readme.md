<html>
    <b><h1>05 - 3D</h1></b>
    <b><h2>15 - Orthogonalprojektion</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Eine OpenGL-Scene wird immer in einem Bereich von <b>-1</b> bis <b>+1</b> in allen drei Achsen gezeichnet. Ist etwas ausserhalb dieses Bereiches, wird dies ignoriert.<br>
Um dies zu umgehen multipliziert man die Scene mit einer Ortho-Matrix.<br>
Für diesen Zweck habe ich eine Funtkion <b>TMatrix.Ortho(...</b>. Mit den sechs Parametern in der Funktion, kann man den gewünschten Bereich einstellen.<br>
<br>
Zusätzlich ist noch eine Welt-Matrix hinzugekommen. Damit wird die ganze Scene in den sichtbaren Bereich bewegt,<br>
<hr><br>
Deklaration der drei Matrixen.<br>
<pre><code=scal><b><font color="0000BB">var</font></b>
  OrthoMatrix,         <i><font color="#FFFF00">// Matrix für Ortho.</font></i>
  WorldMatrix,         <i><font color="#FFFF00">// Matrix für Welt.</font></i>
  Matrix: TMatrix;     <i><font color="#FFFF00">// Matrix, welche dem Shader übergeben wird.</font></i>
  Matrix_ID: GLint;    <i><font color="#FFFF00">// ID der Matrix für den Shader.</font></i></code></pre>
So sieht die Funktion aus: <b>Ortho(left, right, bottom, top, znear, zfar);</b>.<br>
Hier wird die OrthoMatrix erzeugt, und mit neuen Werten eingestellt.<br>
Im Beispiel ist dies eine Seitenlänge in allen Achsen um 24.0 (2 * 12.0).<br>
<br>
Die Skalierung der Welt-Matrix hat den Effekt, das die ganze Scene gezoomt wird.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">const</font></b>
  w = <font color="#0077BB">12</font>.<font color="#0077BB">0</font>;  <i><font color="#FFFF00">// Seiten-Länge</font></i>
<b><font color="0000BB">begin</font></b>
  Matrix.Identity;
  WorldMatrix.Identity;
  WorldMatrix.Scale(<font color="#0077BB">0</font>.<font color="#0077BB">75</font>);                    <i><font color="#FFFF00">// Welt-Matrix zoomen</font></i>
  OrthoMatrix.Ortho(-w, w, -w, +w, -w, +w);   <i><font color="#FFFF00">// Den Ortho-Bereich einstellen.</font></i></code></pre>
Hier werden die einzelnen kleinen Würfel gezeichnet, dabei sieht man gut, wie alle drei Matrizen mutipliziert werden.<br>
Die Matrizen könnte man auch im Shader multiplizieren, dafür müsste man einfach für jede Matrix eine Uniform deklarieren.<br>
Dies hat aber den Nachteil, das die Multiplikation bei jedem Vektor ausgeführt wird, bei Meshes mit hoher Vektor-Zahl merkt man dies bemerklich.<br>
<br>
Hier sieht man auch gut, das man eine Mesh nach dem Binden mehrmals gezeichnet werden kann.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  x, y, z: integer;
<b><font color="0000BB">const</font></b>
  d = <font color="#0077BB">1</font>.<font color="#0077BB">8</font>;  <i><font color="#FFFF00">// Abstand der Würfel.</font></i>
  s = <font color="#0077BB">4</font>;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);
<br>
  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);
<br>
  Shader.UseProgram;
<br>
  glBindVertexArray(VBCube.VAO);
<br>
  <i><font color="#FFFF00">// --- Zeichne Würfel</font></i>
<br>
  <b><font color="0000BB">for</font></b> x := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">for</font></b> y := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      <b><font color="0000BB">for</font></b> z := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 <i><font color="#FFFF00">// Matrix verschieben.</font></i>
<br>
        Matrix := OrthoMatrix * WorldMatrix * Matrix;          <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>
<br>
        Matrix.Uniform(Matrix_ID);                             <i><font color="#FFFF00">// Matrix dem Shader übergeben.</font></i>
        glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(CubeVertex) * <font color="#0077BB">3</font>); <i><font color="#FFFF00">// Zeichnet einen kleinen Würfel.</font></i>
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
Kamera um die Mesh bewegen.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  WorldMatrix.RotateA(<font color="#0077BB">0</font>.<font color="#0077BB">0123</font>);  <i><font color="#FFFF00">// Drehe um X-Achse</font></i>
  WorldMatrix.RotateB(<font color="#0077BB">0</font>.<font color="#0077BB">0234</font>);  <i><font color="#FFFF00">// Drehe um Y-Achse</font></i></code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol; <i><font color="#FFFF00">// Farbe</font></i>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                       <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben</font></i>
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                  <i><font color="#FFFF00">// Matrix für die Drehbewegung und Ortho</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec4</font></b> Color;     <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</code></pre>
<br>
</html>
