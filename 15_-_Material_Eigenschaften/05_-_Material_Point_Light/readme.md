# 15 - Material Eigenschaften
## 05 - Material Point Light

![image.png](image.png)

Material-Eigenschaften sind auch mit <b>Point-Light</b> möglich.
Dies funktioniert etwa gleich, wie das Point-Light ohne Material-Eigenschaften.

In diesem Beispiel sind die Kugeln aus Kupfer.
---
---
Der einzige Unterschied gegenüber des Directional-Light befindet sich im Shader.

<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

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
  gl_Position    = Matrix * vec4(inPos, 1.0);

  DataOut.Normal = mat3(ModelMatrix) * inNormal;
  DataOut.Pos    = (ModelMatrix * vec4(inPos, 1.0)).xyz;
}

```

---
<b>Fragment-Shader</b>

```glsl
#version 330

// Licht
#define Lposition  vec3(35.0, 17.5, 35.0)
#define Lambient   vec3(1.8, 1.8, 1.8)
#define Ldiffuse   vec3(1.5, 1.5, 1.5)

// Material ( Poliertes Kupfer  )
#define Mambient   vec3(0.23, 0.09, 0.03)
#define Mdiffuse   vec3(0.55, 0.21, 0.07)
#define Mspecular  vec3(0.58, 0.22, 0.07)
#define Mshininess 51.2

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
  float angele = max(dot(nn, np), 0.0);
  if (angele > 0.0) {
    vec3 eye = normalize(np + vec3(0.0, 0.0, 1.0));
    specular = pow(max(dot(eye, nn), 0.0), Mshininess) * Mspecular;
    diffuse  = angele * Mdiffuse * Ldiffuse;
  } else {
    specular = vec3(0.0);
    diffuse  = vec3(0.0);
  }
  return (Mambient * Lambient) + diffuse + specular;
}

void main(void) {
  outColor = vec4(Light(Lposition - DataIn.Pos, DataIn.Normal), 1.0);
}


```


