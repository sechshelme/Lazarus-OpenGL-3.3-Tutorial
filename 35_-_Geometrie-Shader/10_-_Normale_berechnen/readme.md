# 35 - Geometrie-Shader
## 10 - Normale berechnen

![e image.png](e image.png)


---
Den Geometrie-Shader kann man auch gut verwenden um Normale für Beleuchtungen zu berechnen.

---
**Vertex-Shader:**

```glsl
#version 330

layout (location = 0) in vec3 inPos;

layout (std140) uniform UBO {
  mat4x4 WorldMatrix;
  mat4x4 ModelMatrix;
};

out vec3 vcol;

void main(void)
{
  gl_Position = WorldMatrix * ModelMatrix * vec4(inPos, 1.0);

  switch (gl_VertexID / 6) // Den aktuellen Vertex abfragen.
  {
    case 0:  vcol = vec3(1.0, 0.0, 0.0);
             break;
    case 1:  vcol = vec3(0.0, 1.0, 0.0);
             break;
    case 2:  vcol = vec3(0.0, 0.0, 1.0);
             break;
    case 3:  vcol = vec3(1.0, 1.0, 0.0);
             break;
    case 4:  vcol = vec3(0.0, 1.0, 1.0);
             break;
    default: vcol = vec3(1.0, 0.0, 1.0);
  }}

```


---
**Geometrie-Shader:**

```glsl
#version 330

layout(triangles) in;
layout(triangle_strip, max_vertices = 12) out;

in vec3 vcol[];

out vec3 gnorm;
out vec3 gcol;

void main(void)

{
   vec3 n = cross(gl_in[2].gl_Position.xyz - gl_in[0].gl_Position.xyz,
                  gl_in[1].gl_Position.xyz - gl_in[0].gl_Position.xyz);

   for(int i = 0; i < gl_in.length(); i++)
   {
      gl_Position = gl_in[i].gl_Position;
      gnorm = n;
      gcol = vcol[i];
      EmitVertex();
   }
   EndPrimitive();
}


```


---
**Fragment-Shader**

```glsl
#version 330

#define LightPos0 vec3(1.0, 1.0, -1.0)
#define LightPos1 vec3(-1.0, 1.0, 0.0)
#define ambient0 1.4
#define ambient1 0.2

in vec3 gnorm;
in vec3 gcol;

out vec4 outColor;

float light(vec3 p, vec3 n) {
  vec3  v1 = normalize(p);
  vec3  v2 = normalize(n);
  float d  = dot(v1, v2);
  float c  = clamp(d, 0.0, 1.0);
  return c;
}

void main(void)
{
  float l0 = light(LightPos0, gnorm) * ambient0;
  float l1 = light(LightPos1, gnorm) * ambient1;

  vec3 col = gcol * (l0 + l1) ;
  outColor = vec4(col, 1.0);
}

```


