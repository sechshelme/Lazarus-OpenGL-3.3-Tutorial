<html>
<img src="image.png" alt="Selfhtml"><br><br>
Ohne Beleuchtung sehen die Object statisch aus, wen man noch Beleuchtung ins Spiel bringt, wirkt eine OpenGL-Scene viel realistischer.<br>
Dabei gibt es verschiedene Arten von Beleuchtung. Die meist verwendete ist das <b>Directional Light</b>, dies entspricht dem Sonnenlicht.<br>
Dieses Beispiel zeigt eine ganz einfache Variante von diesem Licht. Je steiler das Licht auf ein Polygon einstrahlt, je heller wird das Polygon.<br>
<br>
Das man dies berechnen kann, braucht es für jede Ecke des Polygons einen Normale-Vektor.<br>
Eine Normale zeigt meistens senkrecht auf ein Polygon.<br>
Es gibt Ausnahmen, zB. bei runden Flächen. Dazu in einem späteren Beispiel.<br>
<br>
Die <b>Normalen</b> werden mit der <b>ModelMatrix</b> multipliziert, da diese unbeinflusst von Perspektive/Frustum ist.<br>
Die Position der <b>Polygone</b> wird mit <b>Matrix</b> modifiziert, da ist eine perspektifische Darstellung erwünscht.<br>
Wen man dies nicht macht, hat man eine falsche Abdunklung auf den schrägen Dreiecken. Die macht sich besonders start bemerkbar bei <b>Punkt</b> und <b>Spot</b>-Licht.<br>
<br>
Hier wird die einfachste Variante einer Beleuchtung gezeigt.<br>
Dazu wird das Skalarprodukt zwischen der Normalen und der Lichtposition berechnet.<br>
Dabei werden die Polygone dunkler, je grösser der Winkel. 0°=weiss; 180°=schwarz.<br>
Diese Beleuchtung ist eigentlich nicht üblich, aber immerhin sieht man die Mehses viel besser.<br>
Aber es zeigt wenigsten, wie das Grundgerüst einer Beleuchtung aussieht.<br>
<br>
Die gebräuchlichsten Lichvarianten von OpenGL:<br>
* <b>Ambient-Light</b> - Einfache Raumausleuchtung, alles ist gleich Hell.<br>
* <b>Directional-Light</b> - Das Licht kommt alles aus gleicher Richtung, so wie das Sonnenlicht auf Erde.<br>
* <b>Point-Light</b> - Das Licht wird von einem Punkt ausgestrahlt, so wie bei einer Glühbirne.<br>
* <b>Spot-Light</b> - Das Lich hat einen Kegel, so wie wen es aus einer Taschenlampe kommt.<br>
<br>
Was zu beachten das die Beleuchtungs-Effekte <b>keine Schatten</b> berücksichtigen.<br>
Schatten muss man auf eine ganz andere weise berechnen.<br>
<br>
Es ist auch möglich mehrere Lichtquellen zu berechnen, dazu werden alle Lichtquellen addiert.<br>
Das sieht man gut bei den mehrfarbigen Beleuchtungbeispielen. Da sieht man auch, das das Licht farbig sein kann.<br>
<br>
Dazu später.<br>
<hr><br>
Die Konstanten der Würfel-Vektoren.<br>
<pre><code><b><font color="0000BB">const</font></b>
  CubeVertex: TCube =
    (((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    <i><font color="#FFFF00">// oben</font></i>
    ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)),
    <i><font color="#FFFF00">// unten</font></i>
    ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>)), ((-<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>), (<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, -<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>)));</pre></code>
Für die Normale wird nur eine Variable für Vektoren deklariert, da diese aus den Vektoren des Würfels berechnet werden.<br>
Diese zeigt dann senkrecht auf das Dreieck.<br>
<pre><code><b><font color="0000BB">var</font></b>
  CubeNormal: TCube;</pre></code>
Für die Normale braucht es noch eine VBO.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TVB = <b><font color="0000BB">record</font></b>
    VAO,
    VBOvert,            <i><font color="#FFFF00">// VBO für Vektor.</font></i>
    VBONormal: GLuint;  <i><font color="#FFFF00">// VBO für Normale.</font></i>
  <b><font color="0000BB">end</font></b>;</pre></code>
In der Unit Matrix hat es eine fertige Funktion, welche die Normale aus den Vertex-Koordinaten berechnet.<br>
Diese Funktion sollte  man <b>nur</b> verwenden, wen die <b>Normale</b> senkrecht auf dem Dreieck steht.<br>
Bei runden Objekten ist dies nicht der Fall.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  FaceToNormale(CubeVertex, CubeNormal);</pre></code>
Die Normale wird auf gleiche weise in den VRAM geladen, wie die Vertex-Koordinaten.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Hintergrundfarbe</font></i>

  <i><font color="#FFFF00">// --- Daten für Würfel</font></i>
  glBindVertexArray(VBCube.VAO);

  <i><font color="#FFFF00">// Vektor</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBOvert);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeVertex), @CubeVertex, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">0</font>);
  glVertexAttribPointer(<font color="#0077BB">0</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

  <i><font color="#FFFF00">// Normale</font></i>
  glBindBuffer(GL_ARRAY_BUFFER, VBCube.VBONormal);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeNormal), @CubeNormal, GL_STATIC_DRAW);
  glEnableVertexAttribArray(<font color="#0077BB">1</font>);
  glVertexAttribPointer(<font color="#0077BB">1</font>, <font color="#0077BB">3</font>, GL_FLOAT, <b><font color="0000BB">False</font></b>, <font color="#0077BB">0</font>, <b><font color="0000BB">nil</font></b>);

<b><font color="0000BB">end</font></b>;</pre></code>
Hier sieht man gut, das 2 Matrizen dem Shader übergeben werden.<br>
Bevor die Matrix mit Frustum und Worldposition beinflusst wird, wird sie das erste mal dem Shader übergeben.<br>
Diese Matrix beinhaltet nur die lokalen Transformationen der Meshes.<br>
Für die Position der Vektoren, wird eine komplett berechnete Matrix dem Shader übergeben.<br>
Die Multiplikationen hätte man auch im Shader ausführen können, aber dies verbraucht nur unnötige <b>GPU</b>-Leistung.<br>
Wen man es mit der <b>CPU</b> macht, wird die Berechnung nur einmal pro Meshes gemacht und nicht bei jedem Vektor.<br>
Das wird in <b>allen</b> Beleuchtungsbeispielen so gemacht, egal ob Punkt, Directinal, etc. Beleuchtung.<br>
Ausser bei Ambient, da es dort <b>keine</b> Normalen gibt.<br>
<br>
In diesem Beispiel wird die pro Würfel gemacht. Da der Würfel mehrmals verwendet wird, gibt es pro Würfel eine Berechnung.<br>
<pre><code>  <b><font color="0000BB">for</font></b> x := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">for</font></b> y := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      <b><font color="0000BB">for</font></b> z := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 <i><font color="#FFFF00">// Lokale Translationen.</font></i>
        Matrix := ModelMatrix * Matrix;

        Matrix.Uniform(ModelMatrix_ID);                        <i><font color="#FFFF00">// Erste Übergabe an den Shader.</font></i>

        Matrix := FrustumMatrix * WorldMatrix *  Matrix;       <i><font color="#FFFF00">// Matrixen multiplizieren.</font></i>

        Matrix.Uniform(Matrix_ID);                             <i><font color="#FFFF00">// Die komplettt berechnete Matrix übergeben.</font></i>
        glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(CubeVertex) * <font color="#0077BB">3</font>); <i><font color="#FFFF00">// Zeichnet einen einzelnen Würfel.</font></i>
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
Einfachere Beleuchtungen macht man im Vertex-Shader.<br>
Will man aber komplexer Beleuchtungen, nimmt man dazu den Fragment-Shader, das dieser Pixelgenau ist.<br>
Dafür wird aber mehr Berechnugszeit benötigt.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Die Berechnug für das Licht des einfachen Beispieles ist hier im Vetex-Shader.<br>
Hier sieht man, das verschiedene Matrizen für <b>Normale</b> und <b>Vertex</b> verwendet werden.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<i><font color="#FFFF00">// Die Lichtquelle befindet sich Links.</font></i>
<b><font color="#008800">#define</font></b> LightPos <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>)
<b><font color="#008800">#define</font></b> PI       <font color="#0077BB">3</font>.<font color="#0077BB">1415</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                         <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;               <i><font color="#FFFF00">// Matrix des Modeles, ohne Einfluss von Frustum.</font></i>
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                    <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>

<b><font color="0000BB">float</font></b> light(<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b>  v1 = normalize(p); <i><font color="#FFFF00">// Vektoren normalisieren, so das die Länge des Vektors immer 1.0 ist.</font></i>
  <b><font color="0000BB">vec3</font></b>  v2 = normalize(n); <i><font color="#FFFF00">// In diesem Beispiel sind diese schon 1.0, aber in der Praxis können auch andere Werte ankommen.</font></i>
  <b><font color="0000BB">float</font></b> d  = dot(v1, v2);  <i><font color="#FFFF00">// Skalarprodukt ( Winkel ) aus beiden Vektoren berechnen.</font></i>
                           <i><font color="#FFFF00">// Der Winkel ist bei 180° = Pi.</font></i>

  d  = acos(d);            <i><font color="#FFFF00">// Davon noch den Arkuskosinus berechnen. Somit hat man den Winkel zwischen den beiden Vektoren.</font></i>
  d /= PI;                 <i><font color="#FFFF00">// Anschliessend diesen noch durch Pi teilen, da 0° Weiss und 180° Schwarz sein soll.</font></i>
  <b><font color="0000BB">return</font></b> d;
}

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position  = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);    <i><font color="#FFFF00">// Die komplette Berechnete Matrix.</font></i>

  <b><font color="0000BB">vec3</font></b>  Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal; <i><font color="#FFFF00">// Matrix mit lokalen Tranformationen.</font></i>
  <b><font color="0000BB">float</font></b> col    = light(LightPos, Normal);      <i><font color="#FFFF00">// Licht berechnen.</font></i>

  Color        = <b><font color="0000BB">vec4</font></b>(col, col, col, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
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
