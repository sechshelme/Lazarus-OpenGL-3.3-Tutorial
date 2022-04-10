<html>
<img src="image.png" alt="Selfhtml"><br><br>
Mit Bump-Maping kann man eine Oberfläche noch realistischer gestalten.<br>
Da viele Oberflächen nicht absolut flach sind, so wie die Fugen im Beispiel, drift das Licht nicht immer gleichen Winkel auf die gesamte Oberfläche.<br>
Um dies zu simulieren, nimmt man eine Textur, welche Winkelkorreturen enthält, dies ist eine <b>Normal-Map</b><br>
<br>
Lazarus-Seitig läuft die genau gleich ab, wie wen man eine enfache Textur lädt.<br>
Die ganze Berechnung läuft im Fragment-Shader ab.<br>
<br>
Der Rest der Beleuchtung läuft gleich ab, so wie bei den anderen Beleuchtungen auch.<br>
<hr><br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location =  <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inUV;     <i><font color="#FFFF00">// Textur-Koordinaten</font></i>

<i><font color="#FFFF00">// Daten für Fragment-Shader</font></i>
<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
  <b><font color="0000BB">vec3</font></b> Normal;
  <b><font color="0000BB">vec2</font></b> UV;
} DataOut;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position    = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  DataOut.Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;
  DataOut.UV     = inUV;
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<br>
Hier sieht man, das die <b>Normal-Map</b> zur Normalen addiert wird.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<i><font color="#FFFF00">// Beleuchtungs-Parameter</font></i>
<b><font color="#008800">#define</font></b> LightPos <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">100</font>.<font color="#0077BB">0</font>, <font color="#0077BB">100</font>.<font color="#0077BB">0</font>, <font color="#0077BB">50</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> ambient  <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>)

<i><font color="#FFFF00">// Textur-Sampler für Normal-Map</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">sampler2D</font></b> Sampler;

<i><font color="#FFFF00">// Daten vom Vertex-Shader</font></i>
<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
  <b><font color="0000BB">vec3</font></b> Normal;
  <b><font color="0000BB">vec2</font></b> UV;
} DataIn;

<i><font color="#FFFF00">// Farb-Ausgabe.</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;

<i><font color="#FFFF00">// Ein einfaches Directional-Light.</font></i>
<b><font color="0000BB">vec4</font></b> light(<b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> v1 = normalize(p);
  <b><font color="0000BB">vec3</font></b> v2 = normalize(n);
  <b><font color="0000BB">float</font></b> d = dot(v1, v2);
  <b><font color="0000BB">vec3</font></b> c  = <b><font color="0000BB">vec3</font></b>(clamp(d, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>));
  <b><font color="0000BB">return</font></b> <b><font color="0000BB">vec4</font></b>(c, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  <i><font color="#FFFF00">// Ein Ambient-Light festlegen.</font></i>
  outColor = <b><font color="0000BB">vec4</font></b>(ambient, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// Normal-Map zu Normalen addieren.</font></i>
  <b><font color="0000BB">vec3</font></b> n   = DataIn.Normal + normalize(texture2D(Sampler, DataIn.UV).rgb * <font color="#0077BB">2</font>.<font color="#0077BB">0</font> - <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// Einfache Lichtberechnung.</font></i>
  outColor = light(LightPos - DataIn.pos, n);
}
</pre></code>

</html>
