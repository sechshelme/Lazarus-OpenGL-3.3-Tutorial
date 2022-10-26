# 02 - Shader
## 40 - Shader Mandelbrot

![image.png](image.png)

Zum Schluss eine kleine Spielerei: Hier wird ein Mandelbrot im Shader (also auf der GPU) berechnet.
Mit der CPU hatte ich noch keine so schnelle Berechnung hingekriegt, trotz Assembler.

Anmerkung: Bei diesem Beispiel geht es nicht um mathematische Hintegründe, sondern es soll legentlich demonstrieren, das man mit Shader-Programs sehr komplexe Berechnungen machen kann.

Der Lazarus-Code ist nichts besonderes, es wird nur ein Rechteck gerendert und anschliessend mit einer Matrix gedreht. Was eine Matrix ist, wird im Kapitel Matrix beschrieben.
<b>Achtung:</b> Eine lahme Grafikkarte kann bei Vollbild ins Stockern kommen.
Zur Beschleunigung kann der Wert <b>#define depth 1000.0</b> im Fragment-Shader verkleinert werden.
---
<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 10) in vec3 inPos;   // Vertex-Koordinaten

uniform mat4 mat;

out vec2 pos;                           // Koordinaten für den Fragment-Shader

void main(void) {
  gl_Position = mat * vec4(inPos, 1.0);
  pos = gl_Position.xy;                 // XY an Fragment-Shader
}

```

---
<b>Fragment-Shader:</b>

Hier steckt die ganze Berechnung für das Mandelbrot.

```glsl
#version 330
#define depth 1000.0

in vec2 pos;       // Interpolierte Koordinaten vom Vertex-Shader

uniform float col; // Start-Wert, für Farben-Spielerei

out vec4 outColor;

void main(void) {
  float creal = pos.x * 1.5 - 0.3;
  float cimag = pos.y * 1.5;

  float Color = 0.0;
  float XPos  = 0.0;
  float YPos  = 0.0;

  float SqrX, SqrY;

  do {
    SqrX   = XPos * XPos;
    SqrY   = YPos * YPos;
    YPos   = XPos * YPos * 2 + cimag;
    XPos   = SqrX - SqrY + creal;
    Color += 1;
  } while (!((SqrX + SqrY &gt; 8) || (Color &gt; depth)));

  Color += col;

  if (Color &gt; depth) {
    Color -= depth;
  }

  outColor = vec4(Color / 3, Color / 10 , Color / 100, 1.0);
}

```


