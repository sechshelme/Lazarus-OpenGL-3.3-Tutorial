<!DOCTYPE html>
<html>
    <b><h1>05 - 3D</h1></b>
    <b><h2>20 - Fluchtpunktperspektive (Frustum)</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Will man die Scene realistisch proportional darstellen, nimmt man eine Frustum-Matrix.<br>
Dies hat den Einfluss, das Objekte kleiner erscheinen, je weiter die Scene von einem weg ist.<br>
In der Realität ist dies auch so, das Objekte kleiner erscheinen, je weiter sie von einem weg sind.<br>
<hr><br>
Der Frustum funktioniert ähnlich wie beim Ortho.<br>
Nur die Parameter sind ein wenig anders.<br>
Die Z-Werte müssen immer <b>positiv</b> sein.<br>
<br>
Mit den zwei letzten Parametern von Frustum und der World-Matrix muss man ein bisschen probieren, zum Teil wird sonst das Bild verzehrt.<br>
<br>
Alternativ kann man den Frustum auch mit <b>Perspective(...</b> einstellen.<br>
Dabei ist der erste Parameter der Betrachtungs-Winkel.<br>
Der zweite Parameter ist das Fensterverhältniss, mehr dazu und glViewPort.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">const</font></b>
  w = <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
<b><font color="0000BB">begin</font></b>
  Matrix.Identity;
  FrustumMatrix.Frustum(-w, w, -w, w, <font color="#0077BB">2</font>.<font color="#0077BB">5</font>, <font color="#0077BB">1000</font>.<font color="#0077BB">0</font>);

<i><font color="#FFFF00">//   FrustumMatrix.Perspective(45, 1.0, 2.5, 1000.0); // Alternativ</font></i>

  WorldMatrix.Identity;
  WorldMatrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">200</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Die Scene in den sichtbaren Bereich verschieben.</font></i>
  WorldMatrix.Scale(<font color="#0077BB">5</font>.<font color="#0077BB">0</font>);                  <i><font color="#FFFF00">// Und der Grösse anpassen.</font></i></pre></code>
Das Zeichnen ist das Selbe wie bei Ortho.<br>
<pre><code>  <i><font color="#FFFF00">// --- Zeichne Würfel</font></i>

  <b><font color="0000BB">for</font></b> x := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">for</font></b> y := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      <b><font color="0000BB">for</font></b> z := -s <b><font color="0000BB">to</font></b> s <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 <i><font color="#FFFF00">// Matrix verschieben.</font></i>

        Matrix := FrustumMatrix * WorldMatrix * Matrix;        <i><font color="#FFFF00">// Matrizen multiplizieren.</font></i>

        Matrix.Uniform(Matrix_ID);                             <i><font color="#FFFF00">// Matrix dem Shader übergeben.</font></i>
        glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Length(CubeVertex) * <font color="#0077BB">3</font>); <i><font color="#FFFF00">// Zeichnet einen kleinen Würfel.</font></i>
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol; <i><font color="#FFFF00">// Farbe</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                       <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                  <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b>  <b><font color="0000BB">vec4</font></b> Color;     <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>

</html>
