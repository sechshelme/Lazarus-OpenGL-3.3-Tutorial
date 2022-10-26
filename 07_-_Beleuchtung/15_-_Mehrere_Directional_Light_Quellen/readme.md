# 07 - Beleuchtung
## 15 - Mehrere Directional Light Quellen

![image.png](image.png)

Wie schon beschrieben, sind auch mehrere Lichtquellen möglich.

In diesem Beispiel habe ich 3 Directionale Lichtquellen eingefügt, welche sich bewegen.
Das man die einzelnen Lichquellen besser sieht, habe ich sie in 3 Farben dargestellt.

Als Meshes habe ich Kugeln gewählt, so sieht man die Übergänge von hell nach dunkel besser.

Das man die Lichteffekte besser sieht, kann man sie über das Menü ein und aus schalten.
Auch kann man die Rotierung anhalten und die Anzahl der Kugeln verändern.

Wen man nur eine Kugel hat, sieht man die Bewegung des Lichtes sehr gut.
Wen man alle 3 Lichter ausschaltet, dann sieht man die Ambiente Hintergrund-Beleuchtung sehr gut.

Die Lichtposition ist nicht mehr im Shader als Konstante deklariert, sie wurde mit einer <b>Uniform-Variable</b> nach aussen verlagert.
---
Die Lichtpositionen als 3D-Vektorn definiert.

```pascal
var
  LightPos: record
    Red, Green, Blue: TVector3f;
  end;
```

Hier werden die verschiedenen Parameter für die Lichtparamter über Uniform am Shader übergeben.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y, z: integer;
  scal, d: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  // Lichtpositionen
  with LightPos_ID do begin
    glUniform3fv(Red, 1, @LightPos.Red);
    glUniform3fv(Green, 1, @LightPos.Green);
    glUniform3fv(Blue, 1, @LightPos.Blue);
  end;

  // Licht Ein/Aus - Parameter
  with ColorOn_ID do begin
    glUniform1i(Red, GLint(MenuItemRedOn.Checked));
    glUniform1i(Green, GLint(MenuItemGreenOn.Checked));
    glUniform1i(Blue, GLint(MenuItemBlueOn.Checked));
  end;
```

Auf verlangen Würfel drehen und Lichtposition verändern.

```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if MenuItemRotateCube.Checked then begin
    ModelMatrix.RotateA(0.0123);  // Drehe um X-Achse
    ModelMatrix.RotateB(0.0234);  // Drehe um Y-Achse
  end;

  with LightPos do begin
    if MenuItemRotateRed.Checked then begin
      Red.RotateA(0.031);
      Red.RotateB(0.011);
    end;

    if MenuItemRotateGreen.Checked then begin
      Green.RotateB(0.021);
      Green.RotateC(0.015);
    end;

    if MenuItemRotateBlue.Checked then begin
      Blue.RotateA(0.021);
      Blue.RotateC(0.023);
    end;
  end;
```

---
Wen man mehrere Lichtquellen hat, werden diese alle <b>addiert</b>.
Dies sieht man gut am Ende des Vertex-Shader, dort wo es die<b> += </b>hat.

<b>Vertex-Shader:</b>

```glsl
#version 330

// Konstante für Abiente Hintergrundbeleuchung.
#define ambient vec3(0.2, 0.2, 0.2)

// Die Farben der Lichtstrahlen.
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten
layout (location = 1) in vec3 inNormal; // Normale

out vec4 Color;                         // Farbe, an Fragment-Shader übergeben.

// Matrix des Modeles, ohne Frustum-Beeinflussung.
uniform mat4 ModelMatrix;

// Matrix für die Drehbewegung und Frustum.
uniform mat4 Matrix;

// Einzelne Lichtquellen Ein/Aus.
uniform bool RedOn;
uniform bool GreenOn;
uniform bool BlueOn;

// Position der Lichtquellen.
uniform vec3 RedLightPos;
uniform vec3 GreenLightPos;
uniform vec3 BlueLightPos;

// Berechnet die Ausleuchtung der einzelnen Faces.
float light(vec3 p, vec3 n) {
  vec3 v1 = normalize(p);     // Vektoren normalisieren,
  vec3 v2 = normalize(n);     // so das es Einheitsvektoren gibt.
  float d = dot(v1, v2);      // Skalarprodukt aus beiden Vektoren berechnen.
  return clamp(d, 0.0, 1.0);  // Bereich der Ausgabe einschränken.
}

void main(void) {
  // Vektoren mit komplette vorberechneter Matrix multipizieren.
  gl_Position = Matrix * vec4(inPos, 1.0);

  // Normale nur mit lokaler Matrix Multipizieren.
  vec3 Normal = mat3(ModelMatrix) * inNormal;

  // Ambiente Lichtquelle
  Color = vec4(ambient, 1.0);

  // Lichtquellen auf verlangen berechnen und addieren.
  if (RedOn) {
    vec3 colRed = light(RedLightPos, Normal) * red;
    Color.rgb += colRed;
  }
  if (GreenOn) {
    vec3 colGreen = light(GreenLightPos, Normal) * green;
    Color.rgb += colGreen;
  }
  if (BlueOn) {
    vec3 colBlue = light(BlueLightPos, Normal) * blue;
    Color.rgb += colBlue;
  }
}

```

---
<b>Fragment-Shader</b>

```glsl
#version 330

in  vec4 Color;     // interpolierte Farbe vom Vertexshader
out vec4 outColor;  // ausgegebene Farbe

void main(void) {
  outColor = Color; // Die Ausgabe der Farbe
}

```


