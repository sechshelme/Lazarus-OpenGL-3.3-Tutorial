<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>15 - Material Eigenschaften</h1></b>
    <b><h2>05 - Material Point Light</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Material-Eigenschaften sind auch mit <b>Point-Light</b> möglich.<br>
Dies funktioniert etwa gleich, wie das Point-Light ohne Material-Eigenschaften.<br>
<br>
In diesem Beispiel sind die Kugeln aus Kupfer.<br>
<hr><br>
<hr><br>
Der einzige Unterschied gegenüber des Directional-Light befindet sich im Shader.<br>
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

// Licht
#define Lposition  vec3(35.0, 17.5, 35.0)</font>
#define Lambient   vec3(1.8, 1.8, 1.8)</font>
#define Ldiffuse   vec3(1.5, 1.5, 1.5)</font>

// Material ( Poliertes Kupfer  )
#define Mambient   vec3(0.23, 0.09, 0.03)</font>
#define Mdiffuse   vec3(0.55, 0.21, 0.07)</font>
#define Mspecular  vec3(0.58, 0.22, 0.07)</font>
#define Mshininess 51.2</font>

// Daten vom Vertex-Shader
in Data {
  vec3 Pos;
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
  outColor = vec4(Light(Lposition - DataIn.Pos, DataIn.Normal), 1.0);</font>
}

</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
