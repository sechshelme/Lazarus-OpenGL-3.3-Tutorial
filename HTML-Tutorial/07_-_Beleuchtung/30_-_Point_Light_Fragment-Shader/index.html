<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>30 - Point Light Fragment-Shader</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>30 - Point Light Fragment-Shader</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Die Berechnung des Lichtes wurde in den Fertex-Shader ausgelagert, somit sieht das Punkt-Licht viel realistischer aus.<br>
Am besten sieht man dies, wen man nur ein Würfel darstellt.<br>
<br>
Der Nachteil dabei, es wird mehr <b>GPU</b>-Leistung verlangt, als wen man es im Vertex-Shader berechnet.<br>
<hr><br>
Hier sieht man, das die Berechnung des Lichtes im Fragment-Shader ist.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<i><font color="#FFFF00">// Daten für Fragment-shader</font></i>
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
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="#008800">#define</font></b> ambient <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>)
<b><font color="#008800">#define</font></b> red     <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> green   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> blue    <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)

<i><font color="#FFFF00">// Daten vom Vertex-Shader</font></i>
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

<b><font color="0000BB">float</font></b> light(<b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> v1 = normalize(p);     <i><font color="#FFFF00">// Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.</font></i>
  <b><font color="0000BB">vec3</font></b> v2 = normalize(n);
  <b><font color="0000BB">float</font></b> d = dot(v1, v2);      <i><font color="#FFFF00">// Skalarprodukt aus beiden Vektoren berechnen.</font></i>
  <b><font color="0000BB">return</font></b> clamp(d, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  outColor = <b><font color="0000BB">vec4</font></b>(ambient, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">if</font></b> (RedOn) {
    <b><font color="0000BB">vec3</font></b> colRed   = light(RedLightPos   - DataIn.pos, DataIn.Normal) * red;
    outColor.rgb += colRed;
  }
  <b><font color="0000BB">if</font></b> (GreenOn) {
    <b><font color="0000BB">vec3</font></b> colGreen = light(GreenLightPos - DataIn.pos, DataIn.Normal) * green;
    outColor.rgb += colGreen;
  }
  <b><font color="0000BB">if</font></b> (BlueOn) {
    <b><font color="0000BB">vec3</font></b> colBlue  = light(BlueLightPos  - DataIn.pos, DataIn.Normal) * blue;
    outColor.rgb += colBlue;
  }
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
