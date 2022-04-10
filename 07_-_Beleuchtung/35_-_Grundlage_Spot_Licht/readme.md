<html>
<img src="image.png" alt="Selfhtml"><br><br>
Dieses Beispiel zeigt, wie ein Spotlicht berechnet wird.<br>
Zum besseren Verständnis, wird das ganze ohne OpenGL als 2D auf einem Canvas gezeigt.<br>
<hr><br>
Deklarationen der benütigenten Variablen.<br>
<pre><code><b><font color="0000BB">type</font></b>
  TVec2 = <b><font color="0000BB">array</font></b>[<font color="#0077BB">0</font>..<font color="#0077BB">1</font>] <b><font color="0000BB">of</font></b> single;

<b><font color="0000BB">var</font></b>
  LichtOefffnung: single;
  LichtPos, LichtRichtung: TVec2;</code></pre>
Entspricht dem <b>vec2</b> von <b>GLSL</b>.<br>
<pre><code><b><font color="0000BB">function</font></b> vec2(x, y: single): TVec2; <b><font color="0000BB">inline</font></b>;
<b><font color="0000BB">begin</font></b>
  Result[<font color="#0077BB">0</font>] := x;
  Result[<font color="#0077BB">1</font>] := y;
<b><font color="0000BB">end</font></b>;</code></pre>
Entspricht dem <b>normalize(vec2)</b> von <b>GLSL</b>.<br>
Dies normalisiert den 2D-Vektor.<br>
<pre><code><b><font color="0000BB">function</font></b> normalize(v: TVec2): TVec2;
<b><font color="0000BB">var</font></b>
  i: integer;
  l: single;
<b><font color="0000BB">begin</font></b>
  l := Sqrt(Sqr(v[<font color="#0077BB">0</font>]) + Sqr(v[<font color="#0077BB">1</font>]));
  <b><font color="0000BB">if</font></b> l = <font color="#0077BB">0</font> <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    l := <font color="#0077BB">1</font>.<font color="#0077BB">0</font>;
  <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">for</font></b> i := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Result[i] := v[i] / l;
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</code></pre>
Entspricht dem <b>dot(vec2)</b> von <b>GLSL</b>.<br>
Hier wird das Skalarprodukt aus 2 Vektoren berechnent.<br>
<b>arccos(Result)</b>, gibt den Winkel der beiden Vektoren im Bogenmass aus.<br>
<pre><code><b><font color="0000BB">function</font></b> dot(v1, v2: TVec2): single;
<b><font color="0000BB">begin</font></b>
  Result := ((v1[<font color="#0077BB">0</font>] * v2[<font color="#0077BB">0</font>] + v1[<font color="#0077BB">1</font>] * v2[<font color="#0077BB">1</font>]) / (sqrt(v1[<font color="#0077BB">0</font>] * v1[<font color="#0077BB">0</font>] + v1[<font color="#0077BB">1</font>] * v1[<font color="#0077BB">1</font>]) * sqrt(v2[<font color="#0077BB">0</font>] * v2[<font color="#0077BB">0</font>] + v2[<font color="#0077BB">1</font>] * v2[<font color="#0077BB">1</font>])));
<b><font color="0000BB">end</font></b>;</code></pre>
Startwerte für die Lichtparameter.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormCreate(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  LichtOefffnung := <font color="#0077BB">8</font>; <i><font color="#FFFF00">// Ausstrahl-Winkel 45°  ( PI / 8 )</font></i>
  LichtPos := vec2(<font color="#0077BB">200</font>, <font color="#0077BB">100</font>);
  LichtRichtung := vec2(<font color="#0077BB">2</font>, <font color="#0077BB">2</font>);
<b><font color="0000BB">end</font></b>;</code></pre>
Die Maustasten ändern die Licht und Austrahl-Position.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">case</font></b> Button <b><font color="0000BB">of</font></b>
    mbLeft: <b><font color="0000BB">begin</font></b>
      LichtRichtung[<font color="#0077BB">0</font>] := x - LichtPos[<font color="#0077BB">0</font>];
      LichtRichtung[<font color="#0077BB">1</font>] := y - LichtPos[<font color="#0077BB">1</font>];
    <b><font color="0000BB">end</font></b>;
    mbRight: <b><font color="0000BB">begin</font></b>
      LichtPos[<font color="#0077BB">0</font>] := x;
      LichtPos[<font color="#0077BB">1</font>] := y;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
  Invalidate;
<b><font color="0000BB">end</font></b>;</code></pre>
Das Mausrad ändert den Austrahlwinkel.<br>
<pre><code><b><font color="0000BB">function</font></b> isCone(x, y: integer): boolean;
<b><font color="0000BB">var</font></b>
  winkel: single;
  lr, lp: TVec2;
<b><font color="0000BB">begin</font></b>
  <i><font color="#FFFF00">// Lichtrichtung Normalisieren.</font></i>
  lr := normalize(LichtRichtung);

  <i><font color="#FFFF00">// Lichtposition inkremtal berechnen.</font></i>
  lp :=vec2(x - LichtPos[<font color="#0077BB">0</font>], y - LichtPos[<font color="#0077BB">1</font>]);

  <i><font color="#FFFF00">// Lichtposition Normlisieren.</font></i>
  lp := normalize(lp);

  <i><font color="#FFFF00">// Skalarprodukt berechen.</font></i>
  winkel := dot(lr, lp);

  <i><font color="#FFFF00">// Prüfen, ob sicher der Pixel im Lichtstrahl befindet.</font></i>
  Result := (winkel &gt; cos(pi / LichtOefffnung));
<b><font color="0000BB">end</font></b>;</code></pre>
Zeichen der ganzen Scene.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormPaint(Sender: TObject);
<b><font color="0000BB">var</font></b>
  x, y: integer;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">for</font></b> x := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> ClientWidth - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    <b><font color="0000BB">for</font></b> y := <font color="#0077BB">0</font> <b><font color="0000BB">to</font></b> ClientHeight - <font color="#0077BB">1</font> <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
      <b><font color="0000BB">if</font></b> isCone(x, y) <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
        Canvas.Pixels[x, y] := clYellow;
      <b><font color="0000BB">end</font></b> <b><font color="0000BB">else</font></b> <b><font color="0000BB">begin</font></b>
        Canvas.Pixels[x, y] := clBlack;
      <b><font color="0000BB">end</font></b>;
    <b><font color="0000BB">end</font></b>;
  <b><font color="0000BB">end</font></b>;
<b><font color="0000BB">end</font></b>;</code></pre>

</html>
