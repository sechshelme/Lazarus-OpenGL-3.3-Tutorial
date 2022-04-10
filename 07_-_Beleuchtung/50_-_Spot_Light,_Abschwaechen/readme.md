<!DOCTYPE html>
<html>
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>50 - Spot Light, Abschwaechen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Wen das Licht schwächer wird, je weiter es von der Mesh entfernt wird, sieht es viel realistischer aus.<br>
Auch wird ein Lichtstrahl schwächer je weit er vom Zentrum weg ist.<br>
<br>
Die beiden linken Lichter wird nur eine Abschwächung angewendet. Das rechte Licht ist eine Kombination aus beiden Abschwächungen und somit die realistischte.<br>
<br>
Dies Distanzabhängige Abschwächung, kann man auch bei einer Punkt-Beleuchtung anwenden.<br>
<hr><br>
Hier werden die Lichtpositionen der drei Lampen festgelegt.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">const</font></b>
  LichtPositionRadius = <font color="#0077BB">25</font>.<font color="#0077BB">0</font>;
<b><font color="0000BB">begin</font></b>
  <b><font color="0000BB">with</font></b> LightPos <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Red := vec3(-<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">4</font>.<font color="#0077BB">0</font>);
    Red.Scale(LichtPositionRadius);

    Green := vec3(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">4</font>.<font color="#0077BB">0</font>);
    Green.Scale(LichtPositionRadius);

    Blue := vec3(<font color="#0077BB">1</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">4</font>.<font color="#0077BB">0</font>);
    Blue.Scale(LichtPositionRadius);
  <b><font color="0000BB">end</font></b>;</pre></code>
Hier werden die 3 Lichter in der Z-Achse bewegt.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.Timer1Timer(Sender: TObject);
<b><font color="0000BB">const</font></b>
  Step: single = <font color="#0077BB">0</font>.<font color="#0077BB">5</font>;
  min = <font color="#0077BB">40</font>.<font color="#0077BB">0</font>;
  max = <font color="#0077BB">80</font>.<font color="#0077BB">0</font>;

  ZPos: single = (max + min) / <font color="#0077BB">2</font>;
<b><font color="0000BB">begin</font></b>
  ModelMatrix.Identity;
  ModelMatrix.Translate(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">30</font>);
  ModelMatrix.RotateA(<font color="#0077BB">0</font>.<font color="#0077BB">25</font>);

  ZPos += Step;
  <b><font color="0000BB">if</font></b> (ZPos > max) <b><font color="0000BB">or</font></b> (ZPos < min) <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    Step *= -<font color="#0077BB">1</font>;
  <b><font color="0000BB">end</font></b>;
  LightPos.Red.z := ZPos;

  ZPos += Step;
  <b><font color="0000BB">if</font></b> (ZPos > max) <b><font color="0000BB">or</font></b> (ZPos < min) <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    Step *= -<font color="#0077BB">1</font>;
  <b><font color="0000BB">end</font></b>;
  LightPos.Green.z := ZPos;

  ZPos += Step;
  <b><font color="0000BB">if</font></b> (ZPos > max) <b><font color="0000BB">or</font></b> (ZPos < min) <b><font color="0000BB">then</font></b> <b><font color="0000BB">begin</font></b>
    Step *= -<font color="#0077BB">1</font>;
  <b><font color="0000BB">end</font></b>;
  LightPos.Blue.z := ZPos;

  ogc.Invalidate;
<b><font color="0000BB">end</font></b>;</pre></code>
Berechnen der 3 Lichtkegel.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">0</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;    <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">1</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inNormal; <i><font color="#FFFF00">// Normale</font></i>

<b><font color="0000BB">out</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataOut;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> ModelMatrix;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">mat4</font></b> Matrix;                    <i><font color="#FFFF00">// Matrix für die Drehbewegung und Frustum.</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  gl_Position    = Matrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  DataOut.Normal = <b><font color="0000BB">mat3</font></b>(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>)).xyz;
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="#008800">#define</font></b> PI            <font color="#0077BB">3</font>.<font color="#0077BB">1415</font>

<i><font color="#FFFF00">// Eine leichte Hintergrundbeleuchtung.</font></i>
<b><font color="#008800">#define</font></b> ambient       <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">2</font>, <font color="#0077BB">0</font>.<font color="#0077BB">15</font>, <font color="#0077BB">0</font>.<font color="#0077BB">095</font>)

<i><font color="#FFFF00">// Farbe des Lichtstrahles.</font></i>
<b><font color="#008800">#define</font></b> yellow        <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">9</font>, <font color="#0077BB">0</font>.<font color="#0077BB">8</font>)

<i><font color="#FFFF00">// Öffnungswinkel der Lampe</font></i>
<i><font color="#FFFF00">// 22.5°</font></i>
<b><font color="#008800">#define</font></b> Cutoff        cos(PI / <font color="#0077BB">2</font> / <font color="#0077BB">4</font>)

<i><font color="#FFFF00">// Lichtrichtung, brennt senkrecht in der Z-Achse.</font></i>
<b><font color="#008800">#define</font></b> spotDirection <b><font color="0000BB">vec3</font></b>(<font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, -<font color="#0077BB">1</font>.<font color="#0077BB">0</font>)

<i><font color="#FFFF00">// Für Abschwächung</font></i>
<i><font color="#FFFF00">// default 0.0</font></i>
<b><font color="#008800">#define</font></b> spotExponent  <font color="#0077BB">50</font>.<font color="#0077BB">0</font>

<i><font color="#FFFF00">// Diese Werte entsprechen Attenuation Parametern vom alten OpenGL.</font></i>
<i><font color="#FFFF00">// default 1.0</font></i>
<b><font color="#008800">#define</font></b> spotAttConst  <font color="#0077BB">1</font>.<font color="#0077BB">0</font>
<i><font color="#FFFF00">// default 0.0</font></i>
<b><font color="#008800">#define</font></b> spotAttLinear <font color="#0077BB">0</font>.<font color="#0077BB">1</font>
<i><font color="#FFFF00">// default 0.0</font></i>
<b><font color="#008800">#define</font></b> spotAttQuad   <font color="#0077BB">0</font>.<font color="#0077BB">0</font>

<b><font color="0000BB">in</font></b> Data {
  <b><font color="0000BB">vec3</font></b> pos;
  <b><font color="0000BB">vec3</font></b> Normal;
} DataIn;

<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> LeftLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> CenterLightPos;
<b><font color="0000BB">uniform</font></b> <b><font color="0000BB">vec3</font></b> RightLightPos;

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;  <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<i><font color="#FFFF00">// Abschwächung, abhängig vom Radius des Lichtes.</font></i>
<b><font color="0000BB">float</font></b> ConeAtt(<b><font color="0000BB">vec3</font></b> LightPos) {
  <b><font color="0000BB">vec3</font></b>  lightDirection = normalize(DataIn.pos - LightPos);

  <b><font color="0000BB">float</font></b> D              = length(LightPos - DataIn.pos);
  <b><font color="0000BB">float</font></b> attenuation    = <font color="#0077BB">1</font>.<font color="#0077BB">0</font> / (spotAttConst + spotAttLinear * D + spotAttQuad * D * D);

  <b><font color="0000BB">float</font></b> angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">if</font></b>(angle > Cutoff) {
    <b><font color="0000BB">return</font></b> attenuation;
  } <b><font color="0000BB">else</font></b> {
    <b><font color="0000BB">return</font></b> <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  }
}

<i><font color="#FFFF00">// Abschwächung anhängig der Lichtentfernung zum Mesh.</font></i>
<b><font color="0000BB">float</font></b> ConeExp(<b><font color="0000BB">vec3</font></b> LightPos) {
  <b><font color="0000BB">vec3</font></b>  lightDirection = normalize(DataIn.pos - LightPos);

  <b><font color="0000BB">float</font></b> angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);

  <b><font color="0000BB">if</font></b>(angle > Cutoff) {
    <b><font color="0000BB">return</font></b> pow(angle, spotExponent);
  } <b><font color="0000BB">else</font></b> {
    <b><font color="0000BB">return</font></b> <font color="#0077BB">0</font>.<font color="#0077BB">0</font>;
  }
}

<i><font color="#FFFF00">// Lichtstärke anhand der Normale.</font></i>
<b><font color="0000BB">float</font></b> light(<b><font color="0000BB">vec3</font></b> p, <b><font color="0000BB">vec3</font></b> n) {
  <b><font color="0000BB">vec3</font></b> v1 = normalize(p);
  <b><font color="0000BB">vec3</font></b> v2 = normalize(n);
  <b><font color="0000BB">float</font></b> d = dot(v1, v2);
  <b><font color="0000BB">return</font></b> clamp(d, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>) {
  <i><font color="#FFFF00">// Grundbeleuchtung</font></i>
  outColor = <b><font color="0000BB">vec4</font></b>(ambient, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
  <b><font color="0000BB">float</font></b> c;

  <i><font color="#FFFF00">// Nur Attenuation ( Links )</font></i>
  c = ConeAtt(LeftLightPos);
  outColor.rgb += <b><font color="0000BB">vec3</font></b>(c) * light(LeftLightPos - DataIn.pos, DataIn.Normal) * yellow;

  <i><font color="#FFFF00">// Nur Exponent ( Mitte )</font></i>
  c = ConeExp(CenterLightPos);
  outColor.rgb += <b><font color="0000BB">vec3</font></b>(c)  * light(CenterLightPos - DataIn.pos, DataIn.Normal) * yellow;

  <i><font color="#FFFF00">// Kombiniert ( Rechte )</font></i>
  <b><font color="0000BB">float</font></b> c1 = ConeAtt(RightLightPos);
  <b><font color="0000BB">float</font></b> c2 = ConeExp(RightLightPos);
  c        = c1 * c2; <i><font color="#FFFF00">// Beide Abschwächungen multipizieren.</font></i>
  outColor.rgb += <b><font color="0000BB">vec3</font></b>(c)  * light(RightLightPos - DataIn.pos, DataIn.Normal) * yellow;
}

</pre></code>

</html>
