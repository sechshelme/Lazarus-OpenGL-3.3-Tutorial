# 55 - Diverses
## 15 - Transform feedback

![image.png](image.png)


---
Diese Funktion ist ideal, wen man die GPU als Rechenknecht missbrauchen will.
Auf einem I7 konnte ich einen Zahlenkette bis zu 100x schneller berechen als mit der FPU.

---
**Vertex-Shader:**
Es wird nur ein Veretex-Shader gebraucht.

```glsl
#version 330

layout (location =  0) in float inValue;

out float outSqrt;
out mat4x4 outMat;

void main(void)
{
  outSqrt = sqrt(inValue);
  for (int x = 0; x < 4; x++)
  {
    for (int y = 0; y < 4; y++)
    {
      outMat[y][x] = (x + y * 4) * inValue;
    }
  }
}

```


---

