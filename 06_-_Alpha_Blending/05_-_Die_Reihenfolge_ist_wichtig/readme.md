<html>
<img src="image.png" alt="Selfhtml"><br><br>
Bei Polygonen, welche Alphablending enthalten, ist es wichtig, in welcher Reihenfolge sie gezeichnet werden.<br>
Das blaue Quadrat ist in beiden Fällen über das Rote Qudrat gezeichnet.<br>
Links wurde zuerst das rote Qudrat gezeichnet, Rechts ist es genau umgekehrt. Die Z-Position ist in beiden Fällen die gleiche.<br>
Im rechten Beispiel ist die darstellung falsch, weil das rote Rechteck später gezeichnet wurde. Der Z-Puffer erkennt nicht ob es um transparente Polygone handelt.<br>
Das man den Effekt noch stärker sieht, kann man den Alpha-Kanal auf <b>0.0</b> stellen.<br>
<br>
Man sollte sich angewöhnen, zuerst immer die untransparenten Polygone zu zeichnen und die durchsichtigen erst später.<br>
Auch sollte man berücksichtigen, das man zuerst die Elemente zeichnet, die von einem weiter weg sind.<br>
<br>
Ich weis, dies tönt einfacher, als es in der Praxis ist.<br>
Bei komplexen Szenen kommt man nicht um das sortieren der Meshes.<br>
<hr><br>
Für den Vertex-Puffer wird nur ein einfaches Quadrat gebraucht.<br>
Die Farbe und Alpha-Kanal werden per Uniform dem Shader übergeben.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TFace3f = <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> TVector3f;

<b><font color="0000BB">const</font></b>
  QuadVector: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace3f =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">3</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)));</pre></code>
Bei einem einfachen Quadrat ist InitScene sehr einfach gehalten.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);                  <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  glEnable(GL_BLEND);                                <i><font color="#FFFF00">// Alphablending an</font></i>
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); <i><font color="#FFFF00">// Sortierung der Primitiven von hinten nach vorne.</font></i>

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  <i><font color="#FFFF00">// --- Daten für Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);

  <i><font color="#FFFF00">// Vektor</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVector), @QuadVector, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);                     <i><font color="#FFFF00">// 10 ist die Location in inPos Shader.</font></i>
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</pre></code>
Zeichnen der 4 Rechtecke.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  col: TVector4f;
  TempMatrix: TMatrix;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);  <i><font color="#FFFF00">// Frame und Tiefen-Buffer löschen.</font></i>
  Shader.UseProgram;
  MatrixTrans.Identity;

  glBindVertexArray(VBQuad.VAO);

  <i><font color="#FFFF00">// --- Links ( Richtige Darstellung )</font></i>
  <i><font color="#FFFF00">// Rot</font></i>
  col := vec4(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  glUniform4fv(Color_ID, <font color="#0077BB">1</font>, @col);   <i><font color="#FFFF00">// Als Vektor</font></i>
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>);
  MatrixTrans.Uniform(MatrixRot_ID);                      <i><font color="#FFFF00">// MatrixTrans in den Shader.</font></i>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVector) * <font color="#0077BB">3</font>);
  MatrixTrans := TempMatrix;

  <i><font color="#FFFF00">// blau transparent</font></i>
  col := vec4(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>);
  glUniform4fv(Color_ID, <font color="#0077BB">1</font>, @col);   <i><font color="#FFFF00">// Als Vektor</font></i>
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>);
  MatrixTrans.Uniform(MatrixRot_ID);                      <i><font color="#FFFF00">// MatrixTrans in den Shader.</font></i>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVector) * <font color="#0077BB">3</font>);
  MatrixTrans := TempMatrix;


  <i><font color="#FFFF00">// --- Rechts ( Falsche Darstellung )</font></i>
  <i><font color="#FFFF00">// blau transparent</font></i>
  col := vec4(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">3</font>);
  glUniform4fv(Color_ID, <font color="#0077BB">1</font>, @col);   <i><font color="#FFFF00">// Als Vektor</font></i>
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>);
  MatrixTrans.Uniform(MatrixRot_ID);                      <i><font color="#FFFF00">// MatrixTrans in den Shader.</font></i>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVector) * <font color="#0077BB">3</font>);
  MatrixTrans := TempMatrix;

  <i><font color="#FFFF00">// Rot</font></i>
  col := vec4(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  glUniform4fv(Color_ID, <font color="#0077BB">1</font>, @col);   <i><font color="#FFFF00">// Als Vektor</font></i>
  TempMatrix := MatrixTrans;
  MatrixTrans.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>);
  MatrixTrans.Uniform(MatrixRot_ID);                      <i><font color="#FFFF00">// MatrixTrans in den Shader.</font></i>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVector) * <font color="#0077BB">3</font>);
  MatrixTrans := TempMatrix;

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Die Shader sind sehr einfach gehalten. Es hat nur zwei Uniform für die Matrix und dem Color mit Alpha.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;                        <i><font color="#FFFF00">// Matrix von Uniform</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Vektoren mit der Matrix multiplizieren.</font></i>
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec4</font></b> Color;
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color;
}
</pre></code>

</html>
