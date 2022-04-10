<html>
<img src="image.png" alt="Selfhtml"><br><br>
Stellt man eine Textur auf einem Trapez dar, gibt es unschöne Verzerrungen, das sieht man beim Trapez Links gut.<br>
Die beiden Trapeze Rechts sind korrigiert, auf 2 verschiedene Varianten. Der Unterschied sieht man im Shader.<br>
<hr><br>
Es hat eine 2. Variante für die Textur-Koordinaten gegeben, welche einen Wert für eine Perspektivenkorrektur hat.<br>
Diese enthält einen Korrekturwert für die Perspektive.<br>
<pre><code><b><font color="0000BB">const</font></b>
  <i><font color="#FFFF00">// Koordinaten für Trapez.</font></i>
  TrapezeVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector3f =
    ((-<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>),
    (-<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));

  <i><font color="#FFFF00">// Normale unkorrigierte Textur-Koordinaten.</font></i>
  TextureNormalVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector2f =
    ((-<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>),
    (-<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>));

  <i><font color="#FFFF00">// Textur-Koordinaten mit Perspektivenkorrektur.</font></i>
  TexturePerspVertex1: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector3f =
    ((-<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">2</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>),
    (-<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">2</font>), (<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">2</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>));</code></pre>
Vertex-Daten hochladen, dies ist nichts besonderes, ausser, das für die Perspektivenkorrigierte Variante auch ein Vec3 ist.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  pic: TPicture;
  i: integer;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  glBindVertexArray(VBO_Trapeze.VAO);

  <i><font color="#FFFF00">// Vektoren Trapez</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Vertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TrapezeVertex), @TrapezeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Unkorrigierte Textur-Koordinaten</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Textur[<font color="#0077BB">0</font>]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureNormalVertex), @TextureNormalVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">2</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Perspektivenkorrigiert Variante</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBO_Trapeze.VBO.Textur[<font color="#0077BB">1</font>]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TexturePerspVertex1), @TexturePerspVertex1, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">11</font>);
  glVertexAttribPointer(<font color="#0077BB">11</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);</code></pre>
Zeichnen der 3 verschiedenne Varianten.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Textur.ActiveAndBind;  <i><font color="#FFFF00">// Textur binden.</font></i>

  <i><font color="#FFFF00">// Zeichne Unkorrigiert (Links)</font></i>
  Shader.UseProgram;
  glUniform1i(Variante_ID, <font color="#0077BB">0</font>);
  TransMatrix.Identity;
  TransMatrix.Translate(-<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix := ScaleMatrix * TransMatrix;
  ProdMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VBO_Trapeze.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(TrapezeVertex));

  <i><font color="#FFFF00">// Zeichne korrigiert Variante 1 (Rechts Oben)</font></i>
  glUniform1i(Variante_ID, <font color="#0077BB">1</font>);
  TransMatrix.Identity;
  TransMatrix.Translate(<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix := ScaleMatrix * TransMatrix;
  ProdMatrix.Uniform(Matrix_ID);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(TrapezeVertex));

  <i><font color="#FFFF00">// Zeichne korrigiert Variante 2 (Rechts Unten)</font></i>
  glUniform1i(Variante_ID, <font color="#0077BB">2</font>);
  TransMatrix.Identity;
  TransMatrix.Translate(<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  ProdMatrix := ScaleMatrix * TransMatrix;
  ProdMatrix.Uniform(Matrix_ID);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(TrapezeVertex));

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV0;    <i><font color="#FFFF00">// Textur-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inUV1;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;

<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec2</font></b> UV0;
  <b><font color="0000BB">vec3</font></b> UV1;
} DataOut;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  DataOut.UV0 = inUV0;
  DataOut.UV1 = inUV1;
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec2</font></b> UV0;
  <b><font color="0000BB">vec3</font></b> UV1;
} DataIn;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler; <i><font color="#FFFF00">// Textursampler</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">int</font></b> variante;      <i><font color="#FFFF00">// Variante der Texturberechnung</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;

<b><font color="0000BB">void</font></b> main()
{
  <b><font color="0000BB">switch</font></b> (variante) {

    <i><font color="#FFFF00">// Unkorrigiert</font></i>
    <b><font color="0000BB">case</font></b> <font color="#0077BB">0</font>: FragColor = texture( Sampler, DataIn.UV0 );
            <b><font color="0000BB">break</font></b>;

    <i><font color="#FFFF00">// Korrigiert Variante 1</font></i>
    <b><font color="0000BB">case</font></b> <font color="#0077BB">1</font>: FragColor = texture( Sampler, DataIn.UV1.xy / DataIn.UV1.z );
            <b><font color="0000BB">break</font></b>;

    <i><font color="#FFFF00">// Korrigiert Variante 2</font></i>
    <b><font color="0000BB">case</font></b> <font color="#0077BB">2</font>: FragColor = texture2DProj( Sampler, DataIn.UV1 );
  }
}
</code></pre>
<hr><br>
<b>mauer.xpm:</b><br>
<pre><code>/* XPM */
static char *XPM_mauer[] = {
  "<font color="#0077BB">8</font> <font color="#0077BB">8</font> <font color="#0077BB">2</font> <font color="#0077BB">1</font>",
  "  c #<font color="#0077BB">882222</font>",
  "* c #<font color="#0077BB">442222</font>",
  "********",
  "*   *   ",
  "*   *   ",
  "*   *   ",
  "********",
  "  *   * ",
  "  *   * ",
  "  *   * "
};
</code></pre>

</html>
