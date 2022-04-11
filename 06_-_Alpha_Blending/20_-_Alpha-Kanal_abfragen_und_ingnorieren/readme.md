<html>
    <b><h1>06 - Alpha Blending</h1></b>
    <b><h2>20 - Alpha-Kanal abfragen und ingnorieren</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Bei Texturen mit Alphablending gibt es noch eine einfacher Variante als sortieren.<br>
Voraus gesetzt der Alphakanal ist voll transparent.<br>
<br>
Wen es transparent ist, wird einfach kein Pixel gezeichnet und dadurch wird auch der Z-Buffer nicht aktualisiert.<br>
Dies spielt sich im FragmentShader ab.<br>
<hr><br>
Es empfieht sich trotzdem immer die Objecte mit Alpha-Blending zum Schluss zu zeichnen.<br>
Aber es muss nicht mehr sortiert werden.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<br>
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);        <i><font color="#FFFF00">// Frame und Tiefen-Puffer löschen.</font></i>
<br>
  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);
<br>
  Shader.UseProgram;
<br>
  glBindVertexArray(VBQuad.VAO);
<br>
  <i><font color="#FFFF00">// --- Zeichne Boden</font></i>
  SandTextur.ActiveAndBind;                                   <i><font color="#FFFF00">// Boden-Textur binden</font></i>
  Matrix.Identity;
  Matrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  Matrix.Scale(<font color="#0077BB">10</font>.<font color="#0077BB">0</font>);
  Matrix.RotateA(Pi / <font color="#0077BB">2</font>);
<br>
  Matrix := FrustumMatrix * WorldMatrix * GroundPos * Matrix; <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>
<br>
  Matrix.Uniform(Matrix_ID);                                  <i><font color="#FFFF00">// Matrix dem Shader übergeben.</font></i>
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));          <i><font color="#FFFF00">// Zeichnet einen kleinen Würfel.</font></i>
<br>
  <i><font color="#FFFF00">// --- Zeichne Bäume</font></i>
  BaumTextur.ActiveAndBind;                                   <i><font color="#FFFF00">// Baum-Textur binden</font></i>
<br>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> TreeCount - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Matrix.Identity;
    Matrix.Translate(TreePosArray[i]);                        <i><font color="#FFFF00">// Die Bäume an die richtige Position bringen</font></i>
<br>
    Matrix := FrustumMatrix * WorldMatrix * Matrix;           <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>
<br>
    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
  <b><font color="0000BB">end</font></b>;
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;  <i><font color="#FFFF00">// Textur-Koordinaten</font></i>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec2</font></b> UV0;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                  <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0         = inUV;                 <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
Hier wird abgefragt, ob der Pixel transparent ist, wen ja wird er nicht ausgegeben und<br>
dadurch wird der Z-Buffer nicht aktualisiert. Dadurch werden Objecte hinter der transparent Textur trozdem gezeichnet.<br>
<br>
Da die Kanten der Baume nicht voll transparent sind, habe ich einen Mittelwert von 0.5 genommen.<br>
Da muss man abschätzen, wie streng die Prüfung sein soll.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> UV0;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;
<br>
<b><font color="0000BB">void</font></b> main()
{
  <b><font color="0000BB">vec4</font></b> c = texture( Sampler, UV0 );
  <b><font color="0000BB">if</font></b> (c.a &gt; <font color="#0077BB">0</font>.<font color="#0077BB">5</font>) {
    FragColor =  c;
  } <b><font color="0000BB">else</font></b> {
    <b><font color="0000BB">discard</font></b>; <i><font color="#FFFF00">// Wen transparent, Pixel nicht ausgeben.</font></i>
  }
}
</code></pre>
<br>
</html>
