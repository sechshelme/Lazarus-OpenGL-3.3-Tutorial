<!DOCTYPE html>
<html>
    <b><h1>04 - Matrix</h1></b>
    <b><h2>00 - Was ist eine Matrix</h2></b>
Der mathematische Teil von Matrix wird hier nicht behandelt, in diesem Tutorial geht es nur um die Anwendung davon.<br>
<br>
Wen jemand den mathematischen Teil interessiert, gibt es schon fertige Tutorials dazu.<br>
Der zweite Grund, ich versteht das auch nicht Ganz, und somit will ich verhindern, das ich etwas falsches weiter gebe. :ops:<br>
<br>
Was ein wenig irritiert, auf der <b>2D</b>-Ebene wird eine <b>3x3</b>-Matrix verwendet und in der <b>3D</b>-Ebene eine 4<b>x4</b>-Matrix.<br>
Einfach gesagt, die vorderen Spalten beinhalten die Richtung und Skalierung, die hinterste Spalte die Position.<br>
<br>
Ich habe eine fertige Bibliotheke für Matrizen, bei der ich die gängigen Funktionen beschreiben will.<br>
Es wird hier fast nur eine <b>4x4</b>-Matrix verwendet, die Standard mässig so auf gebaut ist:<br>
//matrix+<br>
| 1 | 0 | 0 | 0 |<br>
| 0 | 1 | 0 | 0 |<br>
| 0 | 0 | 1 | 0 |<br>
| 0 | 0 | 0 | 1 |<br>
//matrix-<br>
Die Abbildung zeigt eine Einheitsmatrix, die meisten OpenGL-Funktionen nehmen diese als Basis. Mit der 4x4-Matrix sind alle Bewegungen, Skalierungen, inklusive Perspektive möglich.<br>
Hier eine kleine Einführung, die zeigt, welche Werte in der Matrix für die verschiedenen Bewegungen verändert werden.<br>
<br>
Die Matrix bildet die drei Achsen und eine Verschiebung ab. Die grossen Buchstaben zeigen die Achse, die kleinen die Position der Achsen.<br>
Die hinterste Spalte gibt die Verschiebung an. Die unterste Zeile wird nur verändert bei Perspektiven und bei Multiplikationen,<br>
//matrix+<br>
| Xx | Yx | Zx | x0 |<br>
| Xy | Yy | Zy | y0 |<br>
| Xz | Yz | Zz | z0 |<br>
|  0 |  0 |  0 |  1 |<br>
//matrix-<br>
<br>
Für die Verschiebungen (<b>Translate</b>):<br>
//matrix+<br>
|  1 |  0 |  0 | tx |<br>
|  0 |  1 |  0 | ty |<br>
|  0 |  0 |  1 | tz |<br>
|  0 |  0 |  0 |  1 |<br>
//matrix-<br>
<br>
<br>
Für die Skalierung (<b>Scale</b>):<br>
//matrix+<br>
| sx |  0 |  0 | tx |<br>
|  0 | sy |  0 | ty |<br>
|  0 |  0 | sz | tz |<br>
|  0 |  0 |  0 |  1 |<br>
//matrix-<br>
<br>
<br>
Für die Rotation A-Achse (<b>RotateA</b>):<br>
//matrix+<br>
|    1   |    0   |    0   |    0   |<br>
|    0   | cos(d) |-sin(d) |    0   |<br>
|    0   | sin(d) | cos(d) |    0   |<br>
|    0   |    0   |    0   |    1   |<br>
//matrix-<br>
<br>
<br>
Für die Rotation B-Achse (<b>RotateB</b>):<br>
//matrix+<br>
|  cos(d) |    0   | sin(d) |    0   |<br>
|     0   |    1   |    0   |    0   |<br>
| -sin(d) |    0   | cos(d) |    0   |<br>
|     0   |    0   |    0   |    1   |<br>
//matrix-<br>
<br>
<br>
Für die Rotation C-Achse (<b>RotateC</b>):<br>
//matrix+<br>
| cos(d) |-sin(d) |    0   |    0   |<br>
| sin(d) | cos(d) |    0   |    0   |<br>
|    0   |    0   |    1   |    0   |<br>
|    0   |    0   |    0   |    1   |<br>
//matrix-<br>
<hr><br>
Die Anwendung der <b>Matrix-Bibliothek</b> ist sehr einfach, so das man nicht mal wissen muss, wie eine Matrix aufgebaut ist.<br>
<pre><code><b><font color="0000BB">var</font></b>
  Matrix : TMatrix;

<b><font color="0000BB">begin</font></b>
  Matrix.Indenty;                <i><font color="#FFFF00">// Matrix Indenty setzen.</font></i>

  Matrix.xxxx(...);              <i><font color="#FFFF00">// Modifikationen der Matrix.</font></i>
  Matrix.Uniform(ID_im_Shader);  <i><font color="#FFFF00">// Die Matrix dem Shader übergeben.</font></i></pre></code>
Ausser im ersten Beispiel werde ich nur noch diese <b>Bibliothek</b> verwenden. Somit werden die Beispiele sehr übersichtlich.<br>

</html>
