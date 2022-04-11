<html>
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>40 - Spot Light, einfacher Kegel</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Da es für ein Spotlicht mehrere Schritte braucht, wird dies in mehreren Beispielen gezeigt.<br>
<br>
In diesem Beispiel wird zuerst mal gezeigt, wie der Lichtkegen berechnet wird.<br>
Die Beleuchtung berechnung mit den Normalen wird zuerst mal ingnoriert.<br>
So sieht man gut, wie der Lichtkegel entsteht.<br>
<hr><br>
Bei einem Spotlicht, ist die Lichtposition kein Einheitsvektor mehr.<br>
Die Licht-Position ist ist die effektive Position der Lichtquelle, so wie es bei einer Taschenlampe auch der Fall ist.<br>
<br>
Da die <b>halbe</b> Seitenlänge der kompletten Meshes etwa 30.0 lang ist, wird das Licht in einem Radius von 25.0 positioniert.<br>
Die Lichtquelle befindet sich somit in dem kompletten Würfel-Körper.<br>
<br>
Als Versuch kann man den Radius mal auf 50.0 setzen, dann wird man sehen, das die Lichtquelle ausserhalb der Meshes ist.<br>
<br>
Es werden Einheitsvektoren um den Faktor <b>LichtPositionRadius</b> skaliert.<br>
<pre><code=scal><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">const</font></b>
  LichtPositionRadius = <font color="#0077BB">25</font>.<font color="#0077BB">0</font>;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">with</font></b> LightPos <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Red := vec3(-<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Red.Scale(LichtPositionRadius);
<br>
    Green := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
    Green.Scale(LichtPositionRadius);
<br>
    Blue := vec3(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
    Blue.Scale(LichtPositionRadius);
  <b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
Hier wird die Kegelberechnung ausgeführt.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<br>
<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
} DataOut;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                    <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  DataOut.pos = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<br>
Der wichtigste Parameter ist der Ausstrahlwinkel der Lichtes.<br>
<br>
Man muss beachten, das der Winkel doppelt so gross wird. Somit hat Pi/2 einen Austrahlwinkel von 180°.<br>
1*Pi entpräche einem Ausstrahlwinkel von 380°, somit bekommt man ein Punkt-Licht.<br>
<br>
Für die Berechnung des Kegels wird ein Skalarprodukt verwendet.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="#008800">#define</font></b> ambient <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>)
<b><font color="#008800">#define</font></b> red     <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> green   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> blue    <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)
<br>
<b><font color="#008800">#define</font></b> PI      <font color="#0077BB">3</font>.<font color="#0077BB">1415</font>
<b><font color="#008800">#define</font></b> Cutoff  cos(PI / <font color="#0077BB">2</font> / <font color="#0077BB">4</font>)
<br>
<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
} DataIn;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> RedOn;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> GreenOn;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> BlueOn;
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> RedLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> GreenLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> BlueLightPos;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>
<br>
<i><font color="#FFFF00">// Prüfen ob Fragment in Lichtkegel</font></i>
<b><font color="0000BB">vec3</font></b> isCone(<b><font color="0000BB">vec3</font></b> LightPos) {
<br>
  <b><font color="0000BB">vec3</font></b> lp = LightPos;
<br>
  <b><font color="0000BB">vec3</font></b> lightDirection = normalize(DataIn.pos - lp);
  <b><font color="0000BB">vec3</font></b> spotDirection  = normalize(-LightPos);
<br>
  <b><font color="0000BB">float</font></b> angle = dot(spotDirection, lightDirection);
  angle = max(angle, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
<br>
  <b><font color="0000BB">if</font></b>(angle &gt; Cutoff) {
    <b><font color="0000BB">return</font></b> <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  } <b><font color="0000BB">else</font></b> {
    <b><font color="0000BB">return</font></b> <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  }
}
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  outColor = <b><font color="0000BB">vec4</font></b>(ambient, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">if</font></b> (RedOn) {
    outColor.rgb += isCone(RedLightPos) * red;
  }
  <b><font color="0000BB">if</font></b> (GreenOn) {
    outColor.rgb += isCone(GreenLightPos) * green;
  }
  <b><font color="0000BB">if</font></b> (BlueOn) {
    outColor.rgb += isCone(BlueLightPos) * blue;
  }
}
<br>
</code></pre>
<br>
</html>
