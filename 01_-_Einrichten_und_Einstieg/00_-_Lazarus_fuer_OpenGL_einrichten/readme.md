# 01 - Einrichten und Einstieg
## 00 - Lazarus fuer OpenGL einrichten

![image.png](image.png)

**Vorwort:**<br>
**OpenGL 3.3** scheint auf den ersten Blick viel komplizierter als das alte OpenGL.
Man wird von Anfang an mit vielem Neuen konfrontiert.
Früher konnte man einfach

```pascal
glBegin(...
..
glEnd
```

und fertig.
Neu muss man sich mit Shadern und Vertex-Buffern auseinandersetzen.
Auch muss man sich jetzt selbst um Matrizen und Beleuchtung kümmern.

Aber dafür ist die Belohnung sehr gross, man ist sehr flexibel und man kann (fast) alles machen, was Effekte anbelangt.
Früher war man einfach auf die Fixed-Function-Pipeline der Grafikkarte angewiesen und jede war etwas anders.
Wenn eine Karte nur zwei Beleuchtungen hatte, dann hatte sie nur zwei.
Da man es aber jetzt selbst macht, kann man fast beliebig viel machen, egal ob diffus, etc.

Ich hoffe, mit diesem Tutorial wird der eine oder andere für OpenGL 3.3 begeistert werden.
Wenn man diesen Einstieg mal geschafft hat, wird man auch mit höheren Versionen klarkommen.

Auf der Hauptseite werde ich noch ein Package veröffentlichen, welches einem den Einstieg sehr einfach macht.
Dort sind fertige Shader und Units für Matrizen, Texturen, Vertex-Puffer, etc. vorhanden.

---
**Voraussetzung:**<br>
* FPC **3.3.0** oder höher. 
* Lazarus **3.4** oder höher.
* Mindestens OpenGL 3.3 fähige Grafikkarte.
* Grundkenntnisse mit FPC und Lazarus.
* Grundkenntnisse C/C++ für die Shader-Programmierung.

Wen die Grafikkarte zu alt ist, gibt es trotzdem eine Lösung. Mit Mesa ab 17.1 ist es möglich im Software-Renderer OpenGL zu emulieren.
Dies ist gähnend langsam, aber für die ersten Gehversuche im Tutorial reicht dies. ( Getestet mit Linux Mint 64Bit 18.x )

**Installation:**<br>
FPC und Lazarus installieren.

Bei Lazarus muss unter <i>**"Package --> Installierte Packages einrichten... --> Verfügbar für Installation"**</i>, zuerst das Package <i>**LazOpenGLContext x.x.x**</i> installiert werden.

Das Tutorial sollte unter Linux und Windows laufen, auf dem Mac habe ich es nicht probiert.

Wenn Lazarus bei der Neukompilierung unter Linux Probleme macht, könnte Folgendes das Problem sein.
Unter auf Debian oder Ubuntu basierenden Linux-Distributionen muss evtl. noch Folgendes installiert werden.

```pascal
sudo apt-get install freeglut3-dev
```

Somit sollten alle Beispiele kompilierbar sein.

Die Sourcen zum Tutorial, kann man alle auf der Hauptseite herunterladen.
Es ist eine Zip, welche auch alle Bibliotheken (Units) enthält.
Ich habe eine Package Namens **ogl_package.lpk** mit den benötigten Dateien erstellt, sie befindet sich im gleiche Ordner wie die **Units**.  Ich empfehle es, die Package zu installieren,
obwohl man auch in den Projekte den Unit-Pfad anpassen kann, nur muss man dann in allen Projekten die Pfade anpassen, wen man mal die Package verschiebt/umbenennt.
Für die ogl-Package ist noch Package BRGABitmap erforderlich, diese lässt sich bequem über <i>**"Package --> Online-Package-Manger --> BGRABitmap"**</i> installieren.

Die wichtigsten Funktionen der ogl-Package:
* **dglOpenGL**: Der Header für die OpenGL-Funktionen.
* **oglContex**: Erzeugt einen Zeichencontext, ohne diesem ist keine OpenGL-Ausgabe möglich.
* **oglShader**: Enthält Funktionen um den Shader-Code in die Grafikkarte zu laden.
* **oglVertex**: Verschiedene Vertex-Deklarationen und Funktionen/Berechnungen.
* **oglMatrix**: Verschiedene Matrix-Deklarationen und Funktionen/Berechnungen.
* **oglTextur**: Funktionen für das Hochladen von Texturen.


Es sind viele OpenGL spezifische Sachen ausserhalb von Form deklariert, bei einer sauberen objektorientierten Programmierung ist dies nicht üblich.
Hier wurde es einfachheitshalber der Übersichtlichkeit gemacht.

Wen man weis, wie man mit **Delphi** einen OpenGL-Context erzeugt, sollte dieses Tutorial auch mit Delphi funktionieren.

Wenn Fehler gefunden werden, dann bitte hier melden:
<a href="https://delphigl.com/forum/viewtopic.php?f=14&t=11566 ">DGL-Forum</a>
oder
<a href="http://www.lazarusforum.de/viewtopic.php?f=29&t=11373&hilit=opengl+tutorial ">Lazarus-Forum</a>

