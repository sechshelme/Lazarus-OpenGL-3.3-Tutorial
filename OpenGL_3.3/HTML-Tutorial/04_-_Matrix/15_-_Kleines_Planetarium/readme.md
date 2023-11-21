<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>15 - Kleines Planetarium</title>
    <style>
      pre {background-color:#BBBBFF; color:#000000; font-family: Fixedsys,Courier,monospace; padding:10px;}
    </style>
  </head>
  <body bgcolor="#DDDDFF">
    <b><h1>04 - Matrix</h1></b>
    <b><h2>15 - Kleines Planetarium</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Kleines Planetarium, welches die Handhabung von Matrizen demonstriert.<br>
Das es übersichtlicher wird, habe ich die Sonne und die Planeten in eine Klasse gepackt.<br>
<br>
Da dieses Beispiel auf einer 2D-Ebene läuft, wird nur eine <b>3x3</b>-Matrix verwendet, auch die Vektor-Koordinaten sind 2D.<br>
Einzig der Vertex-Shader wird ein wenig komplizierter, da die Z-Achse nicht verwendet wird.<br>
<br>
Am Shader wird nur eine Matrix übergeben, welche von der CPU berechnet wird.<br>
Diese Matrix wird aus verschiedene Transformen berechnet.<br>
<hr><br>
Es gibt nur eine ID, da die ganze Matrizen-Berechnung mit der CPU ausgeführt werden.<br>
<pre><code><b><font color="0000BB">var</font></b>
  Matrix_ID: GLint;  <i><font color="#FFFF00">// ID für Matrix.</font></i></pre></code>
Rendern der Sonne und der Paneten.<br>
Dies sind nur farbige Kreise. Der Rest wird später über Matrizen brechnet.<br>
<pre><code><b><font color="0000BB">constructor</font></b> TPlanet.Create(col: TVector3f);
<b><font color="0000BB">const</font></b>
  maxSektor = <font color="#0077BB">17</font>;  <i><font color="#FFFF00">// Anzahl Sektoren der Kreise.</font></i>
<b><font color="0000BB">var</font></b>
  i, j: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">inherited</font></b> Create;

  <b><font color="0000BB">with</font></b> Mesh <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    size := maxSektor;
    SetLength(Vector, size);
    SetLength(Color, size);
    <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> size - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      <b><font color="0000BB">for</font></b> j := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">2</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
        Color[i, j] := vec3(col[<font color="#0077BB">0</font>] + (Random / <font color="#0077BB">4</font>), col[<font color="#0077BB">1</font>] + (Random / <font color="#0077BB">4</font>), col[<font color="#0077BB">2</font>] + (Random / <font color="#0077BB">4</font>));
      <b><font color="0000BB">end</font></b>;

      Vector[i, <font color="#0077BB">0</font>] := vec2(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);
      Vector[i, <font color="#0077BB">1</font>] := vec2(sin(Pi * <font color="#0077BB">2</font> / size * i), cos(Pi * <font color="#0077BB">2</font> / size * i));
      Vector[i, <font color="#0077BB">2</font>] := vec2(sin(Pi * <font color="#0077BB">2</font> / size * (i + <font color="#0077BB">1</font>)), cos(Pi * <font color="#0077BB">2</font> / size * (i + <font color="#0077BB">1</font>)));
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;</pre></code>
Legt die Matrix für die Umlaufbahnen fest.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TPlanet.SetMondR(AValue: GLfloat);
<b><font color="0000BB">begin</font></b>
  MondTransMatrix.Translate(AValue, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Distanz Erde - Mond. ( Erde Mond ist ein Doppelplanet )</font></i>
<b><font color="0000BB">end</font></b>;

<b><font color="0000BB">procedure</font></b> TPlanet.SetUmlaufR(AValue: GLfloat);
<b><font color="0000BB">begin</font></b>
  UmlaufTransMatrix.Translate(AValue, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Distanz Sonne / Planet.</font></i>
<b><font color="0000BB">end</font></b>;</pre></code>
Hier werden die Bahnen der Planeten berechnet und anschliessend gezeichnet.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TPlanet.Draw;
<b><font color="0000BB">begin</font></b>
  UmlaufRotMatrix.Rotate(FUmlaufSpeed);
  PlanetRotMatrix.Rotate(fPlanetSpeed);
  MondRotMatrix.Rotate(FMondSpeed);

  TempMatrix := PlanetRotMatrix;
  TempMatrix.Scale(fPlanetScale);

  TempMatrix := UmlaufRotMatrix * UmlaufTransMatrix * MondRotMatrix * MondTransMatrix * TempMatrix;

  TempMatrix.Uniform(Matrix_ID);

  glBindVertexArray(VAO);
  glDrawArrays(GL_TRIANGLES, <font color="#0077BB">0</font>, Mesh.size * <font color="#0077BB">3</font>);
<b><font color="0000BB">end</font></b>;</pre></code>
Die Parameter für die Sonne und Planeten.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Sonne := TPlanet.Create(vec3(<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>));
  <b><font color="0000BB">with</font></b> Sonne <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    PlanetSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">06</font>;
    PlanetScale := <font color="#0077BB">0</font>.<font color="#0077BB">1</font>;
  <b><font color="0000BB">end</font></b>;

  Venus := TPlanet.Create(vec3(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>));
  <b><font color="0000BB">with</font></b> Venus <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    PlanetScale := <font color="#0077BB">0</font>.<font color="#0077BB">035</font>;
    PlanetSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">2</font>;
    UmlaufSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">01</font>;
    UmlaufR := <font color="#0077BB">0</font>.<font color="#0077BB">2</font>;
  <b><font color="0000BB">end</font></b>;

  Erde := TPlanet.Create(vec3(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>));
  <b><font color="0000BB">with</font></b> Erde <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    PlanetScale := <font color="#0077BB">0</font>.<font color="#0077BB">04</font>;
    PlanetSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">2</font>;
    MondSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">04</font>;
    UmlaufSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">008</font>;
    MondR := <font color="#0077BB">0</font>.<font color="#0077BB">04</font>;
    UmlaufR := <font color="#0077BB">0</font>.<font color="#0077BB">4</font>;
  <b><font color="0000BB">end</font></b>;

  Mond := TPlanet.Create(vec3(<font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>, <font color="#0077BB">0</font>.<font color="#0077BB">5</font>));
  <b><font color="0000BB">with</font></b> Mond <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    PlanetScale := <font color="#0077BB">0</font>.<font color="#0077BB">02</font>;
    MondSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">04</font>;
    UmlaufSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">008</font>;
    MondR := -<font color="#0077BB">0</font>.<font color="#0077BB">04</font>;
    UmlaufR := <font color="#0077BB">0</font>.<font color="#0077BB">4</font>;
  <b><font color="0000BB">end</font></b>;

  Mars := TPlanet.Create(vec3(<font color="#0077BB">0</font>.<font color="#0077BB">8</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">2</font>));
  <b><font color="0000BB">with</font></b> Mars <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    PlanetScale := <font color="#0077BB">0</font>.<font color="#0077BB">025</font>;
    PlanetSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">3</font>;
    UmlaufSpeed := <font color="#0077BB">0</font>.<font color="#0077BB">006</font>;
    UmlaufR := <font color="#0077BB">0</font>.<font color="#0077BB">6</font>;
  <b><font color="0000BB">end</font></b>;</pre></code>
Sonne und Planeten zeichnen<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  <i><font color="#FFFF00">// Zeichne Sonne und Planeten</font></i>
  Sonne.Draw;
  Venus.Draw;
  Erde.Draw;
  Mond.Draw;
  Mars.Draw;

  ogc.SwapBuffers;
<b><font color="0000BB">end</font></b>;</pre></code>
<hr><br>
<b>Vertex-Shader:</b><br>
<br>
Bei der Multiplikation, wird die Z-Achse ignoriert, aus diesem Grund wird <b>glPosition.xyw</b> verwendet.<br>
Anschliessend wird Z auf <b>0.0</b> gesetzt.<br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec2</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten in 2D.</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">11</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inCol; <i><font color="#FFFF00">// Farbe</font></i>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> Color;                       <i><font color="#FFFF00">// Farbe, an Fragment-Shader übergeben.</font></i>

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat3</font></b> mat;                     <i><font color="#FFFF00">// Matrix von Uniform.</font></i>


<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position.xyw = mat * <b><font color="0000BB">vec3</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  gl_Position.z   = <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  Color = <b><font color="0000BB">vec4</font></b>(inCol, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec4</font></b> Color;      <i><font color="#FFFF00">// interpolierte Farbe vom Vertexshader</font></i>
<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = Color; <i><font color="#FFFF00">// Die Ausgabe der Farbe</font></i>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
