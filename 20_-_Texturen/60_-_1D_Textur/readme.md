<html>
    <b><h1>20 - Texturen</h1></b>
    <b><h2>60 - 1D Textur</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die meisten Texturen sind eine Bitmap(Foto) welche im 2D-Format vorliegen.<br>
Es gibt aber noch 1D und 3D-Texturen. Dieses Beispiel zeigt die Anwendung einer 1D-Textur.<br>
Eine 1D-Textur kann man sich am besten als eine farbige Linie vorstellen.<br>
<hr><br>
Die Texturkoordinaten sind nun keine Vectorenarray mehr sondern nur eine einfache Float-Array.<br>
<pre><code=pascal><b><font color="0000BB">const</font></b>
  QuadVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> TVector3f =       <i><font color="#FFFF00">// Koordinaten der Polygone.</font></i>
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));
<br>
  TextureVertex: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">5</font>] <b><font color="0000BB">of</font></b> GLfloat =
    (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">3</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">3</font>.<font color="#0077BB">0</font>, <font color="#0077BB">3</font>.<font color="#0077BB">0</font>);</code></pre>
Eine Einfache 1D-Textur mit 5 Pixeln.<br>
<pre><code=pascal><b><font color="0000BB">const</font></b>
  Textur24: <b><font color="0000BB">packed</font></b> <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">4</font>, <font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> byte =
    ((<font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>, <font color="#0077BB">$00</font>), (<font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>), (<font color="#0077BB">$00</font>, <font color="#0077BB">$00</font>, <font color="#0077BB">$</font>FF), (<font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF, <font color="#0077BB">$00</font>), (<font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF, <font color="#0077BB">$</font>FF));</code></pre>
Generieren des Texturbuffers.<br>
Dies geschieht gleich wie bei der normalen 2D-Textur.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  glGenTextures(<font color="#0077BB">1</font>, @textureID);  <i><font color="#FFFF00">// Erzeugen des Textur-Puffer.</font></i></code></pre>
Beim laden muss man bei den Textur-Befehlen beachten, das man <b>GL_TEXTURE_1D</b> nimmt.<br>
Beim VertexAttribut wird für die Textur-Koordinaten nur eine Float-Array übergeben.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  <i><font color="#FFFF00">// Textur binden.</font></i>
  glBindTexture(GL_TEXTURE_1D, textureID);
<br>
  <i><font color="#FFFF00">// Textur laden.</font></i>
  glTexImage1D(GL_TEXTURE_1D, <font color="#0077BB">0</font>, GL_RGB, <font color="#0077BB">5</font>, <font color="#0077BB">0</font>, GL_RGB, GL_UNSIGNED_BYTE, @Textur24);
<br>
  <i><font color="#FFFF00">// Ein minimalst Filter aktivieren, ansonsten bleibt die Ausgabe schwarz.</font></i>
  glTexParameterf(GL_TEXTURE_1D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
<br>
  <i><font color="#FFFF00">// Textur entbinden.</font></i>
  glBindTexture(GL_TEXTURE_1D, <font color="#0077BB">0</font>);
<br>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>
<br>
  <i><font color="#FFFF00">// Vektorkoordinaten</font></i>
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVertex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(QuadVertex), @QuadVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<br>
  <i><font color="#FFFF00">// Nur eine Float-Array</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOTex);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TextureVertex), @TextureVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">10</font>);
  glVertexAttribPointer(<font color="#0077BB">10</font>, <font color="#0077BB">1</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);
<b><font color="0000BB">end</font></b>;</code></pre>
Das Zeichnen ist nichts besonderes.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
<br>
  <i><font color="#FFFF00">// Textur binden.</font></i>
  glBindTexture(GL_TEXTURE_1D, textureID);
<br>
  Shader.UseProgram;
<br>
  ProdMatrix := ScaleMatrix * RotMatrix;
  ProdMatrix.Uniform(Matrix_ID);
<br>
  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(QuadVertex));
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Man beachte, das die UV-Koordinaten nur ein <b>Float</b> ist.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b>  inPos;   <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">float</font></b> inUV;    <i><font color="#FFFF00">// Textur-Koordinaten als Float-Array</font></i>
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">float</font></b> UV0;
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  UV0 = inUV;                           <i><font color="#FFFF00">// Textur-Koordinaten weiterleiten.</font></i>
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">in</font></b> <b><font color="0000BB">float</font></b> UV0;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler1D</font></b> Sampler;              <i><font color="#FFFF00">// Ein 1D-Sampler</font></i>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> FragColor;
<br>
<b><font color="0000BB">void</font></b> main()
{
  FragColor = texture( Sampler, UV0 );  <i><font color="#FFFF00">// UV0 ist nur ein Float.</font></i>
}
</code></pre>
<br>
</html>
