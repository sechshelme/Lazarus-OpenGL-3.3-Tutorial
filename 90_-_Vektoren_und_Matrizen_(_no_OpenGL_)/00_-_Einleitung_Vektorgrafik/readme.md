# 90 - Vektoren und Matrizen ( no OpenGL )
## 00 - Einleitung Vektorgrafik

<img src="image.png" alt="Selfhtml"><br><br>
Die folgeden Beispiele sollten zeigen, was OpenGL einem im Hintergrund für Arbeit abnimmt.

Vor allem bei dem Beispiel mit der Caube-Array sieht man, das einem die GPU sehr viel Arbeit abnimmt.
Die Ausgabe wird schon bei der kleinsten vergrösserung zur Dia-Show, obwohl zum Teil die SSE-Beschleunigung der CPU verwendet wurde.
Man sieht gut, was es alles braucht, wen man ein Dreieck mit Gradientverlauf ausgeben will.
Oder für eine Textur auf einer Fläche.

Da die Berechnung für die Vektoren und Matrizen gleich ist wie bei OpenGL 3.3, habe ich dafür die gleichen Bibliotheken verwendet.

