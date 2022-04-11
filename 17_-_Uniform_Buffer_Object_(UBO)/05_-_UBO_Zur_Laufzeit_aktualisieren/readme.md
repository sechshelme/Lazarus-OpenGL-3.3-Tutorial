<html>
    <b><h1>17 - Uniform Buffer Object (UBO)</h1></b>
    <b><h2>05 - UBO Zur Laufzeit aktualisieren</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
UBO-Daten können auch zur Laufzeit geändert/neu geladen werden, so wie es beim Vertex-Puffer auch geht.<br>
Auf diese Art, werden die Uniform-Daten aktualisiert. Dies ersetzt die Aktualisierung mit <b>glUniformxxx</b>.<br>
<br>
In diesem Beispiel wird das Material der Kugeln gewechselt, abwechslungsweise Rubin oder Jade.<br>
Dazu wird alle 1s die UBO-Daten aktualisiert.<br>
<hr><br>
Es werden zwei Materialien gebraucht, welche abwechslungsweise neu geladen werden.<br>
<pre><code=pascal><b><font color="0000BB">type</font></b>
  TMaterial = <b><font color="0000BB">record</font></b>
    ambient: TVector3f;      <i><font color="#FFFF00">// Umgebungslicht</font></i>
    pad0: GLfloat;           <i><font color="#FFFF00">// padding 4Byte</font></i>
    diffuse: TVector3f;      <i><font color="#FFFF00">// Farbe</font></i>
    pad1: GLfloat;           <i><font color="#FFFF00">// padding 4Byte</font></i>
    specular: TVector3f;     <i><font color="#FFFF00">// Spiegelnd</font></i>
    shininess: GLfloat;      <i><font color="#FFFF00">// Glanz</font></i>
  <b><font color="0000BB">end</font></b>;
<br>
<b><font color="0000BB">var</font></b>
  mRubin, mJade: TMaterial;</code></pre>
Material-Daten in den UBO-Puffer laden und binden<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">var</font></b>
  bindingPoint: gluint = <font color="#0077BB">0</font>;
<b><font color="0000BB">begin</font></b>
  <i><font color="#FFFF00">// Material-Werte inizialisieren</font></i>
  <b><font color="0000BB">with</font></b> mRubin <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    ambient := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">17</font>, <font color="#0077BB">0</font>.<font color="#0077BB">01</font>, <font color="#0077BB">0</font>.<font color="#0077BB">01</font>);
    diffuse := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">61</font>, <font color="#0077BB">0</font>.<font color="#0077BB">04</font>, <font color="#0077BB">0</font>.<font color="#0077BB">04</font>);
    specular := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">73</font>, <font color="#0077BB">0</font>.<font color="#0077BB">63</font>, <font color="#0077BB">0</font>.<font color="#0077BB">63</font>);
    shininess := <font color="#0077BB">76</font>.<font color="#0077BB">8</font>;
  <b><font color="0000BB">end</font></b>;
<br>
  <b><font color="0000BB">with</font></b> mJade <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    ambient := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">14</font>, <font color="#0077BB">0</font>.<font color="#0077BB">22</font>, <font color="#0077BB">0</font>.<font color="#0077BB">16</font>);
    diffuse := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">54</font>, <font color="#0077BB">0</font>.<font color="#0077BB">89</font>, <font color="#0077BB">0</font>.<font color="#0077BB">63</font>);
    specular := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">32</font>, <font color="#0077BB">0</font>.<font color="#0077BB">32</font>, <font color="#0077BB">0</font>.<font color="#0077BB">32</font>);
    shininess := <font color="#0077BB">12</font>.<font color="#0077BB">8</font>;
  <b><font color="0000BB">end</font></b>;
<br>
  <i><font color="#FFFF00">// Speicher für UBO reservieren</font></i>
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), <b><font color="0000BB">nil</font></b>, GL_DYNAMIC_DRAW);
<br>
  <i><font color="#FFFF00">// UBO mit dem Shader verbinden</font></i>
  glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint, UBO);
<br>
  <i><font color="#FFFF00">// Timer manuell aufrufen, so das die ersten Daten in den UBO-kopiert werden.</font></i>
  Timer2Timer(<b><font color="0000BB">nil</font></b>);</code></pre>
Hier sieht man gut, wie die UBO-Daten aktualisiert werden.<br>
Der Timer wird alle 1s aufgerufen.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.Timer2Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  m: integer = <font color="#0077BB">0</font>;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">case</font></b> m <b><font color="0000BB">of</font></b>
    <font color="#0077BB">0</font>: <b><font color="0000BB">begin</font></b>
      glBindBuffer(GL_UNIFORM_BUFFER, UBO);
      glBufferSubData(GL_UNIFORM_BUFFER, <font color="#0077BB">0</font>, sizeof(TMaterial), @mRubin);
    <b><font color="0000BB">end</font></b>;
    <font color="#0077BB">1</font>: <b><font color="0000BB">begin</font></b>
      glBindBuffer(GL_UNIFORM_BUFFER, UBO);
      glBufferSubData(GL_UNIFORM_BUFFER, <font color="#0077BB">0</font>, sizeof(TMaterial), @mJade);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
<br>
  Inc(m);
  <b><font color="0000BB">if</font></b> m &gt; <font color="#0077BB">1</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    m := <font color="#0077BB">0</font>;
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
Der Shader ist der selbe wie im ersten Beispiel.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>
<br>
<i><font color="#FFFF00">// Daten für Fragment-shader</font></i>
<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataOut;
<br>
<i><font color="#FFFF00">// Matrix des Modeles, ohne Frustum-Beeinflussung.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;
<br>
<i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position    = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
<br>
  DataOut.Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<i><font color="#FFFF00">// Licht</font></i>
<b><font color="#008800">#define</font></b> Lposition  <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">35</font>.<font color="#0077BB">0</font>, <font color="#0077BB">17</font>.<font color="#0077BB">5</font>, <font color="#0077BB">35</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> Lambient   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">8</font>)
<b><font color="#008800">#define</font></b> Ldiffuse   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1</font>.<font color="#0077BB">5</font>)
<br>
<i><font color="#FFFF00">// Daten vom Vertex-Shader</font></i>
<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataIn;
<br>
<b><font color="0000BB">layout</font></b> (std140) <b><font color="0000BB">uniform</font></b> Material {
  <b><font color="0000BB">vec3</font></b>  Mambient;   <i><font color="#FFFF00">// Umgebungslicht</font></i>
  <b><font color="0000BB">vec3</font></b>  Mdiffuse;   <i><font color="#FFFF00">// Farbe</font></i>
  <b><font color="0000BB">vec3</font></b>  Mspecular;  <i><font color="#FFFF00">// Spiegelnd</font></i>
  <b><font color="0000BB">float</font></b> Mshininess; <i><font color="#FFFF00">// Glanz</font></i>
};
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;
<br>
<b><font color="0000BB">vec3</font></b> Light(<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> nn = normalize(n);
  <b><font color="0000BB">vec3</font></b> np = normalize(p);
  <b><font color="0000BB">vec3</font></b> diffuse;   <i><font color="#FFFF00">// Licht</font></i>
  <b><font color="0000BB">vec3</font></b> specular;  <i><font color="#FFFF00">// Reflektion</font></i>
  <b><font color="0000BB">float</font></b> angele = max(dot(nn, np), <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">if</font></b> (angele &gt; <font color="#0077BB">0</font>.<font color="#0077BB">0</font>) {
    <b><font color="0000BB">vec3</font></b> eye = normalize(np + <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>));
    specular = pow(max(dot(eye, nn), <font color="#0077BB">0</font>.<font color="#0077BB">0</font>), Mshininess) * Mspecular;
    diffuse  = angele * Mdiffuse * Ldiffuse;
  } <b><font color="0000BB">else</font></b> {
    specular = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    diffuse  = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  }
  <b><font color="0000BB">return</font></b> (Mambient * Lambient) + diffuse + specular;
}
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Light(Lposition - DataIn.Pos, DataIn.Normal), <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
<br>
</code></pre>
<br>
</html>
