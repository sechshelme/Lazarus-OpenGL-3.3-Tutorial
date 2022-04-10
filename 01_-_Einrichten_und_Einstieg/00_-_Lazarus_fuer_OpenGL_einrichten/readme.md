<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>01 - Einrichten und Einstieg</h1></b>
    <b><h2>00 - Lazarus fuer OpenGL einrichten</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
<b>Vorwort:</b><br><br>
<b>OpenGL 3.3</b> scheint auf den ersten Blick viel komplizierter als das alte OpenGL.<br>
Man wird von Anfang an mit vielem Neuen konfrontiert.<br>
Früher konnte man einfach<br>
<pre><code>glBegin(...
..
glEnd</pre></code>
und fertig.<br>
Neu muss man sich mit Shadern und Vertex-Buffern auseinandersetzen.<br>
Auch muss man sich jetzt selbst um Matrizen und Beleuchtung kümmern.<br>
<br>
Aber dafür ist die Belohnung sehr gross, man ist sehr flexibel und man kann (fast) alles machen, was Effekte anbelangt.<br>
Früher war man einfach auf die Fixed-Function-Pipeline der Grafikkarte angewiesen und jede war etwas anders.<br>
Wenn eine Karte nur zwei Beleuchtungen hatte, dann hatte sie nur zwei.<br>
Da man es aber jetzt selbst macht, kann man fast beliebig viel machen, egal ob diffus, etc.<br>
<br>
Ich hoffe, mit diesem Tutorial wird der eine oder andere für OpenGL 3.3 begeistert werden.<br>
Wenn man diesen Einstieg mal geschafft hat, wird man auch mit höheren Versionen klarkommen.<br>
<br>
Auf der Hauptseite werde ich noch ein Package veröffentlichen, welches einem den Einstieg sehr einfach macht.<br>
Dort sind fertige Shader und Units für Matrizen, Texturen, Vertex-Puffer, etc. vorhanden.<br>
<hr><br>
<b>Voraussetzung:</b><br><br>
* FPC 3.0.2 oder höher.<br>
* Lazarus 1.6.4 oder höher.<br>
* Mindestens OpenGL 3.3 fähige Grafikkarte.<br>
* Grundkenntnisse mit FPC und Lazarus.<br>
* Grundkenntnisse C/C++ für die Shader-Programmierung.<br>
<br>
Wen die Grafikkarte zu alt ist, gibt es trotzdem eine Lösung. Mit Mesa ab 17.1 ist es möglich im Software-Renderer OpenGL zu emulieren.<br>
Dies ist gähnend langsam, aber für die ersten Gehversuche im Tutorial reicht dies. ( Getestet mit Linux Mint 64Bit 18.x )<br>
<br>
<b>Installation:</b><br><br>
FPC und Lazarus installieren.<br>
<br>
Bei Lazarus muss unter <i><b>"Package --> Installierte Packages einrichten... --> Verfügbar für Installation"</b></i>, zuerst das Package <i><b>LazOpenGLContext x.x.x</b></i> installiert werden.<br>
<br>
Das Tutorial sollte unter Linux und Windows laufen, auf dem Mac habe ich es nicht probiert.<br>
<br>
Wenn Lazarus bei der Neukompilierung unter Linux Probleme macht, könnte Folgendes das Problem sein.<br>
Unter auf Debian oder Ubuntu basierenden Linux-Distributionen muss evtl. noch Folgendes installiert werden.<br>
<pre><code>sudo apt-get install freeglut3-dev</pre></code>
Somit sollten alle Beispiele kompilierbar sein.<br>
<br>
Die Sourcen zum Tutorial, kann man alle auf der Hauptseite herunterladen.<br>
Es ist eine Zip, welche auch alle Bibliotheken (Units) enthält.<br>
Ich habe eine Package Namens <b>ogl_package.lpk</b> mit den benötigten Dateien erstellt, sie befindet sich im gleiche Ordner wie die <b>Units</b>.  Ich empfehle es, die Package zu installieren,<br>
obwohl man auch in den Projekte den Unit-Pfad anpassen kann, nur muss man dann in allen Projekten die Pfade anpassen, wen man mal die Package verschiebt/umbenennt.<br>
Für die ogl-Package ist noch Package BRGABitmap erforderlich, diese lässt sich bequem über <i><b>"Package --> Online-Package-Manger --> BGRABitmap"</b></i> installieren.<br>
<br>
Die wichtigsten Funktionen der ogl-Package:<br>
* <b>dglOpenGL</b>: Der Header für die OpenGL-Funktionen.<br>
* <b>oglContex</b>: Erzeugt einen Zeichencontext, ohne diesem ist keine OpenGL-Ausgabe möglich.<br>
* <b>oglShader</b>: Enthält Funktionen um den Shader-Code in die Grafikkarte zu laden.<br>
* <b>oglVertex</b>: Verschiedene Vertex-Deklarationen und Funktionen/Berechnungen.<br>
* <b>oglMatrix</b>: Verschiedene Matrix-Deklarationen und Funktionen/Berechnungen.<br>
* <b>oglTextur</b>: Funktionen für das Hochladen von Texturen.<br>
<br>
<br>
Es sind viele OpenGL spezifische Sachen ausserhalb von Form deklariert, bei einer sauberen objektorientierten Programmierung ist dies nicht üblich.<br>
Hier wurde es einfachheitshalber der Übersichtlichkeit gemacht.<br>
<br>
Wen man weis, wie man mit <b>Delphi</b> einen OpenGL-Context erzeugt, sollte dieses Tutorial auch mit Delphi funktionieren.<br>
<br>
Wenn Fehler gefunden werden, dann bitte hier melden:<br>
<a href="https://delphigl.com/forum/viewtopic.php?f=14&t=11566 ">DGL-Forum</a>
oder<br>
<a href="http://www.lazarusforum.de/viewtopic.php?f=29&t=11373&hilit=opengl+tutorial ">Lazarus-Forum</a>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
