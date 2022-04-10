    <b><h1>50 - Instancing</h1></b>
    <b><h2>20 - VertexAttribDivisor</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit <b>VertexAttribDivisor</b> kann man nicht nur bestimmen, das es sich im ein Instance-Attribut handelt.<br>
Man kann auch festlegen, das ein Attribut-Wert mehrmals verwendet wird, bevor er um eins weiter springt.<br>
Im Beispiel sieht man, das der Farb-Wert vier mal verwendet wird, bevor der nächste wert kommt.<br>
<hr><br>
Für die Farben werden nur 4 Werte benötigt. Diese werden als Konstante deklariert,<br>
da diese sich zur Laufzeit nicht mehr ändern.<br>
<pre><code><b><font color="0000BB">const</font></b>
  Quad: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace3D =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));

  Instance_Color: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">3</font>] <b><font color="0000BB">of</font></b> TVector3f =
    ((<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));</pre></code>
Rechtecke gibt es 16 Stück, die Matrizen dafür sind dynamisch.<br>
<pre><code><b><font color="0000BB">var</font></b>
  Instance_Matrix: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">15</font>] <b><font color="0000BB">of</font></b> TMatrix;</pre></code>
Mit <b>glVertexAttribDivisor(...</b> kann man nicht nur bestimmen, das es sich um ein Instance-Attribut handelt.<br>
Sondern man kann auch sagen wie viel mal ein Attribut-Wert verwendet wird.<br>
Dies geschieht mit dem zweiten Parameter.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  glBindVertexArray(VBTriangle.VAO);

  <i><font color="#FFFF00">// Vektor</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.Pos);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
  glVertexAttribDivisor(<font color="#0077BB">0</font>, <font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// Instance Color</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iColor);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Instance_Color), @Instance_Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">1</font>);
  glVertexAttribPointer(<font color="#0077BB">1</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
  glVertexAttribDivisor(<font color="#0077BB">1</font>, <font color="#0077BB">4</font>); <i><font color="#FFFF00">// Wert 4x verwenden.</font></i>

  <i><font color="#FFFF00">// Instance Matrix</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iMatrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(TMatrix) * Length(Instance_Matrix), <b><font color="0000BB">nil</font></b>, GL_STATIC_DRAW);
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">3</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glEnableVertexAttribArray(i + <font color="#0077BB">2</font>);
    glVertexAttribPointer(i + <font color="#0077BB">2</font>, <font color="#0077BB">4</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, SizeOf(TMatrix), Pointer(i * <font color="#0077BB">16</font>));
    glVertexAttribDivisor(i + <font color="#0077BB">2</font>, <font color="#0077BB">1</font>); <i><font color="#FFFF00">// Wert 1x verwenden.</font></i>
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Matrizen drehen und anschliessend, neu laden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  r: GLfloat = <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  r += <font color="#0077BB">0</font>.<font color="#0077BB">01</font>;
  <b><font color="0000BB">if</font></b> r > <font color="#0077BB">2</font> * pi <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    r -= <font color="#0077BB">2</font> * pi;
  <b><font color="0000BB">end</font></b>;

  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">15</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Instance_Matrix[i].Identity;
    Instance_Matrix[i].Scale(<font color="#0077BB">0</font>.<font color="#0077BB">25</font>, <font color="#0077BB">0</font>.<font color="#0077BB">05</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
    Instance_Matrix[i].RotateC(Pi * <font color="#0077BB">2</font> / <font color="#0077BB">16</font> * i + r);
    Instance_Matrix[i].TranslateLocalspace(<font color="#0077BB">2</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">end</font></b>;

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iMatrix);
  glBufferSubData(GL_ARRAY_BUFFER, <font color="#0077BB">0</font>, SizeOf(TMatrix) * Length(Instance_Matrix), @Instance_Matrix);

  ogc.Invalidate;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> position;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> instance_color;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">2</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">mat4</font></b> instance_Matrix;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position = instance_Matrix * <b><font color="0000BB">vec4</font></b>(position, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Color       = <b><font color="0000BB">vec4</font></b>(instance_color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}

</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec4</font></b> Color;      <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>

