<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>03 - Vertex-Puffer</h1></b>
    <b><h2>55 - VertexID</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Mit <b>gl_VertexID</b> kann man im Vertex-Shader ermitteln, welcher Vertex aus der Vertex-Array gezeichnet wird.<br>
Das Rendering ist nicht besonderes, es spielt sich alles im Vertex-Shader ab.<br>
<hr><br>
Die Koordinaten der Mesh, maximal 6 Stück<br>
<pre><code>const
  Triangle: array[0..0] of TFace2D =</font>
    (((-0.4, 0.1), (0.4, 0.1), (0.0, 0.7)));</font>
  Quad: array[0..1] of TFace2D =</font>
    (((-0.2, -0.6), (-0.2, -0.1), (0.2, -0.1)),</font>
    (( -0.2, -0.6), (0.2, -0.1), (0.2, -0.6)));</font></pre></code>
<hr><br>
Da es in diesem Beispiel nur maximal 6 Vertex-Punkte gibt, habe ich die VertexID mit einer einfachen Case-Schleife ausgewertet.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec2 inPos;</font>

out vec3 col;
 
void main(void)
{
  gl_Position = vec4(inPos, 0.0, 1.0);</font>
  switch (gl_VertexID) // Den aktuellen Vertex abfragen.
  {
    case 0:  col = vec3(1.0, 0.0, 0.0);
             break;
    case 1:  col = vec3(0.0, 1.0, 0.0);
             break;
    case 2:  col = vec3(0.0, 0.0, 1.0);
             break;
    case 3:  col = vec3(1.0, 1.0, 0.0);
             break;
    case 4:  col = vec3(0.0, 1.0, 1.0);
             break;
    default: col = vec3(1.0, 0.0, 1.0);</font>
  }
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

out vec4 outColor;

in  vec3 col;

void main(void) {
  outColor = vec4(col, 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
