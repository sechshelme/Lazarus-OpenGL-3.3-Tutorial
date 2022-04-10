<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>07 - Beleuchtung</h1></b>
    <b><h2>40 - Spot Light, einfacher Kegel</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Da es für ein Spotlicht mehrere Schritte braucht, wird dies in mehreren Beispielen gezeigt.<br>
<br>
In diesem Beispiel wird zuerst mal gezeigt, wie der Lichtkegen berechnet wird.<br>
Die Beleuchtung berechnung mit den Normalen wird zuerst mal ingnoriert.<br>
So sieht man gut, wie der Lichtkegel entsteht.<br>
<hr><br>
Bei einem Spotlicht, ist die Lichtposition kein Einheitsvektor mehr.<br>
Die Licht-Position ist ist die effektive Position der Lichtquelle, so wie es bei einer Taschenlampe auch der Fall ist.<br>
<br>
Da die <b>halbe</b> Seitenlänge der kompletten Meshes etwa 30.0 lang ist, wird das Licht in einem Radius von 25.0 positioniert.<br>
Die Lichtquelle befindet sich somit in dem kompletten Würfel-Körper.<br>
<br>
Als Versuch kann man den Radius mal auf 50.0 setzen, dann wird man sehen, das die Lichtquelle ausserhalb der Meshes ist.<br>
<br>
Es werden Einheitsvektoren um den Faktor <b>LichtPositionRadius</b> skaliert.<br>
<pre><code>procedure TForm1.CreateScene;
const
  LichtPositionRadius = 25.0;</font>
begin
  with LightPos do begin
    Red := vec3(-1.0, 0.0, 0.0);</font>
    Red.Scale(LichtPositionRadius);

    Green := vec3(0.0, 1.0, 0.0);</font>
    Green.Scale(LichtPositionRadius);

    Blue := vec3(1.0, 1.0, -1.0);</font>
    Blue.Scale(LichtPositionRadius);
  end;</pre></code>
<hr><br>
Hier wird die Kegelberechnung ausgeführt.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>

out Data {
  vec3 pos;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void) {
  gl_Position = Matrix * vec4(inPos, 1.0);</font>
  DataOut.pos = (ModelMatrix * vec4(inPos, 1.0)).xyz;</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<br>
Der wichtigste Parameter ist der Ausstrahlwinkel der Lichtes.<br>
<br>
Man muss beachten, das der Winkel doppelt so gross wird. Somit hat Pi/2 einen Austrahlwinkel von 180°.<br>
1*Pi entpräche einem Ausstrahlwinkel von 380°, somit bekommt man ein Punkt-Licht.<br>
<br>
Für die Berechnung des Kegels wird ein Skalarprodukt verwendet.<br>
<pre><code>#version 330</font>

#define ambient vec3(0.2, 0.2, 0.2)</font>
#define red     vec3(1.0, 0.0, 0.0)</font>
#define green   vec3(0.0, 1.0, 0.0)</font>
#define blue    vec3(0.0, 0.0, 1.0)</font>

#define PI      3.1415</font>
#define Cutoff  cos(PI / 2 / 4)</font>

in Data {
  vec3 pos;
} DataIn;

uniform bool RedOn;
uniform bool GreenOn;
uniform bool BlueOn;

uniform vec3 RedLightPos;
uniform vec3 GreenLightPos;
uniform vec3 BlueLightPos;

out vec4 outColor;  // ausgegebene Farbe

// Prüfen ob Fragment in Lichtkegel
vec3 isCone(vec3 LightPos) {

  vec3 lp = LightPos;

  vec3 lightDirection = normalize(DataIn.pos - lp);
  vec3 spotDirection  = normalize(-LightPos);

  float angle = dot(spotDirection, lightDirection);
  angle = max(angle, 0.0);</font>

  if(angle > Cutoff) {
    return vec3(1.0);</font>
  } else {
    return vec3(0.0);</font>
  }
}

void main(void) {
  outColor = vec4(ambient, 1.0);</font>
  if (RedOn) {
    outColor.rgb += isCone(RedLightPos) * red;
  }
  if (GreenOn) {
    outColor.rgb += isCone(GreenLightPos) * green;
  }
  if (BlueOn) {
    outColor.rgb += isCone(BlueLightPos) * blue;
  }
}

</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
