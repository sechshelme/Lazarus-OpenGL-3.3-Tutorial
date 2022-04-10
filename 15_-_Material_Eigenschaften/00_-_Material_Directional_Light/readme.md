<img src="image.png" alt="Selfhtml"><br><br>
Nur eine Beleuchtung reicht nicht, das eine Mesh realistisch aussieht.<br>
Aus diesem Grund, kann man der Mesh Materialeigenschaften mitgeben, dies sind Reflektionen des Lichtes.<br>
Wen man zB. eine Gummi-Fläche anleuchtet, sieht dies anders aus, als bei einer Stahlfläche.<br>
Stahl reflektiert das Licht viel besser.<br>
Dieses Beispiel zeigt wie dies bei Gold aussieht. Wen man im INet nach <b>"OpenGL Material"</b> sucht,<br>
findet man viele Daten, welche man bei <b>Ambient</b>, <b>Diffuse</b>, <b>Specular</b> und <b>Shininess</b> eintragen muss.<br>
<br>
Bei diesem Beispiel sind die Kugeln aus Gold.<br>
<hr><br>
<hr><br>
Die Berechnung, ist ähnlich wie beim einfachen Licht. Zusätlich wird <b>Specular</b> zum normalen Licht addiert.<br>
<b>Specular</b> ist die Reflektion de Materiales.<br>
<b>Diffuse</b> ist die Farbe des Lichtes/Material.<br>
<br>
Im Shader sind alle Material-Eigenschaft als <b>#define</b> deklariert. Dies könnte man auch als <b>Uniform</b> übergeben.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<i><font color="#FFFF00">// Daten für Fragment-shader</font></i>
<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Normal;
} DataOut;

<i><font color="#FFFF00">// Matrix des Modeles, ohne Frustum-Beeinflussung.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;

<i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position    = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  DataOut.Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
}

</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<i><font color="#FFFF00">// Licht</font></i>
<b><font color="#008800">#define</font></b> Lposition  <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> Lambient   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, <font color="#0077BB">1</font>.<font color="#0077BB">2</font>, <font color="#0077BB">1</font>.<font color="#0077BB">2</font>)
<b><font color="#008800">#define</font></b> Ldiffuse   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1</font>.<font color="#0077BB">5</font>)

<i><font color="#FFFF00">// Material ( Gold )</font></i>
<b><font color="#008800">#define</font></b> Mambient   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">25</font>, <font color="#0077BB">0</font>.<font color="#0077BB">20</font>, <font color="#0077BB">0</font>.<font color="#0077BB">07</font>)
<b><font color="#008800">#define</font></b> Mdiffuse   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">75</font>, <font color="#0077BB">0</font>.<font color="#0077BB">60</font>, <font color="#0077BB">0</font>.<font color="#0077BB">23</font>)
<b><font color="#008800">#define</font></b> Mspecular  <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">63</font>, <font color="#0077BB">0</font>.<font color="#0077BB">56</font>, <font color="#0077BB">0</font>.<font color="#0077BB">37</font>)
<b><font color="#008800">#define</font></b> Mshininess <font color="#0077BB">51</font>.<font color="#0077BB">2</font>

<i><font color="#FFFF00">// Daten vom Vertex-Shader</font></i>
<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> Normal;
} DataIn;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;

<b><font color="0000BB">vec3</font></b> Light(<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> nn = normalize(n);
  <b><font color="0000BB">vec3</font></b> np = normalize(p);
  <b><font color="0000BB">vec3</font></b> diffuse;   <i><font color="#FFFF00">// Licht</font></i>
  <b><font color="0000BB">vec3</font></b> specular;  <i><font color="#FFFF00">// Reflektion</font></i>
  <b><font color="0000BB">float</font></b> angele = max(dot(nn, np), <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">if</font></b> (angele > <font color="#0077BB">0</font>.<font color="#0077BB">0</font>) {
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
  outColor = <b><font color="0000BB">vec4</font></b>(Light(Lposition, DataIn.Normal), <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>

