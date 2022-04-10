<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
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
<pre><code>procedure TForm1.CreateScene;
const
  LichtPositionRadius = 25.0;</font>
begin
  with LightPos do begin
    Red := vec3(-1.2, 0.0, 4.0);</font>
    Red.Scale(LichtPositionRadius);

    Green := vec3(0.0, 0.0, 4.0);</font>
    Green.Scale(LichtPositionRadius);

    Blue := vec3(1.2, 0.0, 4.0);</font>
    Blue.Scale(LichtPositionRadius);
  end;</pre></code>
Hier werden die 3 Lichter in der Z-Achse bewegt.<br>
<pre><code>procedure TForm1.Timer1Timer(Sender: TObject);
const
  Step: single = 0.5;</font>
  min = 40.0;</font>
  max = 80.0;</font>

  ZPos: single = (max + min) / 2;</font>
begin
  ModelMatrix.Identity;
  ModelMatrix.Translate(0.0, 0.0, 30);</font>
  ModelMatrix.RotateA(0.25);</font>

  ZPos += Step;
  if (ZPos > max) or (ZPos < min) then begin
    Step *= -1;</font>
  end;
  LightPos.Red.z := ZPos;

  ZPos += Step;
  if (ZPos > max) or (ZPos < min) then begin
    Step *= -1;</font>
  end;
  LightPos.Green.z := ZPos;

  ZPos += Step;
  if (ZPos > max) or (ZPos < min) then begin
    Step *= -1;</font>
  end;
  LightPos.Blue.z := ZPos;

  ogc.Invalidate;
end;</pre></code>
Berechnen der 3 Lichtkegel.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 1) in vec3 inNormal; // Normale</font>

out Data {
  vec3 pos;
  vec3 Normal;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void) {
  gl_Position    = Matrix * vec4(inPos, 1.0);</font>

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

#define PI            3.1415</font>

// Eine leichte Hintergrundbeleuchtung.
#define ambient       vec3(0.2, 0.15, 0.095)</font>

// Farbe des Lichtstrahles.
#define yellow        vec3(1.0, 0.9, 0.8)</font>

// Öffnungswinkel der Lampe
// 22.5°
#define Cutoff        cos(PI / 2 / 4)</font>

// Lichtrichtung, brennt senkrecht in der Z-Achse.
#define spotDirection vec3(0.0, 0.0, -1.0)</font>

// Für Abschwächung
// default 0.0
#define spotExponent  50.0</font>

// Diese Werte entsprechen Attenuation Parametern vom alten OpenGL.
// default 1.0
#define spotAttConst  1.0</font>
// default 0.0
#define spotAttLinear 0.1</font>
// default 0.0
#define spotAttQuad   0.0</font>

in Data {
  vec3 pos;
  vec3 Normal;
} DataIn;

uniform vec3 LeftLightPos;
uniform vec3 CenterLightPos;
uniform vec3 RightLightPos;

out vec4 outColor;  // ausgegebene Farbe

// Abschwächung, abhängig vom Radius des Lichtes.
float ConeAtt(vec3 LightPos) {
  vec3  lightDirection = normalize(DataIn.pos - LightPos);

  float D              = length(LightPos - DataIn.pos);
  float attenuation    = 1.0 / (spotAttConst + spotAttLinear * D + spotAttQuad * D * D);

  float angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, 0.0, 1.0);</font>

  if(angle > Cutoff) {
    return attenuation;
  } else {
    return 0.0;</font>
  }
}

// Abschwächung anhängig der Lichtentfernung zum Mesh.
float ConeExp(vec3 LightPos) {
  vec3  lightDirection = normalize(DataIn.pos - LightPos);

  float angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, 0.0, 1.0);</font>

  if(angle > Cutoff) {
    return pow(angle, spotExponent);
  } else {
    return 0.0;</font>
  }
}

// Lichtstärke anhand der Normale.
float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);
  vec3 v2 = normalize(n);
  float d = dot(v1, v2);
  return clamp(d, 0.0, 1.0);</font>
}

void main(void) {
  // Grundbeleuchtung
  outColor = vec4(ambient, 1.0);</font>
  float c;

  // Nur Attenuation ( Links )
  c = ConeAtt(LeftLightPos);
  outColor.rgb += vec3(c) * light(LeftLightPos - DataIn.pos, DataIn.Normal) * yellow;

  // Nur Exponent ( Mitte )
  c = ConeExp(CenterLightPos);
  outColor.rgb += vec3(c)  * light(CenterLightPos - DataIn.pos, DataIn.Normal) * yellow;

  // Kombiniert ( Rechte )
  float c1 = ConeAtt(RightLightPos);
  float c2 = ConeExp(RightLightPos);
  c        = c1 * c2; // Beide Abschwächungen multipizieren.
  outColor.rgb += vec3(c)  * light(RightLightPos - DataIn.pos, DataIn.Normal) * yellow;
}

</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
