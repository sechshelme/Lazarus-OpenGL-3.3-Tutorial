# 02 - Shader
## 35 - Punkte verschieden darstellen

![image.png](image.png)

Man kann auch Punkte mit dem Shader darstellen, dies kann man auf verschiedene Weise.
Im Fragment-Shader kann man das Zeichen der Punkte manipulieren.

---
Die Deklaration der Koordianten und Punktgrösse.

```pascal
type
  TPoint=record
    vec: TVector2f;
    PointSize: GLfloat;
    end;

var
  Point: array of TPoint;
```

Daten für die Punkte in die Grafikkarte übertragen

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBPoint.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TPoint) * Length(Point), Pointer(Point), GL_STATIC_DRAW);

  // Daten für Punkt Position
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 2, GL_FLOAT, GL_FALSE, SizeOf(TPoint), nil);

  // Daten für Punkt Grösse
  glEnableVertexAttribArray(11);
  glVertexAttribPointer(11, 1, GL_FLOAT, GL_FALSE, SizeOf(TPoint), Pointer(8));
end;

```

Zeichnen der Punkte

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  ofs = 0.4;
begin
  glEnable(GL_PROGRAM_POINT_SIZE);

  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBPoint.VAO);
  // gelb
  glUniform1i(PointTyp_ID, 0);
  glUniform3f(Color_ID, 1.0, 1.0, 0.0);
  glUniform1f(X_ID, -ofs);
  glUniform1f(Y_ID, -ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));

  // rot
  glUniform1i(PointTyp_ID, 1);
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);
  glUniform1f(X_ID, ofs);
  glUniform1f(Y_ID, -ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));

  // grün
  glUniform1i(PointTyp_ID, 2);
  glUniform3f(Color_ID, 0.0, 1.0, 0.0);
  glUniform1f(X_ID, ofs);
  glUniform1f(Y_ID, ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));

  // blau
  glUniform1i(PointTyp_ID, 3);
  glUniform3f(Color_ID, 0.0, 0.0, 1.0);
  glUniform1f(X_ID, -ofs);
  glUniform1f(Y_ID, ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));

  ogc.SwapBuffers;
end;

```


---
**Vertex-Shader:**

```glsl
#version 330

layout (location = 10) in vec2  inPos;  // Vertex-Koordinaten in 2D
layout (location = 11) in float inSize; // Grösse der Punkte
uniform float x;                        // Richtung von Uniform
uniform float y;
 
void main(void)
{
  vec2 pos = inPos;
  pos.x = pos.x + x;
  pos.y = pos.y + y;
  gl_PointSize = inSize;
  gl_Position  = vec4(pos, 0.0, 1.0);   // Der zweiter Parameter (Z) auf 0.0
}

```


---
**Fragment-Shader:**

```glsl
#version 330

uniform vec3 Color  ;  // Farbe von Uniform
out     vec4 outColor; // ausgegebene Farbe

uniform int PointTyp;

void main(void)
{
  vec2  p = gl_PointCoord * 2.0 - vec2(1.0);
  float r = sqrt(dot(p, p));

  float theta = atan(p.y, p.x);

  switch (PointTyp){
    case 0: if (dot(gl_PointCoord - 0.5, gl_PointCoord - 0.5) > 0.25)
              discard;
            else
              outColor = vec4(Color, 1.0);
            break;
    case 1: if (dot(p, p) > cos(theta * 5))
              discard;
            else
              outColor = vec4(Color, 1.0);
            break;
    case 2: if (dot(p, p) > r || dot(p, p) < r * 0.75)
              discard;
            else
              outColor = vec4(Color, 1.0);
            break;
    case 3: if (dot(p, p) > 5.0 / cos(theta - 20 * r))
              discard;
            else
              outColor = vec4(Color, 1.0);
            break;
    default: discard;

  }
}

```


