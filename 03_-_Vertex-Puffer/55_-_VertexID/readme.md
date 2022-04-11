<html>
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>55 - VertexID</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit <b>gl_VertexID</b> kann man im Vertex-Shader ermitteln, welcher Vertex aus der Vertex-Array gezeichnet wird.<br>
Das Rendering ist nicht besonderes, es spielt sich alles im Vertex-Shader ab.<br>
<hr><br>
Die Koordinaten der Mesh, maximal 6 Stück<br>
<pre><code=pascal><b><font color="0000BB">const</font></b>
  Triangle: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">0</font>] <b><font color="0000BB">of</font></b> TFace2D =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">7</font>)));
  Quad: <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> TFace2D =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>)),
    (( -<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">1</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">6</font>)));</code></pre>
<hr><br>
Da es in diesem Beispiel nur maximal 6 Vertex-Punkte gibt, habe ich die VertexID mit einer einfachen Case-Schleife ausgewertet.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPos;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec3</font></b> col;
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">switch</font></b> (gl_VertexID) <i><font color="#FFFF00">// Den aktuellen Vertex abfragen.</font></i>
  {
    <b><font color="0000BB">case</font></b> <font color="#0077BB">0</font>:  col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
             <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">case</font></b> <font color="#0077BB">1</font>:  col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
             <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">case</font></b> <font color="#0077BB">2</font>:  col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
             <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">case</font></b> <font color="#0077BB">3</font>:  col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
             <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">case</font></b> <font color="#0077BB">4</font>:  col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
             <b><font color="0000BB">break</font></b>;
    <b><font color="0000BB">default</font></b>: col = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  }
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;
<br>
<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec3</font></b> col;
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  outColor = <b><font color="0000BB">vec4</font></b>(col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<br>
</html>
