# 35 - Geometrie-Shader
## 02 - Points

![e image.png](e image.png)

Es ist möglich, nur Punkte zu übegeben, an welche dann im Geometrie-Shader Mehses gerendert werden.
Nur leider ist die Anzahl der Vertex auf 256 begrenzt.

---

---
**Vertex-Shader:**

```glsl
#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
 
void main(void)
{
  gl_Position = vec4(inPos, 1.0);
}

```


---
**Geometrie-Shader:**

```glsl
#version 330

#define distance 0.5
#define size     0.07

layout(points) in;
layout(triangle_strip, max_vertices = 7) out;

out vec3 Color; // Farb-Ausgabe für den Fragment-Shader 

void main(void)
{

// Linke Meshes ( 4 Eck )
   gl_Position = gl_in[0].gl_Position + vec4(-distance, size, size, 0.0);
   Color = vec3(1.0, 0.0, 0.0);
   EmitVertex();

   gl_Position = gl_in[0].gl_Position + vec4(-distance + size, -size, 0.0, 0.0);
   Color = vec3(0.0, 1.0, 0.0);
   EmitVertex();

   gl_Position = gl_in[0].gl_Position + vec4(-distance - size, -size, 0.0, 0.0);
   Color = vec3(0.0, 0.0, 1.0);
   EmitVertex();

   gl_Position = gl_in[0].gl_Position + vec4(-distance, -size * 2, 0.0, 0.0);
   Color = vec3(1.0, 1.0, 1.0);
   EmitVertex();

   EndPrimitive();

// Rechte Meshes ( 3 Eck )
   gl_Position = gl_in[0].gl_Position + vec4(distance, size, size, 0.0);
   Color = vec3(1.0, 1.0, 0.0);
   EmitVertex();

   gl_Position = gl_in[0].gl_Position + vec4(distance + size, -size, 0.0, 0.0);
   Color = vec3(0.0, 1.0, 1.0);
   EmitVertex();

   gl_Position = gl_in[0].gl_Position + vec4(distance - size, -size, 0.0, 0.0);
   Color = vec3(1.0, 0.0, 1.0);
   EmitVertex();

   EndPrimitive();
}

```


---
**Fragment-Shader**

```glsl
#version 330

in vec3 Color;      // Farbe vom Geometrie-Shader.
out vec4 outColor;  // Ausgegebene Farbe.

void main(void)
{
  outColor = vec4(Color, 0.1);
}

```


