# 04 - Matrix
## 00 - Was ist eine Matrix

Der mathematische Teil von Matrix wird hier nicht behandelt, in diesem Tutorial geht es nur um die Anwendung davon.

Wen jemand den mathematischen Teil interessiert, gibt es schon fertige Tutorials dazu.
Der zweite Grund, ich versteht das auch nicht Ganz, und somit will ich verhindern, das ich etwas falsches weiter gebe. :ops:

Was ein wenig irritiert, auf der <b>2D</b>-Ebene wird eine <b>3x3</b>-Matrix verwendet und in der <b>3D</b>-Ebene eine 4<b>x4</b>-Matrix.
Einfach gesagt, die vorderen Spalten beinhalten die Richtung und Skalierung, die hinterste Spalte die Position.

Ich habe eine fertige Bibliotheke für Matrizen, bei der ich die gängigen Funktionen beschreiben will.
Es wird hier fast nur eine <b>4x4</b>-Matrix verwendet, die Standard mässig so auf gebaut ist:
|   |   |   |   |
|---|---|---|---|
| 1 | 0 | 0 | 0 |
| 0 | 1 | 0 | 0 |
| 0 | 0 | 1 | 0 |
| 0 | 0 | 0 | 1 |

Die Abbildung zeigt eine Einheitsmatrix, die meisten OpenGL-Funktionen nehmen diese als Basis. Mit der 4x4-Matrix sind alle Bewegungen, Skalierungen, inklusive Perspektive möglich.
Hier eine kleine Einführung, die zeigt, welche Werte in der Matrix für die verschiedenen Bewegungen verändert werden.

Die Matrix bildet die drei Achsen und eine Verschiebung ab. Die grossen Buchstaben zeigen die Achse, die kleinen die Position der Achsen.
Die hinterste Spalte gibt die Verschiebung an. Die unterste Zeile wird nur verändert bei Perspektiven und bei Multiplikationen,
|   |   |   |   |
|---|---|---|---|
| Xx | Yx | Zx | x0 |
| Xy | Yy | Zy | y0 |
| Xz | Yz | Zz | z0 |
|  0 |  0 |  0 |  1 |


Für die Verschiebungen (<b>Translate</b>):
|   |   |   |   |
|---|---|---|---|
|  1 |  0 |  0 | tx |
|  0 |  1 |  0 | ty |
|  0 |  0 |  1 | tz |
|  0 |  0 |  0 |  1 |



Für die Skalierung (<b>Scale</b>):
|   |   |   |   |
|---|---|---|---|
| sx |  0 |  0 | tx |
|  0 | sy |  0 | ty |
|  0 |  0 | sz | tz |
|  0 |  0 |  0 |  1 |



Für die Rotation A-Achse (<b>RotateA</b>):
|   |   |   |   |
|---|---|---|---|
|    1   |    0   |    0   |    0   |
|    0   | cos(d) |-sin(d) |    0   |
|    0   | sin(d) | cos(d) |    0   |
|    0   |    0   |    0   |    1   |



Für die Rotation B-Achse (<b>RotateB</b>):
|   |   |   |   |
|---|---|---|---|
|  cos(d) |    0   | sin(d) |    0   |
|     0   |    1   |    0   |    0   |
| -sin(d) |    0   | cos(d) |    0   |
|     0   |    0   |    0   |    1   |



Für die Rotation C-Achse (<b>RotateC</b>):
|   |   |   |   |
|---|---|---|---|
| cos(d) |-sin(d) |    0   |    0   |
| sin(d) | cos(d) |    0   |    0   |
|    0   |    0   |    1   |    0   |
|    0   |    0   |    0   |    1   |

---
Die Anwendung der <b>Matrix-Bibliothek</b> ist sehr einfach, so das man nicht mal wissen muss, wie eine Matrix aufgebaut ist.

```pascal
var
  Matrix : TMatrix;

begin
  Matrix.Indenty;                // Matrix Indenty setzen.

  Matrix.xxxx(...);              // Modifikationen der Matrix.
  Matrix.Uniform(ID_im_Shader);  // Die Matrix dem Shader übergeben.
```

Ausser im ersten Beispiel werde ich nur noch diese <b>Bibliothek</b> verwenden. Somit werden die Beispiele sehr übersichtlich.

