<html>
    <b><h1>04 - Matrix</h1></b>
    <b><h2>10 - Matrix Verschieben und Multiplizieren</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird die Mesh verschoben, und anschliessend gedreht.<br>
<br>
Dazu werden zwei 4x4 Matrixen verwendet, eine für das Verschieben und die andere für die Drehung.<br>
Eine dritte Matrix ist noch für das Produkt von den zweit Matrixen, welche dann am Shader übergeben wird.<br>
Im Timer wird Matrix-Rotation ausgeführt.<br>
<br>
Für Matrixen, wird ab jetzt ein Type Helper aus der Unit <b>OpenGLMatrix</b> verwendent, dies macht das Ganze übersichtlicher.<br>
Dafür muss einfach die Unit <b>oglMatrix</b> bei uses eingebunden werden.<br>
In der Regel muss dann die Matrix mit <b>TMatrix.Indenty</b> auf die Einheits-Matrix gesetzt werden.<br>
<hr><br>
Die Deklaration der drei Matrixen.<br>
Und die ID für den Shader. Die ID wird nur eine gebraucht, da nur das Produkt dem Shader übergeben wird.<br>
<pre><code=pascal><b><font color="0000BB">var</font></b>
  RotMatrix, TransMatrix, prodMatrix: TMatrix;   <i><font color="#FFFF00">// Matrizen von der Unit oglMatrix.</font></i>
  Matrix_ID: GLint;                              <i><font color="#FFFF00">// ID für Matrix.</font></i></code></pre>
Hier werden die drei Matrixen auf die gesetzt.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation(<font color="#FF0000">'Color'</font>);
  Matrix_ID := Shader.UniformLocation(<font color="#FF0000">'mat'</font>);
  RotMatrix.Identity;                   <i><font color="#FFFF00">// Zuerst ist eine Einheitsmatrix erwünscht.</font></i>
  TransMatrix.Identity;
  prodMatrix.Identity;
  TransMatrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// TransMatrix um 0.5 nach links verschieben.</font></i></code></pre>
Hier wird das Produkt von TransMatrix und RotMatrix den Shader übergeben.<br>
Mit der Klasse geht dies einfacht mit <b>Matrix.Uniform(ID)</b><br>
<br>
Matrizen multiplizieren geht am einfachsten mit der überladenen Multiplikation-Funktion.<br>
<pre><code=pascal>Matrix := Matrix * Matrix;
Matrix := Matrix * Matrix * Matrix;</code></pre>
Dabei wird die Mesh zuerst gedreht und dann verschoben.<br>
<b>Die Reihenfolge der Multiplikatoren ist sehr wichtig !</b><br>
<br>
Einfach mal TransMatrix und RotMatrix vertauschen, dann sieht man ganz ein anderes Ergebniss.<br>
Dann wird zuerst die Mesh verschoben und dann das Ganze um den Mittelpunkt gedreht.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  prodMatrix := TransMatrix * RotMatrix;       <i><font color="#FFFF00">// Matrix multiplizieren.</font></i>
  prodMatrix.Uniform(Matrix_ID);               <i><font color="#FFFF00">// prodMatrix in den Shader schreiben.</font></i></code></pre>
Die Drehung der Matrix wird fortlaufend um den Wert <b>step</b> gedreht.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  step: GLfloat = <font color="#0077BB">0</font>.<font color="#0077BB">01</font>;
<b><font color="0000BB">begin</font></b>
  RotMatrix.RotateC(step); <i><font color="#FFFF00">// RotMatrix rotieren</font></i>
  ogcDrawScene(Sender);    <i><font color="#FFFF00">// Neu zeichnen</font></i>
<b><font color="0000BB">end</font></b>;</code></pre>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Hier ist die Uniform-Variable <b>mat</b> hinzugekommen.<br>
Diese wird im Vertex-Shader deklariert, Bewegungen kommen immer in diesen Shader.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> mat;                     <i><font color="#FFFF00">// Matrix von Uniform</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = mat * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<br>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> Color;  <i><font color="#FFFF00">// Farbe von Uniform</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;   <i><font color="#FFFF00">// ausgegebene Farbe</font></i>
<br>
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(Color, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</code></pre>
<br>
</html>
