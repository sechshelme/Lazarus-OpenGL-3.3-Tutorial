<html>
    <b><h1>02 - Shader</h1></b>
    <b><h2>30 - Geometrie Shader</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird ganz kurz der Geometrie-Shader erwähnt.<br>
In diesem Beispiel wird nicht ins Detail eingegangen, es sollte nur zeigen für was ein Geometrie-Shader gut ist.<br>
Die Funktion hier im Beispiel ist, die beiden Meshes werden kopiert und anschliessend nach Links und Rechts verschoben.<br>
Auch bekommt die Linke Version eine andere Farbe als die Rechte.<br>
<br>
Man kann einen Geometrie-Shader auch brauchen um automatisch die Normale auszurechnen, welche für Beleuchtungs-Effekte gebraucht wird.<br>
Was eine Normale ist, wird später im Kapitel Beleuchtung erklärt.<br>
<br>
Der Lazarus-Code ist nichts besonderes, er rendert die üblichen zwei Meshes Dreieck und Quadrat.<br>
Die einzige Besondeheit ist, es wird zu den üblichen zwei Shader noch ein Geometrie-Shader geladen wird.<br>
<hr><br>
Hier ist die einzige Besonderheit, dem Constructor von TShader wird ein dritter Shader-Code mitgegeben.<br>
<br>
Wen man bei der Shader-Klasse einen dritten Shader mit gibt, wird automatisch erkannt, das noch ein Geometrie-Shader dazu kommt.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Geometrieshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Geometrie-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="#008800">#define</font></b> distance <font color="#0077BB">0</font>.<font color="#0077BB">5</font>
<br>
<b><font color="0000BB">layout</font></b>(triangles) <b><font color="0000BB">in</font></b>;
<b><font color="0000BB">layout</font></b>(triangle_strip, max_vertices = <font color="#0077BB">9</font>) <b><font color="0000BB">out</font></b>;
<br>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec3</font></b> Color; <i><font color="#FFFF00">// Farb-Ausgabe für den Fragment-Shader </font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
<br>
<i><font color="#FFFF00">// Linke Meshes</font></i>
   <b><font color="0000BB">for</font></b>(<b><font color="0000BB">int</font></b> i = <font color="#0077BB">0</font>; i &lt; gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + <b><font color="0000BB">vec4</font></b>(-distance, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// nach Links verschieben</font></i>
      Color = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);                                         <i><font color="#FFFF00">// Links Rot</font></i>
      EmitVertex();
   }
   EndPrimitive();
<br>

<i><font color="#FFFF00">// Rechte Meshes</font></i>
   <b><font color="0000BB">for</font></b>(<b><font color="0000BB">int</font></b> i = <font color="#0077BB">0</font>; i &lt; gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position + <b><font color="0000BB">vec4</font></b>(distance, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// nach Rechts verschieben</font></i>
      Color = <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);                                         <i><font color="#FFFF00">// Rechts Grün</font></i>
      EmitVertex();
   }
   EndPrimitive();
}
</code></pre>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> Color;      <i><font color="#FFFF00">// Farbe vom Geometrie-Shader.</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// Ausgegebene Farbe.</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">0</font>.<font color="#0077BB">1</font>);
}
</code></pre>
<br>
</html>
