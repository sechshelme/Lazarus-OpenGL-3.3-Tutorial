<html>
<img src="image.png" alt="Selfhtml"><br><br>
Wie schon beschrieben, sind auch mehrere Lichtquellen möglich.<br>
<br>
In diesem Beispiel habe ich 3 Directionale Lichtquellen eingefügt, welche sich bewegen.<br>
Das man die einzelnen Lichquellen besser sieht, habe ich sie in 3 Farben dargestellt.<br>
<br>
Als Meshes habe ich Kugeln gewählt, so sieht man die Übergänge von hell nach dunkel besser.<br>
<br>
Das man die Lichteffekte besser sieht, kann man sie über das Menü ein und aus schalten.<br>
Auch kann man die Rotierung anhalten und die Anzahl der Kugeln verändern.<br>
<br>
Wen man nur eine Kugel hat, sieht man die Bewegung des Lichtes sehr gut.<br>
Wen man alle 3 Lichter ausschaltet, dann sieht man die Ambiente Hintergrund-Beleuchtung sehr gut.<br>
<br>
Die Lichtposition ist nicht mehr im Shader als Konstante deklariert, sie wurde mit einer <b>Uniform-Variable</b> nach aussen verlagert.<br>
<hr><br>
Die Lichtpositionen als 3D-Vektorn definiert.<br>
<pre><code><b><font color="0000BB">var</font></b>
  LightPos: <b><font color="0000BB">record</font></b>
    Red, Green, Blue: TVector3f;
  <b><font color="0000BB">end</font></b>;</pre></code>
Hier werden die verschiedenen Parameter für die Lichtparamter über Uniform am Shader übergeben.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">var</font></b>
  x, y, z: integer;
  scal, d: single;
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT <b><font color="0000BB">or</font></b> GL_DEPTH_BUFFER_BIT);  <i><font color="#FFFF00">// Frame und Tiefen-Buffer löschen.</font></i>

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  <i><font color="#FFFF00">// Lichtpositionen</font></i>
  <b><font color="0000BB">with</font></b> LightPos_ID <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glUniform3fv(Red, <font color="#0077BB">1</font>, @LightPos.Red);
    glUniform3fv(Green, <font color="#0077BB">1</font>, @LightPos.Green);
    glUniform3fv(Blue, <font color="#0077BB">1</font>, @LightPos.Blue);
  <b><font color="0000BB">end</font></b>;

  <i><font color="#FFFF00">// Licht Ein/Aus - Parameter</font></i>
  <b><font color="0000BB">with</font></b> ColorOn_ID <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    glUniform1i(Red, GLint(MenuItemRedOn.Checked));
    glUniform1i(Green, GLint(MenuItemGreenOn.Checked));
    glUniform1i(Blue, GLint(MenuItemBlueOn.Checked));
  <b><font color="0000BB">end</font></b>;</pre></code>
Auf verlangen Würfel drehen und Lichtposition verändern.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">if</font></b> MenuItemRotateCube.Checked <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    ModelMatrix.RotateA(<font color="#0077BB">0</font>.<font color="#0077BB">0123</font>);  <i><font color="#FFFF00">// Drehe um X-Achse</font></i>
    ModelMatrix.RotateB(<font color="#0077BB">0</font>.<font color="#0077BB">0234</font>);  <i><font color="#FFFF00">// Drehe um Y-Achse</font></i>
  <b><font color="0000BB">end</font></b>;

  <b><font color="0000BB">with</font></b> LightPos <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">if</font></b> MenuItemRotateRed.Checked <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      Red.RotateA(<font color="#0077BB">0</font>.<font color="#0077BB">031</font>);
      Red.RotateB(<font color="#0077BB">0</font>.<font color="#0077BB">011</font>);
    <b><font color="0000BB">end</font></b>;

    <b><font color="0000BB">if</font></b> MenuItemRotateGreen.Checked <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      Green.RotateB(<font color="#0077BB">0</font>.<font color="#0077BB">021</font>);
      Green.RotateC(<font color="#0077BB">0</font>.<font color="#0077BB">015</font>);
    <b><font color="0000BB">end</font></b>;

    <b><font color="0000BB">if</font></b> MenuItemRotateBlue.Checked <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
      Blue.RotateA(<font color="#0077BB">0</font>.<font color="#0077BB">021</font>);
      Blue.RotateC(<font color="#0077BB">0</font>.<font color="#0077BB">023</font>);
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Wen man mehrere Lichtquellen hat, werden diese alle <b>addiert</b>.<br>
Dies sieht man gut am Ende des Vertex-Shader, dort wo es die<b> += </b>hat.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<i><font color="#FFFF00">// Konstante für Abiente Hintergrundbeleuchung.</font></i>
<b><font color="#008800">#define</font></b> ambient <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>)

<i><font color="#FFFF00">// Die Farben der Lichtstrahlen.</font></i>
<b><font color="#008800">#define</font></b> red     <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> green   <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> blue    <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                         <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>

<i><font color="#FFFF00">// Matrix des Modeles, ohne Frustum-Beeinflussung.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;

<i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;

<i><font color="#FFFF00">// Einzelne Lichtquellen Ein/Aus.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> RedOn;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> GreenOn;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">bool</font></b> BlueOn;

<i><font color="#FFFF00">// Position der Lichtquellen.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> RedLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> GreenLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> BlueLightPos;

<i><font color="#FFFF00">// Berechnet die Ausleuchtung der einzelnen Faces.</font></i>
<b><font color="0000BB">float</font></b> light(<b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> v1 = normalize(p);     <i><font color="#FFFF00">// Vektoren normalisieren,</font></i>
  <b><font color="0000BB">vec3</font></b> v2 = normalize(n);     <i><font color="#FFFF00">// so das es Einheitsvektoren gibt.</font></i>
  <b><font color="0000BB">float</font></b> d = dot(v1, v2);      <i><font color="#FFFF00">// Skalarprodukt aus beiden Vektoren berechnen.</font></i>
  <b><font color="0000BB">return</font></b> clamp(d, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Bereich der Ausgabe einschränken.</font></i>
}

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  <i><font color="#FFFF00">// Vektoren mit komplette vorberechneter Matrix multipizieren.</font></i>
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// Normale nur mit lokaler Matrix Multipizieren.</font></i>
  <b><font color="0000BB">vec3</font></b> Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;

  <i><font color="#FFFF00">// Ambiente Lichtquelle</font></i>
  Color = <b><font color="0000BB">vec4</font></b>(ambient, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <i><font color="#FFFF00">// Lichtquellen auf verlangen berechnen und addieren.</font></i>
  <b><font color="0000BB">if</font></b> (RedOn) {
    <b><font color="0000BB">vec3</font></b> colRed = light(RedLightPos, Normal) * red;
    Color.rgb += colRed;
  }
  <b><font color="0000BB">if</font></b> (GreenOn) {
    <b><font color="0000BB">vec3</font></b> colGreen = light(GreenLightPos, Normal) * green;
    Color.rgb += colGreen;
  }
  <b><font color="0000BB">if</font></b> (BlueOn) {
    <b><font color="0000BB">vec3</font></b> colBlue = light(BlueLightPos, Normal) * blue;
    Color.rgb += colBlue;
  }
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
