<html>
    <b><h1>15 - Material Eigenschaften</h1></b>
    <b><h2>10 - Material Spot Light</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Material-Eigenschaften sind auch mit Spot-Light möglich.<br>
Dies funktioniert etwa gleich, wie das Point-Light ohne Material-Eigenschaften.<br>
<br>
Bei diesem Beispiel, wird mit einer Taschenlampe in einen Jade-Würfel gezündet.<br>
<hr><br>
<hr><br>
Dieser Shader ist schon sehr komplex.<br>
Neben der Spotlichtberechnung, wird noch die Abschwächung des Lichtes berücksichtigt.<br>
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

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position    = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  DataOut.Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="#008800">#define</font></b> PI         <font color="#0077BB">3</font>.<font color="#0077BB">1415</font>

<i><font color="#FFFF00">// === Licht</font></i>
<b><font color="#008800">#define</font></b> Lposition  <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">100</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> Lambient   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">8</font>, <font color="#0077BB">1</font>.<font color="#0077BB">8</font>)
<b><font color="#008800">#define</font></b> Ldiffuse   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1000</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1000</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1000</font>.<font color="#0077BB">0</font>)

<i><font color="#FFFF00">// === Material ( Jade )</font></i>
<b><font color="#008800">#define</font></b> Mambient   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">14</font>, <font color="#0077BB">0</font>.<font color="#0077BB">22</font>, <font color="#0077BB">0</font>.<font color="#0077BB">16</font>)
<b><font color="#008800">#define</font></b> Mdiffuse   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">54</font>, <font color="#0077BB">0</font>.<font color="#0077BB">89</font>, <font color="#0077BB">0</font>.<font color="#0077BB">63</font>)
<b><font color="#008800">#define</font></b> Mspecular  <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">32</font>, <font color="#0077BB">0</font>.<font color="#0077BB">32</font>, <font color="#0077BB">0</font>.<font color="#0077BB">32</font>)
<b><font color="#008800">#define</font></b> Mshininess <font color="#0077BB">12</font>.<font color="#0077BB">8</font>

<i><font color="#FFFF00">// === Spotlicht Parameter</font></i>
<i><font color="#FFFF00">// Öffnungswinkel der Lampe</font></i>
<i><font color="#FFFF00">// 22.5°</font></i>
<b><font color="#008800">#define</font></b> Cutoff        cos(PI / <font color="#0077BB">2</font> / <font color="#0077BB">4</font>)

<i><font color="#FFFF00">// Lichtrichtung, brennt senkrecht in der Z-Achse.</font></i>
<b><font color="#008800">#define</font></b> spotDirection <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>)

<i><font color="#FFFF00">// === Für Abschwächung</font></i>
<i><font color="#FFFF00">// default 0.0</font></i>
<b><font color="#008800">#define</font></b> spotExponent  <font color="#0077BB">50</font>.<font color="#0077BB">0</font>

<i><font color="#FFFF00">// Diese Werte entsprechen Attenuation Parametern vom alten OpenGL.</font></i>
<i><font color="#FFFF00">// default 1.0</font></i>
<b><font color="#008800">#define</font></b> spotAttConst  <font color="#0077BB">1</font>.<font color="#0077BB">0</font>
<i><font color="#FFFF00">// default 0.0</font></i>
<b><font color="#008800">#define</font></b> spotAttLinear <font color="#0077BB">0</font>.<font color="#0077BB">0</font>
<i><font color="#FFFF00">// default 0.0</font></i>
<b><font color="#008800">#define</font></b> spotAttQuad   <font color="#0077BB">0</font>.<font color="#0077BB">1</font>


<i><font color="#FFFF00">// Daten vom Vertex-Shader</font></i>
<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataIn;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;

<i><font color="#FFFF00">// Abschwächung, abhängig vom Radius des Lichtes.</font></i>
<b><font color="0000BB">float</font></b> ConeAtt(<b><font color="0000BB">vec3</font></b> LightPos) {
  <b><font color="0000BB">vec3</font></b>  lightDirection = normalize(DataIn.Pos - LightPos);

  <b><font color="0000BB">float</font></b> D              = length(LightPos - DataIn.Pos);
  <b><font color="0000BB">float</font></b> attenuation    = <font color="#0077BB">1</font>.<font color="#0077BB">0</font> / (spotAttConst + spotAttLinear * D + spotAttQuad * D * D);

  <b><font color="0000BB">float</font></b> angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">if</font></b>(angle &gt; Cutoff) {
    <b><font color="0000BB">return</font></b> attenuation;
  } <b><font color="0000BB">else</font></b> {
    <b><font color="0000BB">return</font></b> <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  }
}

<i><font color="#FFFF00">// Abschwächung anhängig der Lichtentfernung zum Mesh.</font></i>
<b><font color="0000BB">float</font></b> ConeExp(<b><font color="0000BB">vec3</font></b> LightPos) {
  <b><font color="0000BB">vec3</font></b>  lightDirection = normalize(DataIn.Pos - LightPos);

  <b><font color="0000BB">float</font></b> angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">if</font></b>(angle &gt; Cutoff) {
    <b><font color="0000BB">return</font></b> pow(angle, spotExponent);
  } <b><font color="0000BB">else</font></b> {
    <b><font color="0000BB">return</font></b> <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  }
}

<i><font color="#FFFF00">// Lichtstärke und Material anhand der Normale.</font></i>
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

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  <b><font color="0000BB">float</font></b> c  = ConeAtt(Lposition) * ConeExp(Lposition); <i><font color="#FFFF00">// Beide Abschwächungen multipizieren.</font></i>
  outColor = <b><font color="0000BB">vec4</font></b>(<b><font color="0000BB">vec3</font></b>(c)  * Light(Lposition - DataIn.Pos, DataIn.Normal), <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}

</code></pre>

</html>
