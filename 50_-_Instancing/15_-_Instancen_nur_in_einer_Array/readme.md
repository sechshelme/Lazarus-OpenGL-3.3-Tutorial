<!DOCTYPE html>
<html>
    <b><h1>50 - Instancing</h1></b>
    <b><h2>15 - Instancen nur in einer Array</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Vorher hatte es für jedes Instance-Attribut eine eigene Array gehabt.<br>
Jetzt sind alle Attribute in einer Array, dies macht den Code einiges übersichtlicher.<br>
Dafür ist die Übergabe mit <b>glVertexAttribPointer(...</b> ein wenig komplizierter.<br>
Siehe [[Lazarus - OpenGL 3.3 Tutorial - Vertex-Puffer - Nur eine Array]].<br>
<hr><br>
Die Deklaration der Array. Es ist nur noch eine Array.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TData = <b><font color="0000BB">record</font></b>
    Scale: GLfloat;
    Matrix: TMatrix;
    Color: TVector3f;
  <b><font color="0000BB">end</font></b>;

<b><font color="0000BB">var</font></b>
  Data: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..InstanceCount - <font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TData;</pre></code>
Das es ein wenig einfacher wird, habe ich <b>ofs</b> verwendet.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  ofs, i: integer;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  glBindVertexArray(VBQuad.VAO);

  <i><font color="#FFFF00">// --- Normale Vektordaten</font></i>
  <i><font color="#FFFF00">// Daten für Vektoren</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// --- Instancen</font></i>
  ofs := <font color="#0077BB">0</font>;
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Data), @Data, GL_STATIC_DRAW);

  <i><font color="#FFFF00">// Instance Size</font></i>
  glEnableVertexAttribArray(<font color="#0077BB">1</font>);
  glVertexAttribPointer(<font color="#0077BB">1</font>, <font color="#0077BB">1</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, SizeOf(TData), <b><font color="0000BB">nil</font></b>);
  glVertexAttribDivisor(<font color="#0077BB">1</font>, <font color="#0077BB">1</font>);
  Inc(ofs, SizeOf(GLfloat));

  <i><font color="#FFFF00">// Instance Matrix</font></i>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">3</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glEnableVertexAttribArray(i + <font color="#0077BB">2</font>);
    glVertexAttribPointer(i + <font color="#0077BB">2</font>, <font color="#0077BB">4</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, SizeOf(TData), Pointer(ofs));
    glVertexAttribDivisor(i + <font color="#0077BB">2</font>, <font color="#0077BB">1</font>);
    Inc(ofs, SizeOf(TVector4f));
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// Instance Color</font></i>
  glEnableVertexAttribArray(<font color="#0077BB">6</font>);
  glVertexAttribPointer(<font color="#0077BB">6</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, SizeOf(TData), Pointer(ofs));
  glVertexAttribDivisor(<font color="#0077BB">6</font>, <font color="#0077BB">1</font>);
<b><font color="0000BB">end</font></b>;</pre></code>
An der Zeichenroutine ändert sich nichts.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO.Instance);
  glBufferSubData(GL_ARRAY_BUFFER, <font color="#0077BB">0</font>, SizeOf(Data), @Data);

  glDrawArraysInstanced(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>, InstanceCount);

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
Matrizen neu berechnen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Length(Data) - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Data[i].Matrix.RotateC(<font color="#0077BB">0</font>.<font color="#0077BB">02</font>);
  <b><font color="0000BB">end</font></b>;

  ogcDrawScene(Sender);  <i><font color="#FFFF00">// Neu zeichnen</font></i>
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
Am Shader hat sich nichts geändert.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="#008800">#define</font></b> Instance_Count <font color="#0077BB">200</font>

<i><font color="#FFFF00">// Vektor-Daten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPos;

<i><font color="#FFFF00">// Instancen</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">float</font></b> Size;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">2</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">mat4</font></b> mat;
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">6</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> Color;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec3</font></b> col;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>((inPos * Size), <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  col = Color;
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> col;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>

</html>
