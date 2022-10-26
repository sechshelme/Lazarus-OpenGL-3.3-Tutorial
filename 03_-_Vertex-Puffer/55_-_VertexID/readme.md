# 03 - Vertex-Puffer
## 55 - VertexID

![image.png](image.png)

Mit <b>gl_VertexID</b> kann man im Vertex-Shader ermitteln, welcher Vertex aus der Vertex-Array gezeichnet wird.
Das Rendering ist nicht besonderes, es spielt sich alles im Vertex-Shader ab.
---
Die Koordinaten der Mesh, maximal 6 Stück

```pascal
const
  Triangle: array[0..0] of TFace2D =
    (((-0.4, 0.1), (0.4, 0.1), (0.0, 0.7)));
  Quad: array[0..1] of TFace2D =
    (((-0.2, -0.6), (-0.2, -0.1), (0.2, -0.1)),
    (( -0.2, -0.6), (0.2, -0.1), (0.2, -0.6)));
```

---
Da es in diesem Beispiel nur maximal 6 Vertex-Punkte gibt, habe ich die VertexID mit einer einfachen Case-Schleife ausgewertet.
---
<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 10) in vec2 inPos;

out vec3 col;
 
void main(void)
{
  gl_Position = vec4(inPos, 0.0, 1.0);
  switch (gl_VertexID) // Den aktuellen Vertex abfragen.
  {
    case 0:  col = vec3(1.0, 0.0, 0.0);
             break;
    case 1:  col = vec3(0.0, 1.0, 0.0);
             break;
    case 2:  col = vec3(0.0, 0.0, 1.0);
             break;
    case 3:  col = vec3(1.0, 1.0, 0.0);
             break;
    case 4:  col = vec3(0.0, 1.0, 1.0);
             break;
    default: col = vec3(1.0, 0.0, 1.0);
  }
}

```

---
<b>Fragment-Shader</b>

```glsl
#version 330

out vec4 outColor;

in  vec3 col;

void main(void) {
  outColor = vec4(col, 1.0);
}

```


