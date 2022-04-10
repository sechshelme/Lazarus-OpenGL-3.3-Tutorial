    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>45 - Spot Light, mit Normale</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Jetzt wird auch die normale berücksicht. Somit wird nur die Vorderseite der Dreiecke beleuchtet, so wie es beim Punktlicht auch der Fall ist.<br>
Diese Berechnung funktioniert genau gleich, wie beim Punktlicht. Somit wird auch wieder eine <b>Normale</b> gebraucht.<br>
<hr><br>
Hier wird die Kegelberechnung ausgeführt.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataOut;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                    <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position    = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  DataOut.Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<br>
Zuerst wird geprüft, ob das Fragment sich im Lichtkegel befindet.<br>
Anschliessend wird die Flächenanleuchtung gleich berechnet, wie beim Punktlicht.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="#008800">#define</font></b> ambient <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>)
<b><font color="#008800">#define</font></b> red     <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> green   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> blue    <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)

<b><font color="#008800">#define</font></b> PI      <font color="#0077BB">3</font>.<font color="#0077BB">1415</font>
<b><font color="#008800">#define</font></b> Cutoff  cos(PI / <font color="#0077BB">2</font> / <font color="#0077BB">4</font>)

<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataIn;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> RedOn;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> GreenOn;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> BlueOn;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> RedLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> GreenLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> BlueLightPos;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<i><font color="#FFFF00">// Prüfen ob Fragment in Lichtkegel.</font></i>
<b><font color="0000BB">bool</font></b> isCone(<b><font color="0000BB">vec3</font></b> LightPos) {

  <b><font color="0000BB">vec3</font></b> lp = LightPos;

  <b><font color="0000BB">vec3</font></b> lightDirection = normalize(DataIn.pos - lp);
  <b><font color="0000BB">vec3</font></b> spotDirection  = normalize(-LightPos);

  <b><font color="0000BB">float</font></b> angle = dot(spotDirection, lightDirection);
  angle = max(angle, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">if</font></b>(angle > Cutoff) {
    <b><font color="0000BB">return</font></b> <b><font color="0000BB">true</font></b>;
  } <b><font color="0000BB">else</font></b> {
    <b><font color="0000BB">return</font></b> <b><font color="0000BB">false</font></b>;
  }
}

<i><font color="#FFFF00">// Lichtstärke anhand der Normale.</font></i>
<b><font color="0000BB">float</font></b> light(<b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> v1 = normalize(p);     <i><font color="#FFFF00">// Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.</font></i>
  <b><font color="0000BB">vec3</font></b> v2 = normalize(n);
  <b><font color="0000BB">float</font></b> d = dot(v1, v2);      <i><font color="#FFFF00">// Skalarprodukt aus beiden Vektoren berechnen.</font></i>
  <b><font color="0000BB">return</font></b> clamp(d, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  outColor = <b><font color="0000BB">vec4</font></b>(ambient, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">if</font></b> (RedOn) {
    <b><font color="0000BB">if</font></b> (isCone(RedLightPos)) {
      outColor.rgb += light(RedLightPos - DataIn.pos, DataIn.Normal) * red;
    }
  }
  <b><font color="0000BB">if</font></b> (GreenOn) {
    <b><font color="0000BB">if</font></b> (isCone(GreenLightPos)) {
      outColor.rgb += light(GreenLightPos - DataIn.pos, DataIn.Normal) * green;
    }
  }
  <b><font color="0000BB">if</font></b> (BlueOn) {
    <b><font color="0000BB">if</font></b> (isCone(BlueLightPos)) {
      outColor.rgb += light(BlueLightPos - DataIn.pos, DataIn.Normal) * blue;
    }
  }
}

</pre></code>

