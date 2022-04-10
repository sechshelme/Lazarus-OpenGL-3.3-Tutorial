<html>
<img src="image.png" alt="Selfhtml"><br><br>
Man kann für jede Instance einen eigenen Uniform-Wert zu ordnen. Dafür packt man die Uniform-Werte in ein Array,<br>
welches >= anzahl Instancen ist.<br>
<br>
Dieses Verfahren hat zwei Nachteile.<br>
1. Man muss die Anzahl Intancen von Anfang an wissen.<br>
2. Die Anzahl Uniform-Werte ist begrenzt, bei diesem Beispiel und einem Intel4000 ist bei gut 800 Instancen Schluss.<br>
<br>
Diese Nachteile kann man umgehen, wen man anstelle von Uniformen VertexAttrib verwendet, dazu im nächasten Thema.<br>
<hr><br>
Die Anzahl Instance<br>
<pre><code><b><font color="0000BB">const</font></b>
  InstanceCount = <font color="#0077BB">200</font>;</pre></code>
Die Deklaration, der Paramter für die einzelnen Instancen.<br>
Die Size könnte man mit der Matrix kombinieren, aber hier geht es um die Funktionsweise der Uniform-Übergaben.<br>
<pre><code><b><font color="0000BB">var</font></b>
  Matrix_ID, Color_ID, Size_ID: GLint;

  VBQuad: TVB;

  Data: <b><font color="0000BB">record</font></b>
    Size: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..InstanceCount - <font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> GLfloat;
    Matrix: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..InstanceCount - <font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TMatrix;
    Color: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..InstanceCount - <font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TVector3f;
  <b><font color="0000BB">end</font></b>;</pre></code>
Das Auslesen der UniformID. Dies geschieht gleich wie bei einfachen Uniformen.<br>
Die Instancen-Parameter mit zufälligen Werten belegen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;
  Size_ID := Shader.UniformLocation(<font color="#FF0000">'Size'</font>);
  Matrix_ID := Shader.UniformLocation(<font color="#FF0000">'mat'</font>);
  Color_ID := Shader.UniformLocation(<font color="#FF0000">'Color'</font>);

  glGenVertexArrays(<font color="#0077BB">1</font>, @VBQuad.VAO);

  glGenBuffers(<font color="#0077BB">1</font>, @VBQuad.VBO);

  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Length(Data.Matrix) - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Data.Size[i] := Random() * <font color="#0077BB">20</font> + <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
    Data.Matrix[i].Identity;
    Data.Matrix[i].Translate(<font color="#0077BB">1</font>.<font color="#0077BB">5</font> - Random * <font color="#0077BB">3</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">5</font>- Random * <font color="#0077BB">3</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Data.Color[i] := vec3(Random, Random, Random);
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</pre></code>
Die Übergabe der Uniform-Werte. Da es sich um Arrays handelt, muss man noch die Länge der Array übergeben.<br>
Auch sieht man gut, das mal <b>glDrawArraysInstanced(...</b> nur einmal aufrufen muss.<br>
Würde man dies ohne Instancen lössen, müsste man die Uniformübergabe und glDraw... 200x aufrufen.<br>
Da sieht man den Vorteil, es ist viel weniger Kominikation mit der Grafikkarte nötig.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  glUniform1fv(Size_ID, InstanceCount, @Data.Size);
  glUniformMatrix4fv(Matrix_ID, InstanceCount, <b><font color="0000BB">False</font></b>, @Data.Matrix);
  glUniform3fv(Color_ID, InstanceCount, @Data.Color);
  glDrawArraysInstanced(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>, InstanceCount);

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
Die Matrizen drehen.<br>
Dies muss man 200x machen, aber es sind nicht 200 Übergaben zur Grafikkarte nötig.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Length(Data.Matrix) - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Data.Matrix[i].RotateC(<font color="#0077BB">0</font>.<font color="#0077BB">02</font>);
  <b><font color="0000BB">end</font></b>;

  ogcDrawScene(Sender);  <i><font color="#FFFF00">// Neu zeichnen</font></i>
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
Hier sieht man, das mit <b>gl_InstanceID</b> auf die eizelnen Array-Elemente zugegriffen wird.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="#008800">#define</font></b> Instance_Count <font color="#0077BB">200</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPos;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">float</font></b> Size[Instance_Count];
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat[Instance_Count];
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> Color[Instance_Count];

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec3</font></b> col;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat[gl_InstanceID] * <b><font color="0000BB">vec4</font></b>((inPos * Size[gl_InstanceID]), <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  col = Color[gl_InstanceID];
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
