# 07 - Beleuchtung
## 40 - Spot Light, einfacher Kegel

![image.png](image.png)

Da es für ein Spotlicht mehrere Schritte braucht, wird dies in mehreren Beispielen gezeigt.

In diesem Beispiel wird zuerst mal gezeigt, wie der Lichtkegen berechnet wird.
Die Beleuchtung berechnung mit den Normalen wird zuerst mal ingnoriert.
So sieht man gut, wie der Lichtkegel entsteht.

---
Bei einem Spotlicht, ist die Lichtposition kein Einheitsvektor mehr.
Die Licht-Position ist ist die effektive Position der Lichtquelle, so wie es bei einer Taschenlampe auch der Fall ist.

Da die **halbe** Seitenlänge der kompletten Meshes etwa 30.0 lang ist, wird das Licht in einem Radius von 25.0 positioniert.
Die Lichtquelle befindet sich somit in dem kompletten Würfel-Körper.

Als Versuch kann man den Radius mal auf 50.0 setzen, dann wird man sehen, das die Lichtquelle ausserhalb der Meshes ist.

Es werden Einheitsvektoren um den Faktor **LichtPositionRadius** skaliert.

```pascal
procedure TForm1.CreateScene;
const
  LichtPositionRadius = 25.0;
begin
  with LightPos do begin
    Red := vec3(-1.0, 0.0, 0.0);
    Red.Scale(LichtPositionRadius);

    Green := vec3(0.0, 1.0, 0.0);
    Green.Scale(LichtPositionRadius);

    Blue := vec3(1.0, 1.0, -1.0);
    Blue.Scale(LichtPositionRadius);
  end;
```


---
Hier wird die Kegelberechnung ausgeführt.

**Vertex-Shader:**

```glsl
#version 330

layout (location = 0) in vec3 inPos;    // Vertex-Koordinaten

out Data {
  vec3 pos;
} DataOut;

uniform mat4 ModelMatrix;
uniform mat4 Matrix;                    // Matrix für die Drehbewegung und Frustum.

void main(void) {
  gl_Position = Matrix * vec4(inPos, 1.0);
  DataOut.pos = (ModelMatrix * vec4(inPos, 1.0)).xyz;
}

```


---
**Fragment-Shader**

Der wichtigste Parameter ist der Ausstrahlwinkel der Lichtes.

Man muss beachten, das der Winkel doppelt so gross wird. Somit hat Pi/2 einen Austrahlwinkel von 180°.
1*Pi entpräche einem Ausstrahlwinkel von 380°, somit bekommt man ein Punkt-Licht.

Für die Berechnung des Kegels wird ein Skalarprodukt verwendet.

```glsl
#version 330

#define ambient vec3(0.2, 0.2, 0.2)
#define red     vec3(1.0, 0.0, 0.0)
#define green   vec3(0.0, 1.0, 0.0)
#define blue    vec3(0.0, 0.0, 1.0)

#define PI      3.1415
#define Cutoff  cos(PI / 2 / 4)

in Data {
  vec3 pos;
} DataIn;

uniform bool RedOn;
uniform bool GreenOn;
uniform bool BlueOn;

uniform vec3 RedLightPos;
uniform vec3 GreenLightPos;
uniform vec3 BlueLightPos;

out vec4 outColor;  // ausgegebene Farbe

// Prüfen ob Fragment in Lichtkegel
vec3 isCone(vec3 LightPos) {

  vec3 lp = LightPos;

  vec3 lightDirection = normalize(DataIn.pos - lp);
  vec3 spotDirection  = normalize(-LightPos);

  float angle = dot(spotDirection, lightDirection);
  angle = max(angle, 0.0);

  if(angle > Cutoff) {
    return vec3(1.0);
  } else {
    return vec3(0.0);
  }
}

void main(void) {
  outColor = vec4(ambient, 1.0);
  if (RedOn) {
    outColor.rgb += isCone(RedLightPos) * red;
  }
  if (GreenOn) {
    outColor.rgb += isCone(GreenLightPos) * green;
  }
  if (BlueOn) {
    outColor.rgb += isCone(BlueLightPos) * blue;
  }
}


```


