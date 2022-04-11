<html>
    <b><h1>01 - Einrichten und Einstieg</h1></b>
    <b><h2>20 - Polygonmodus</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Standartmässig stellt OpenGL Polygone flächenfüllend dar.<br>
Man kann aber die Polygone auch als Drahtgitter, oder nur die Eckpunkte als Punkte darstellen.<br>
<br>
Dies kann man mit <b>glPolygonMode(...</b> einstellen.<br>
Der Modus <b>GL_LINE</b> ist recht praktisch, wen man eine Mesh in der Entwicklungphase rendert, so kann man recht gut Renderfehler erkennen.<br>
<br>
Hinweis: Hier wird die TShader-Klasse verwendet, näheres dazu im Kapitel Shader.<br>
<hr><br>
Hier werden die verschiedenen Polygone-Modis eingestellt.<br>
Mit <b>glPolygonMode(...</b> und dem zweiten Parameter werden die verschiedenen Modis eingestellt.<br>
Dabei muss der erste Paramter immer <b>GL_FRONT_AND_BACK</b> sein, die beiden Parameter <b>GL_FRONT</b> und <b>GL_BACK</b> gehen mit OpenGL >= 3.3 nicht mehr.<br>
<b>glPolygonMode(...</b> kann auch bei DrawScene aufgerufen werden. ZB. wen man zwei Meshes hat, kann man die einte Fächenfüllend und die andere als Drahtgitter darstellen.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.MenuItemClick(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">case</font></b> TMainMenu(Sender).Tag <b><font color="0000BB">of</font></b>
    <font color="#0077BB">1</font>: <b><font color="0000BB">begin</font></b>
      glPolygonMode(GL_FRONT_AND_BACK, GL_POINT);  <i><font color="#FFFF00">// Punkte</font></i>
    <b><font color="0000BB">end</font></b>;
    <font color="#0077BB">2</font>: <b><font color="0000BB">begin</font></b>
      glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);   <i><font color="#FFFF00">// Linien</font></i>
    <b><font color="0000BB">end</font></b>;
    <font color="#0077BB">3</font>: <b><font color="0000BB">begin</font></b>
      glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);   <i><font color="#FFFF00">// Flächenfüllend</font></i>
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
  ogc.Invalidate;   <i><font color="#FFFF00">// Manuelle Aufruf von DrawScene.</font></i>
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
Die Shader haben keinen Einfluss auf die Polygonmodis.<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;  <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor; <i><font color="#FFFF00">// ausgegebene Farbe</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Gelb</font></i>
}
</code></pre>
<br>
</html>
