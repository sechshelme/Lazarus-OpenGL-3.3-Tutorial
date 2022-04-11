<html>
    <b><h1>50 - Instancing</h1></b>
    <b><h2>10 - Instance mit VertexAttribut</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier sind sogar 10'000'000 Instancen möglich, gegenüber der Uniform-Variante die bei gut 800 schon Schluss machte.<br>
Bei noch höheren Werten macht der FPC-Compiler Schluss, wieviel das die Grafikkarte vertägt, kann ich nicht sagen.<br>
Das es eine Diashow ist, das ist was anderes.<br>
<hr><br>
Die Anzahl Instance<br>
<pre><code=scal><b><font color="0000BB">const</font></b>
  InstanceCount = <font color="#0077BB">10000</font>;</code></pre>
Für die Instancen werden VBOs gebraucht.<br>
<pre><code=scal><b><font color="0000BB">type</font></b>
  TVB = <b><font color="0000BB">record</font></b>
    VAO: GLuint;
    VBO: <b><font color="0000BB">record</font></b>
      Vertex,
      I_Size, I_Matrix, I_Color: GLuint;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</code></pre>
Die Deklaration, der Arrays ist gleich wie bei der Uniform-Übergaben.<br>
<pre><code=scal><b><font color="0000BB">var</font></b>
  VBQuad: TVB;
<br>
  Data: <b><font color="0000BB">record</font></b>
    Scale: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..InstanceCount - <font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> GLfloat;
    Matrix: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..InstanceCount - <font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TMatrix;
    Color: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..InstanceCount - <font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TVector3f;
  <b><font color="0000BB">end</font></b>;</code></pre>
VBO-Puffer für Instancen anlegen. Uniformen werden keine gebraucht.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;
<br>
  glGenVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);
<br>
  glGenBuffers(<font color="#0077BB">4</font>, @VBQuad.VBO);
<br>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Length(Data.Matrix) - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Data.Scale[i] := Random * <font color="#0077BB">2</font> + <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
    Data.Matrix[i].Identity;
    Data.Matrix[i].Translate(<font color="#0077BB">1</font>.<font color="#0077BB">5</font> - Random * <font color="#0077BB">3</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">5</font> - Random * <font color="#0077BB">3</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Data.Color[i] := vec3(Random, Random, Random);
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</code></pre>
Für die Instancen werden die Puffer gefüllt.<br>
Da für die Puffer nur Vektoren mit 1-4 Elemeten erlaubt sind, muss man die Matrix in 4 Vektoren unterteilen.<br>
Dabei werden auch 4 Attribut-Indexe gebraucht.<br>
Eine <b>glVertexAttribPointer(2, 16,...</b> geht leider nicht. Im Shader kann man es direkt als Matrix deklarieren.<br>
So was geht leider nicht:<br>
<pre><code=scal>  glVertexAttribPointer(<font color="#0077BB">2</font>, <font color="#0077BB">16</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);</code></pre>
Mit <b>glVertexAttribDivisor(...</b> teilt man mit das es sich um ein Instance-Attribut handelt.<br>
Der erste Parameter bestimmt, um welches Vertex-Attribut es sich handelt.<br>
Der Zweite sagt, das der Zeiger im Vertex-Attribut bei jedem Durchgang um <b>1</b> erhöt wird.<br>
Setzt man dort <b>0</b> ein, handelt es sich um ein gewöhnliches Attribut.<br>
Was Werte >1 bedeuten ist bei <b>VertexAttribDivisor</b> beschrieben.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>
<br>
  glBindVertexArray(VBQuad.VAO);
<br>
  <i><font color="#FFFF00">// --- Normale Vektordaten</font></i>
  <i><font color="#FFFF00">// Daten für Vektoren</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<br>
  <i><font color="#FFFF00">// --- Instancen</font></i>
  <i><font color="#FFFF00">// Instance Size</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Size);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Scale), @Data.Scale, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">1</font>);
  glVertexAttribPointer(<font color="#0077BB">1</font>, <font color="#0077BB">1</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
  glVertexAttribDivisor(<font color="#0077BB">1</font>, <font color="#0077BB">1</font>);
<br>
  <i><font color="#FFFF00">// Instance Matrix</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Matrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Matrix), <b><font color="0000BB">nil</font></b>, GL_STATIC_DRAW); <i><font color="#FFFF00">// Nur Speicher reservieren</font></i>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">3</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glEnableVertexAttribArray(i + <font color="#0077BB">2</font>);
    glVertexAttribPointer(i + <font color="#0077BB">2</font>, <font color="#0077BB">4</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, SizeOf(TMatrix), Pointer(i * <font color="#0077BB">16</font>));
    glVertexAttribDivisor(i + <font color="#0077BB">2</font>, <font color="#0077BB">1</font>);
  <b><font color="0000BB">end</font></b>;
<br>
  <i><font color="#FFFF00">// Instance Color</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Color);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data.Color), @Data.Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">6</font>);
  glVertexAttribPointer(<font color="#0077BB">6</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
  glVertexAttribDivisor(<font color="#0077BB">6</font>, <font color="#0077BB">1</font>);
<b><font color="0000BB">end</font></b>;</code></pre>
Die Instance Parameter werden einfache mit <b>glBufferSubData(....</b> übergeben.<br>
Es werden nur die Matrizen aktualisiert, die anderen Werte bleiben gleich.<br>
Will man eine andere Anzahl von Instance, dann muss man mit <b>glBufferData(...</b> mehr oder weniger Speicher reservieren.<br>
Dafür braucht man keine Uniformen.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
<br>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.I_Matrix);
  glBufferSubData(GL_ARRAY_BUFFER, <font color="#0077BB">0</font>, SizeOf(Data.Matrix), @Data.Matrix);
<br>
  glBindVertexArray(VBQuad.VAO);
  glDrawArraysInstanced(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>, InstanceCount);
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
Matrizen neu berechnen.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Length(Data.Matrix) - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Data.Matrix[i].RotateC(<font color="#0077BB">0</font>.<font color="#0077BB">02</font>);
  <b><font color="0000BB">end</font></b>;
<br>
  glBindVertexArray(VBQuad.VAO);
  ogcDrawScene(Sender);  <i><font color="#FFFF00">// Neu zeichnen</font></i>
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
Der Shader sieht sehr einfach aus.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="#008800">#define</font></b> Instance_Count <font color="#0077BB">200</font>
<br>
<i><font color="#FFFF00">// Vektor-Daten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPos;
<br>
<i><font color="#FFFF00">// Instancen</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">float</font></b> Size;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">2</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">mat4</font></b> mat;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">6</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> Color;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec3</font></b> col;
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>((inPos * Size), <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
<br>
  col = Color;
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>
<br>
<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> col;
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<br>
</html>
