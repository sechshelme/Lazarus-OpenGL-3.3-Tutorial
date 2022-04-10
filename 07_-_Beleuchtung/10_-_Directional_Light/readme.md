<html>
<img src="image.png" alt="Selfhtml"><br><br>
Das Directional-Light entspricht in etwa dem Sonnen-Licht, die Lichtstrahlen kommen alle von der gleichen Richtung.<br>
Im Grunde ist die Sonne auch ein Punktlicht, aber auf der Erde nimmt man es als Directional-Light war.<br>
Im Beispiel von Rechts.<br>
<br>
Im ersten Beispiel wurde die Beleuchung mit Acos und Pi berechnet.<br>
Dieser Umweg kann man sich sparen, es gibt zwar so ein kleiner Rechnungsfehler, aber diesen kann man getrost ingnorieren.<br>
Dies hat sogar den Vorteil, wen der Einstrahlwinkel des Lichtes flacher als 90° ist, ist die Beleuchtungsstärke gleich null.<br>
Als was flacher als 90° ist, ist negativ.<br>
Für dies gibt es in GLSL eine fertige Funktion <b>clamp</b>, mit der kann man einen Bereich festlegen.<br>
So das es in diesem Beispiel keinen Wert < <b>0.0</b> oder > <b>1.0</b> gibt.<br>
<br>
Der einzige Unterschied zu vorherigem Beispiel ist im Shader-Code. Auch der Hintergrund wurde etwas dunkler gemacht, das man den Licht-Effekt besser sieht.<br>
<br>
Bei dem Lichtpositions-Vector ist es egal, wie weit die Lichtquelle weg ist, da der Vektor nur die Lichtrichtung angeben muss.<br>
Meistens nimmt man aber einen <b>Einheitsvektor</b>, das ist ein Vektor mit der Länge <b>1.0</b>.<br>
Die Lichtposition wird im Vertex-Shader als Konstante definiert.<br>
<hr><br>
<hr><br>
Hier sieht man, das anstelle von arcos und Pi, <b>clamp</b> verwendet wurde.<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<i><font color="#FFFF00">// Das Licht kommt von Rechts.</font></i>
<b><font color="#008800">#define</font></b> LightPos <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                         <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;               <i><font color="#FFFF00">// Matrix des Modell, ohne Frustumeinfluss.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                    <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>

<b><font color="0000BB">float</font></b> light(<b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b>  v1 = normalize(p);       <i><font color="#FFFF00">// Vektoren normalisieren,</font></i>
  <b><font color="0000BB">vec3</font></b>  v2 = normalize(n);       <i><font color="#FFFF00">// so das die Länge des Vektors immer 1.0 ist.</font></i>
  <b><font color="0000BB">float</font></b> d  = dot(v1, v2);        <i><font color="#FFFF00">// Skalarprodukt aus beiden Vektoren berechnen.</font></i>
  <b><font color="0000BB">float</font></b> c  = clamp(d, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Alles > 1.0 und < 0.0, wird zwischen 0.0 und 1.0 gesetzt.</font></i>
  <b><font color="0000BB">return</font></b> c;                      <i><font color="#FFFF00">// Lichtstärke als Rückgabewert.</font></i>
}

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position  = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">vec3</font></b>  Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  <b><font color="0000BB">float</font></b> col    = light(LightPos, Normal);

  Color        = <b><font color="0000BB">vec4</font></b>(col, col, col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec4</font></b> Color;     <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>

</html>
