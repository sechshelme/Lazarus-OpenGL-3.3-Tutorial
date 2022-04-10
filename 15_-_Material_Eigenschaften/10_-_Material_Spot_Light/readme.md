<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>15 - Material Eigenschaften</h1></b>
    <b><h2>10 - Material Spot Light</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Material-Eigenschaften sind auch mit Spot-Light möglich.<br>
Dies funktioniert etwa gleich, wie das Point-Light ohne Material-Eigenschaften.<br>
<br>
Bei diesem Beispiel, wird mit einer Taschenlampe in einen Jade-Würfel gezündet.<br>
<hr><br>
<hr><br>
Dieser Shader ist schon sehr komplex.<br>
Neben der Spotlichtberechnung, wird noch die Abschwächung des Lichtes berücksichtigt.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 1) in vec3 inNormal; // Normale</font>

// Daten für Fragment-shader
out Data {
  vec3 Pos;
  vec3 Normal;
} DataOut;

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;

void main(void) {
  gl_Position    = Matrix * vec4(inPos, 1.0);</font>

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

#define PI         3.1415</font>

// === Licht
#define Lposition  vec3(0.0, 0.0, 100.0)</font>
#define Lambient   vec3(1.8, 1.8, 1.8)</font>
#define Ldiffuse   vec3(1000.0, 1000.0, 1000.0)</font>

// === Material ( Jade )
#define Mambient   vec3(0.14, 0.22, 0.16)</font>
#define Mdiffuse   vec3(0.54, 0.89, 0.63)</font>
#define Mspecular  vec3(0.32, 0.32, 0.32)</font>
#define Mshininess 12.8</font>

// === Spotlicht Parameter
// Öffnungswinkel der Lampe
// 22.5°
#define Cutoff        cos(PI / 2 / 4)</font>

// Lichtrichtung, brennt senkrecht in der Z-Achse.
#define spotDirection vec3(0.0, 0.0, -1.0)</font>

// === Für Abschwächung
// default 0.0
#define spotExponent  50.0</font>

// Diese Werte entsprechen Attenuation Parametern vom alten OpenGL.
// default 1.0
#define spotAttConst  1.0</font>
// default 0.0
#define spotAttLinear 0.0</font>
// default 0.0
#define spotAttQuad   0.1</font>


// Daten vom Vertex-Shader
in Data {
  vec3 Pos;
  vec3 Normal;
} DataIn;

out vec4 outColor;

// Abschwächung, abhängig vom Radius des Lichtes.
float ConeAtt(vec3 LightPos) {
  vec3  lightDirection = normalize(DataIn.Pos - LightPos);

  float D              = length(LightPos - DataIn.Pos);
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
  vec3  lightDirection = normalize(DataIn.Pos - LightPos);

  float angle          = dot(spotDirection, lightDirection);
  angle                = clamp(angle, 0.0, 1.0);</font>

  if(angle > Cutoff) {
    return pow(angle, spotExponent);
  } else {
    return 0.0;</font>
  }
}

// Lichtstärke und Material anhand der Normale.
vec3 Light(in vec3 p, in vec3 n) {
  vec3 nn = normalize(n);
  vec3 np = normalize(p);
  vec3 diffuse;   // Licht
  vec3 specular;  // Reflektion
  float angele = max(dot(nn, np), 0.0);</font>
  if (angele > 0.0) {</font>
    vec3 eye = normalize(np + vec3(0.0, 0.0, 1.0));</font>
    specular = pow(max(dot(eye, nn), 0.0), Mshininess) * Mspecular;
    diffuse  = angele * Mdiffuse * Ldiffuse;
  } else {
    specular = vec3(0.0);</font>
    diffuse  = vec3(0.0);</font>
  }
  return (Mambient * Lambient) + diffuse + specular;
}

void main(void) {
  float c  = ConeAtt(Lposition) * ConeExp(Lposition); // Beide Abschwächungen multipizieren.
  outColor = vec4(vec3(c)  * Light(Lposition - DataIn.Pos, DataIn.Normal), 1.0);</font>
}

</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
