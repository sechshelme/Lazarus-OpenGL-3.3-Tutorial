<html>
    <b><h1>02 - Shader</h1></b>
    <b><h2>45 - Variablen Namen auslesen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Es ist auch möglich aus dem <b>Shader auszulesen</b>, welche Variablen dort verwendet werden.<br>
In diesem Beispiel werden <b>Attribut</b>, <b>Uniform</b> und <b>Uniform-Blöcke</b> ausgelesen.<br>
Für was man <b>Uniform-Blöcke</b> verwendet, wird in einem späteren Kapitel behandelt.<br>
Auch die Beleuchtung, etc. wird später behandelt.<br>
<hr><br>
Mit <b>glGetProgramiv(...</b> wird ermittelt, wie viele Variablen dieses Typen hat.<br>
Mit <b>glGetActiveAttrib(...</b> wird der Bezeichner der Variable ausgelesen. Typ gibt die Art der Variable an, zB. <b>vec3</b>, <b>mat4</b>, etc.<br>
Der komplexe Beleuchtungs-Shader wird später beschrieben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.MenuItem1Click(Sender: TObject);
<b><font color="0000BB">var</font></b>
  s: ansistring;
  i, Count, len, size, Typ: integer;
  sl: TStringList;

<b><font color="0000BB">begin</font></b>
  sl := TStringList.Create;

  sl.Add(<font color="#FF0000">'Attribute:'</font>);
  SetLength(s, <font color="#0077BB">255</font>);
  glGetProgramiv(Shader.ID, GL_ACTIVE_ATTRIBUTES, @Count);
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Count - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glGetActiveAttrib(Shader.ID, i, <font color="#0077BB">255</font>, len, size, Typ, @s[<font color="#0077BB">1</font>]);
    sl.Add(copy(s, <font color="#0077BB">0</font>, len) + <font color="#FF0000">'    '</font> + IntToStr(Typ));
  <b><font color="0000BB">end</font></b>;
  sl.Add(<font color="#FF0000">''</font>);

  sl.Add(<font color="#FF0000">'Uniform:'</font>);
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORMS, @Count);
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Count - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glGetActiveUniform(Shader.ID, i, <font color="#0077BB">255</font>, len, size, Typ, @s[<font color="#0077BB">1</font>]);
    sl.Add(copy(s, <font color="#0077BB">0</font>, len) + <font color="#FF0000">'    '</font> + IntToStr(Typ));
  <b><font color="0000BB">end</font></b>;
  sl.Add(<font color="#FF0000">''</font>);

  sl.Add(<font color="#FF0000">'Uniform-Blöcke:'</font>);
  glGetProgramiv(Shader.ID, GL_ACTIVE_UNIFORM_BLOCKS, @Count);
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> Count - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glGetActiveUniformBlockName(Shader.ID, i, <font color="#0077BB">255</font>, @len, @s[<font color="#0077BB">1</font>]);
    sl.Add(copy(s, <font color="#0077BB">0</font>, len) + <font color="#FF0000">'    '</font> + IntToStr(Typ));
  <b><font color="0000BB">end</font></b>;

  ShowMessage(sl.Text);
  sl.Free;
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
Hier wurde noch eine Variable <b>KeineVerwendung</b> deklariert, da diese von Compiler wegoptimiert wurde, wird so auch nicht aufgelistet.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<i><font color="#FFFF00">// Attribute</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<i><font color="#FFFF00">// Uniform-Variablen</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec4</font></b> KeineVerwendung; <i><font color="#FFFF00">// Wird nicht angezeigt, da nicht verwendet.</font></i>

<i><font color="#FFFF00">// Daten für Fragment-shader</font></i>
<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataOut;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position    = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  DataOut.Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<i><font color="#FFFF00">// Licht</font></i>
<b><font color="#008800">#define</font></b> Lposition  <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">35</font>.<font color="#0077BB">0</font>, <font color="#0077BB">17</font>.<font color="#0077BB">5</font>, <font color="#0077BB">35</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> Lambient   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">8</font>)
<b><font color="#008800">#define</font></b> Ldiffuse   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1</font>.<font color="#0077BB">5</font>)

<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataIn;

<i><font color="#FFFF00">// Der Uniform-Block</font></i>
<b><font color="0000BB">layout</font></b>(std140) <b><font color="0000BB">uniform</font></b> Material {
  <b><font color="0000BB">vec3</font></b>  Mambient;   <i><font color="#FFFF00">// Umgebungslicht</font></i>
  <b><font color="0000BB">vec3</font></b>  Mdiffuse;   <i><font color="#FFFF00">// Farbe</font></i>
  <b><font color="0000BB">vec3</font></b>  Mspecular;  <i><font color="#FFFF00">// Spiegelnd</font></i>
  <b><font color="0000BB">float</font></b> Mshininess; <i><font color="#FFFF00">// Glanz</font></i>
};

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;

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

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Light(Lposition - DataIn.Pos, DataIn.Normal), <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}

</code></pre>

</html>
