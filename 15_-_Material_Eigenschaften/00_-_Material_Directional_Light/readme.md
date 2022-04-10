<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>15 - Material Eigenschaften</h1></b>
    <b><h2>00 - Material Directional Light</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Nur eine Beleuchtung reicht nicht, das eine Mesh realistisch aussieht.<br>
Aus diesem Grund, kann man der Mesh Materialeigenschaften mitgeben, dies sind Reflektionen des Lichtes.<br>
Wen man zB. eine Gummi-Fläche anleuchtet, sieht dies anders aus, als bei einer Stahlfläche.<br>
Stahl reflektiert das Licht viel besser.<br>
Dieses Beispiel zeigt wie dies bei Gold aussieht. Wen man im INet nach <b>"OpenGL Material"</b> sucht,<br>
findet man viele Daten, welche man bei <b>Ambient</b>, <b>Diffuse</b>, <b>Specular</b> und <b>Shininess</b> eintragen muss.<br>
<br>
Bei diesem Beispiel sind die Kugeln aus Gold.<br>
<hr><br>
<hr><br>
Die Berechnung, ist ähnlich wie beim einfachen Licht. Zusätlich wird <b>Specular</b> zum normalen Licht addiert.<br>
<b>Specular</b> ist die Reflektion de Materiales.<br>
<b>Diffuse</b> ist die Farbe des Lichtes/Material.<br>
<br>
Im Shader sind alle Material-Eigenschaft als <b>#define</b> deklariert. Dies könnte man auch als <b>Uniform</b> übergeben.<br>
<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten</font>
layout (location = 1) in vec3 inNormal; // Normale</font>

// Daten für Fragment-shader
out Data {
  vec3 Normal;
} DataOut;

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;

void main(void) {
  gl_Position    = Matrix * vec4(inPos, 1.0);</font>
  DataOut.Normal = mat3(ModelMatrix) * inNormal;
}

</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

// Licht
#define Lposition  vec3(1.0, 0.5, 1.0)</font>
#define Lambient   vec3(1.2, 1.2, 1.2)</font>
#define Ldiffuse   vec3(1.5, 1.5, 1.5)</font>

// Material ( Gold )
#define Mambient   vec3(0.25, 0.20, 0.07)</font>
#define Mdiffuse   vec3(0.75, 0.60, 0.23)</font>
#define Mspecular  vec3(0.63, 0.56, 0.37)</font>
#define Mshininess 51.2</font>

// Daten vom Vertex-Shader
in Data {
  vec3 Normal;
} DataIn;

out vec4 outColor;

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
  outColor = vec4(Light(Lposition, DataIn.Normal), 1.0);</font>
}
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
