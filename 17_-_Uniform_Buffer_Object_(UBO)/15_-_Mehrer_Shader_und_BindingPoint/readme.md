<html>
<img src="image.png" alt="Selfhtml"><br><br>
In diesem Beispiel wird gezeigt, was der <b>BindingPoint</b> für einen Einfluss hat.<br>
Es werden 3 Shader erzeugt, das es einfacher ist, habe ich 3mal die gleichen Shader-Sourcen genommen.<br>
Bei 2 Shadern werden die UBO-Daten mit dem <b>BindingPoint 0</b> verbunden, der einzelne Shader mit <b>BindingPoint</b> 1.<br>
<hr><br>
Es werden drei UNOs angelegt.<br>
Die Uniform IDs werden füür jeden Shader einzeln ID gebraucht.<br>
Daher habe ich es in einem Record zusammengefasst.<br>
<br>
Man sieht auch, das 2 BindingPoints verwendet werden.<br>
<pre><code><b><font color="0000BB">var</font></b>
  UBO: <b><font color="0000BB">record</font></b>
    Rubin, Jade, Smaragdgruen: GLuint;        <i><font color="#FFFF00">// Puffer-Zeiger</font></i>
  <b><font color="0000BB">end</font></b>;

  ShaderData: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">2</font>] <b><font color="0000BB">of</font></b> <b><font color="0000BB">record</font></b>
    Shader: TShader;
    Material_ID,
    ModelMatrix_ID,
    Matrix_ID: GLint;
  <b><font color="0000BB">end</font></b>;

  bindingPoint0: gluint = <font color="#0077BB">0</font>;
  bindingPoint1: gluint = <font color="#0077BB">1</font>;</code></pre>
Es werden 3 Shader geladen in die Uniform-IDs ausgelesen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">var</font></b>
  i: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">2</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">with</font></b> ShaderData[i] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
      <b><font color="0000BB">with</font></b> Shader <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
        UseProgram;
        Matrix_ID := UniformLocation(<font color="#FF0000">'Matrix'</font>);
        ModelMatrix_ID := UniformLocation(<font color="#FF0000">'ModelMatrix'</font>);

        Material_ID := UniformBlockIndex(<font color="#FF0000">'Material'</font>); <i><font color="#FFFF00">// ID aus dem Shader holen.</font></i>
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</code></pre>
Material-Daten in den UBO-Puffer laden und binden.<br>
<br>
Man sieht, das beim Shader[2] ein anderer BindingPoint verwendet wird.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  <i><font color="#FFFF00">// Puffer für Rubin anlegen.</font></i>
  <b><font color="0000BB">with</font></b> Material <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    ambient := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">17</font>, <font color="#0077BB">0</font>.<font color="#0077BB">01</font>, <font color="#0077BB">0</font>.<font color="#0077BB">01</font>);
    diffuse := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">61</font>, <font color="#0077BB">0</font>.<font color="#0077BB">04</font>, <font color="#0077BB">0</font>.<font color="#0077BB">04</font>);
    specular := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">73</font>, <font color="#0077BB">0</font>.<font color="#0077BB">63</font>, <font color="#0077BB">0</font>.<font color="#0077BB">63</font>);
    shininess := <font color="#0077BB">76</font>.<font color="#0077BB">8</font>;
  <b><font color="0000BB">end</font></b>;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Rubin);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  <i><font color="#FFFF00">// Puffer für Jade anlegen.</font></i>
  <b><font color="0000BB">with</font></b> Material <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    ambient := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">14</font>, <font color="#0077BB">0</font>.<font color="#0077BB">22</font>, <font color="#0077BB">0</font>.<font color="#0077BB">16</font>);
    diffuse := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">54</font>, <font color="#0077BB">0</font>.<font color="#0077BB">89</font>, <font color="#0077BB">0</font>.<font color="#0077BB">63</font>);
    specular := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">32</font>, <font color="#0077BB">0</font>.<font color="#0077BB">32</font>, <font color="#0077BB">0</font>.<font color="#0077BB">32</font>);
    shininess := <font color="#0077BB">12</font>.<font color="#0077BB">8</font>;
  <b><font color="0000BB">end</font></b>;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Jade);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  <i><font color="#FFFF00">// Puffer für Smaragdgruen anlegen.</font></i>
  <b><font color="0000BB">with</font></b> Material <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    ambient := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">02</font>, <font color="#0077BB">0</font>.<font color="#0077BB">17</font>, <font color="#0077BB">0</font>.<font color="#0077BB">02</font>);
    diffuse := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">08</font>, <font color="#0077BB">0</font>.<font color="#0077BB">81</font>, <font color="#0077BB">0</font>.<font color="#0077BB">08</font>);
    specular := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">63</font>, <font color="#0077BB">0</font>.<font color="#0077BB">73</font>, <font color="#0077BB">0</font>.<font color="#0077BB">63</font>);
    shininess := <font color="#0077BB">76</font>.<font color="#0077BB">8</font>;
  <b><font color="0000BB">end</font></b>;
  glBindBuffer(GL_UNIFORM_BUFFER, UBO.Smaragdgruen);
  glBufferData(GL_UNIFORM_BUFFER, sizeof(TMaterial), @Material, GL_DYNAMIC_DRAW);

  <i><font color="#FFFF00">// Verbindung mit dem Shader aufbauen.</font></i>
  <b><font color="0000BB">with</font></b> ShaderData[<font color="#0077BB">0</font>] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint0);
  <b><font color="0000BB">end</font></b>;

  <b><font color="0000BB">with</font></b> ShaderData[<font color="#0077BB">1</font>] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint0);
  <b><font color="0000BB">end</font></b>;

  <b><font color="0000BB">with</font></b> ShaderData[<font color="#0077BB">2</font>] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glUniformBlockBinding(Shader.ID, Material_ID, bindingPoint1);
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// Die Puffer das erste mal binden.</font></i>
  <i><font color="#FFFF00">// Das sieht man, das der Shader[2] mit Jade gebunden wird.</font></i>
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Rubin);
  glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint1, UBO.Jade);
</code></pre>
Die Scene wird drei mal mit unterschiedlichen Shadern gezeichnet.<br>
Um die UBO muss man da sich nicht kümmern, das diese mit dem BindingPoint gebunden sind.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  scal, d: single;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);  <i><font color="#FFFF00">// Frame und Tiefen-Buffer löschen.</font></i>

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  glBindVertexArray(VBCube.VAO);

  d := <font color="#0077BB">6</font>.<font color="#0077BB">0</font>;
  scal := <font color="#0077BB">10</font>;

  <i><font color="#FFFF00">// --- Zeichne Kugeln</font></i>

  <b><font color="0000BB">with</font></b> ShaderData[<font color="#0077BB">0</font>] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d, d, d);
    Matrix.Scale(scal);
    Matrix := ModelMatrix * Matrix;

    Matrix.Uniform(ModelMatrix_ID);                        <i><font color="#FFFF00">// Erste Übergabe an den Shader.</font></i>

    Matrix := FrustumMatrix * WorldMatrix *  Matrix;       <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(SphereVertex) * <font color="#0077BB">3</font>);
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// --- Zeichne Kugeln</font></i>

  <b><font color="0000BB">with</font></b> ShaderData[<font color="#0077BB">1</font>] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d + <font color="#0077BB">30</font>, d, d);
    Matrix.Scale(scal);
    Matrix := ModelMatrix * Matrix;

    Matrix.Uniform(ModelMatrix_ID);                        <i><font color="#FFFF00">// Erste Übergabe an den Shader.</font></i>

    Matrix := FrustumMatrix * WorldMatrix *  Matrix;       <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(SphereVertex) * <font color="#0077BB">3</font>);
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// --- Zeichne Kugeln</font></i>

  <b><font color="0000BB">with</font></b> ShaderData[<font color="#0077BB">2</font>] <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Shader.UseProgram;

    Matrix.Identity;
    Matrix.Translate(d - <font color="#0077BB">30</font>, d, d);
    Matrix.Scale(scal);
    Matrix := ModelMatrix * Matrix;

    Matrix.Uniform(ModelMatrix_ID);                        <i><font color="#FFFF00">// Erste Übergabe an den Shader.</font></i>

    Matrix := FrustumMatrix * WorldMatrix *  Matrix;       <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>

    Matrix.Uniform(Matrix_ID);
    glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(SphereVertex) * <font color="#0077BB">3</font>);
  <b><font color="0000BB">end</font></b>;

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</code></pre>
Es wird nur der BindingPoint 0 geändert.<br>
Somit sit man beim <b>Shader[2]</b> der mit <b>BindingPoint 1</b> gebunden ist keine Änderung.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer2Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  m: integer = <font color="#0077BB">0</font>;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">case</font></b> m <b><font color="0000BB">of</font></b>
    <font color="#0077BB">0</font>: <b><font color="0000BB">begin</font></b>
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Rubin);
    <b><font color="0000BB">end</font></b>;
    <font color="#0077BB">1</font>: <b><font color="0000BB">begin</font></b>
      glBindBufferBase(GL_UNIFORM_BUFFER, bindingPoint0, UBO.Smaragdgruen);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;

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

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<i><font color="#FFFF00">// Daten für Fragment-shader</font></i>
<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataOut;

<i><font color="#FFFF00">// Matrix des Modeles, ohne Frustum-Beeinflussung.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;

<i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;

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

<i><font color="#FFFF00">// Daten vom Vertex-Shader</font></i>
<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataIn;

<b><font color="0000BB">layout</font></b> (std140) <b><font color="0000BB">uniform</font></b> Material {
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
