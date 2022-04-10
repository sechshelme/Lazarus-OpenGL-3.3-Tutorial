<img src="image.png" alt="Selfhtml"><br><br>
In diesem Beispiel werden Würfel anstelle der Kugeln verwendet.<br>
<br>
Das Licht wird immer noch im Vertex-Shader berechnet, die hat zwar den Vorteil, das es einges schneller geht als mit dem Fragmsnt-Shader.<br>
Dafür ist di Darstellung des Point-Lichtes unrealistisch. Das sieht man gut, wen man nur ein Würfel darstellt, da ist die Fläche eines Dreieckes sehr gross.<br>
Bei den Kugel war dieser Effekt kaum sichtbar, das sehr kleine Dreiecke verwendet werden.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="#008800">#define</font></b> ambient <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>)
<b><font color="#008800">#define</font></b> red     <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> green   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> blue    <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                         <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                    <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> RedOn;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> GreenOn;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> BlueOn;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> RedLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> GreenLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> BlueLightPos;

<b><font color="0000BB">float</font></b> light(<b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> v1 = normalize(p);     <i><font color="#FFFF00">// Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.</font></i>
  <b><font color="0000BB">vec3</font></b> v2 = normalize(n);
  <b><font color="0000BB">float</font></b> d = dot(v1, v2);      <i><font color="#FFFF00">// Skalarprodukt aus beiden Vektoren berechnen.</font></i>
  <b><font color="0000BB">return</font></b> clamp(d, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">vec3</font></b> Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  <b><font color="0000BB">vec3</font></b> pos    = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;

  Color = <b><font color="0000BB">vec4</font></b>(ambient, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">if</font></b> (RedOn) {
    <b><font color="0000BB">vec3</font></b> colRed = light(RedLightPos - pos, Normal) * red;
    Color.rgb += colRed;
  }
  <b><font color="0000BB">if</font></b> (GreenOn) {
    <b><font color="0000BB">vec3</font></b> colGreen = light(GreenLightPos - pos, Normal) * green;
    Color.rgb += colGreen;
  }
  <b><font color="0000BB">if</font></b> (BlueOn) {
    <b><font color="0000BB">vec3</font></b> colBlue = light(BlueLightPos - pos, Normal) * blue;
    Color.rgb += colBlue;
  }
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec4</font></b> Color;      <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>

