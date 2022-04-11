<html>
    <b><h1>50 - Instancing</h1></b>
    <b><h2>00 - Einfachste Instance</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit <b>Instancing</b> hat man die Möglichkeit die Mesh mit <b>einem<b> glDraw... Aufruf mehrmals zu zeichnen.<br>
Bei dieser regelmässigen Anordnung ist dies sehr einfach.<br>
Man hat aber auch bei <b>Instancing</b> die Möglichkeit die Meshes X-beliebig anzuordnen.<br>
Dies wird in den nächsten Themen behandelt.<br>
<hr><br>
Das Zeichnen ist sehr einfach und übersichtlich geworden.<br>
Es braucht <b>keine</b> for-to-Schleifen für die Cube-Array, dieser Teile erledigt alles der Vertex-Shader.<br>
Die Matrix muss nur <b>einmal</b> berechnet werden, da es nur <b>einen</b> Aufruf von <b>glDraw...</b> gibt.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">const</font></b>
  s = <font color="#0077BB">10</font>;            <i><font color="#FFFF00">// Eine Seite hat 10 Würfel.</font></i>
  size = s * s * s;
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
  <i><font color="#FFFF00">// Die Matrizen werden nur einmal berechnet.</font></i>
  Matrix.Identity;
  Matrix.Scale(<font color="#0077BB">6</font>.<font color="#0077BB">0</font>);
  Matrix := ModelMatrix * Matrix;
  Matrix.Uniform(ModelMatrix_ID);
  Matrix := FrustumMatrix * WorldMatrix * Matrix;
  Matrix.Uniform(Matrix_ID);
<br>
  <i><font color="#FFFF00">// glDraw... muss nur einmal aufgerufen werden.</font></i>
  glDrawArraysInstanced(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(CubeVertex) * <font color="#0077BB">3</font>, size);
<br>
  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
Das grosse Arbeit bei Instancing leistet der Vertex-Shader.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="#008800">#define</font></b> size <font color="#0077BB">10</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>
<br>
<i><font color="#FFFF00">// Daten für Fragment-shader</font></i>
<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataOut;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  <b><font color="0000BB">vec3</font></b> p = inPos / <font color="#0077BB">2</font> - size / <font color="#0077BB">2</font>;
  p.x += gl_InstanceID % size;
  p.y += gl_InstanceID / size % size;
  p.z += gl_InstanceID / size /size;
<br>
  gl_Position    = Matrix * <b><font color="0000BB">vec4</font></b>(p, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
<br>
  DataOut.Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(p, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="#008800">#define</font></b> LightPos <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">50</font>.<font color="#0077BB">0</font>, <font color="#0077BB">10</font>.<font color="#0077BB">0</font>, <font color="#0077BB">50</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> Diffuse  <b><font color="0000BB">vec3</font></b>( <font color="#0077BB">1</font>.<font color="#0077BB">0</font>,  <font color="#0077BB">1</font>.<font color="#0077BB">0</font>,  <font color="#0077BB">0</font>.<font color="#0077BB">9</font>)
<br>

<i><font color="#FFFF00">// Daten vom Vertex-Shader</font></i>
<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataIn;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;
<br>
<b><font color="0000BB">float</font></b> light(<b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> v1 = normalize(p);
  <b><font color="0000BB">vec3</font></b> v2 = normalize(n);
  <b><font color="0000BB">float</font></b> d = dot(v1, v2);
  <b><font color="0000BB">return</font></b> clamp(d, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor      = <b><font color="0000BB">vec4</font></b>(<b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">05</font>), <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  outColor.rgb += <b><font color="0000BB">vec3</font></b>(light(LightPos - DataIn.pos, DataIn.Normal)) * Diffuse;
}
</code></pre>
<br>
</html>
