    <b><h1>02 - Shader</h1></b>
    <b><h2>10 - Uniform Variablen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird die Farbe des Meshes über eine Unifom-Variable an den Shader übergeben, somit kann die Farbe zur Laufzeit geändert werden.<br>
Unifom-Variablen dienen dazu, um Parameter den Shader-Objecte zu übergeben. Meistens sind dies Matrixen, oder wie hier im Beispiel die Farben.<br>
Oder auch Beleuchtung-Parameter, zB. die Position des Lichtes.<br>
<hr><br>
Deklaration der ID, welche auf die Unifom-Variable im Shader zeigt, und die Variable, welche die Farbe für den Vektor enthält.<br>
Da man die Farbe als Vektor übergibt, habe ich dafür den Typ <b>TVertex3f</b> gewählt. Seine Komponenten beschreiben den Rot-, Grün- und Blauanteil der Farbe.<br>
<pre><code><b><font color="0000BB">var</font></b>
  Color_ID: GLint;      <i><font color="#FFFF00">// ID</font></i>
  MyColor: TVertex3f;   <i><font color="#FFFF00">// Farbe</font></i></pre></code>
Dieser Code wurde um eine Zeile <b>UniformLocation</b> erweitert.<br>
Diese ermittelt die ID, wo sich <b>Color</b> im Shader befindet.<br>
<br>
Vor dem Ermitteln muss mit <b>UseProgram</b> der Shader aktviert werden, von dem man lesen will.<br>
Im Hintergrund wird dabei <b>glGetUniformLocation(ProgrammID,...</b> aufgerufen.<br>
Der Vektor von MyColor ist in RGB (Rot, Grün, Blau).<br>
<br>
Der String in <b>UniformLocation</b> muss indentisch mit dem Namen der Uniform-Variable im Shader sein. <b>Wichtig:</b> Es muss auf Gross- und Kleinschreibung geachtet werden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation(<font color="#FF0000">'Color'</font>); <i><font color="#FFFF00">// Ermittelt die ID von "Color".</font></i>
  <i><font color="#FFFF00">// MyColor Blau zuweisen.</font></i>
  MyColor[<font color="#0077BB">0</font>] := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  MyColor[<font color="#0077BB">1</font>] := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  MyColor[<font color="#0077BB">2</font>] := <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;</pre></code>
Hier wird die Uniform-Variable übergeben. Für diese vec3-Variable gibt es zwei Möglichkeiten.<br>
Mit <b>glUniform3fv...</b> kann man sie als ganzen Vektor übergeben.<br>
Mit <b>glUniform3f(...</b> kann man die Komponenten der Farben auch einzeln übergeben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne Dreieck</font></i>
  glUniform3fv(Color_ID, <font color="#0077BB">1</font>, @MyColor);   <i><font color="#FFFF00">// Als Vektor</font></i>
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Triangle) * <font color="#0077BB">3</font>);

  <i><font color="#FFFF00">// Zeichne Quadrat</font></i>
  glUniform3f(Color_ID, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Einzel</font></i>
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(Quad) * <font color="#0077BB">3</font>);

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
Folgende Prozedur weist dem Vektor <b<MyColor</b> eine andere Farbe zu.<br>
Dafür wird ein einfaches Menü verwendet.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.MenuItemClick(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">case</font></b> TMainMenu(Sender).Tag <b><font color="0000BB">of</font></b>
    <font color="#0077BB">0</font>: <b><font color="0000BB">begin</font></b>   <i><font color="#FFFF00">// Rot</font></i>
      MyColor[<font color="#0077BB">0</font>] := <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
      MyColor[<font color="#0077BB">1</font>] := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
      MyColor[<font color="#0077BB">2</font>] := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
    <b><font color="0000BB">end</font></b>;
    <font color="#0077BB">1</font>: <b><font color="0000BB">begin</font></b>   <i><font color="#FFFF00">// Grün</font></i>
      MyColor[<font color="#0077BB">0</font>] := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
      MyColor[<font color="#0077BB">1</font>] := <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
      MyColor[<font color="#0077BB">2</font>] := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
    <b><font color="0000BB">end</font></b>;
    <font color="#0077BB">2</font>: <b><font color="0000BB">begin</font></b>   <i><font color="#FFFF00">// Blau</font></i>
      MyColor[<font color="#0077BB">0</font>] := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
      MyColor[<font color="#0077BB">1</font>] := <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
      MyColor[<font color="#0077BB">2</font>] := <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
  ogc.Invalidate;   <i><font color="#FFFF00">// Manuelle Aufruf von DrawScene.</font></i>
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<br>
Hier ist die Uniform-Variable <b>Color</b> hinzugekommen.<br>
Diese habe ich nur im Fragment-Shader deklariert, da diese nur hier gebraucht wird.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> Color;  <i><font color="#FFFF00">// Farbe von Uniform</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Das 1.0 ist der Alpha-Kanal, hat hier keine Bedeutung.</font></i>
}
</pre></code>

