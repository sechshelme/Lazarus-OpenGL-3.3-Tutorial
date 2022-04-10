<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>00 - Einleitung und laden der Shader</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
In <b>OpenGL 3.3</b> gibt es drei verschiedene <b>Shadertypen</b>, den <b>Vertex-</b>, <b>Geometry-</b> und <b>Fragment-Shader</b>.<br>
Wobei der <b>Vertex-Shader immer</b> vorhanden sein muss. Der <b>Fragment-Shader</b> wird benötigt, wenn die Ausgabe des Rendervorgangs ein Bild sein soll, also fast immer.<br>
Der <b>Geometry-Shader</b> ist optional.<br>
In OpenGL 4.0 wurden noch zwei <b>Tessellations-Shader</b> eingeführt, aber dies gehört eigentlich nicht hier hin.<br>
<br>
Die Shader werden mit der Programmiersprache <b>OpenGL Shading Language (GLSL)</b> programmiert. Die ist eine C/C++ ähnliche Sprache.<br>
Daher muss auf <b>Gross- und Kleinschreibung</b> geachtet werden.<br>
<br>
Somit sind auch Kommentare wie in C/C++ möglich.<br>
<pre><code>// Ich bin ein Kommentar
/* Ich bin ein Kommentar */</pre></code>
<br>
Der kompilierte Code von GLSL läufen direkt in der Grafikkarte (GPU).<br>
<hr><br>
Damit das Laden der Shader einfacher ist, habe ich im Unit-Verzeichnis eine Unit <b>Shader.pas</b> erstellt, welche eine Klasse für den Shader enthält.<br>
Somit ist der Ablauf sehr einfach.<br>
Der Konstructor verlangt die Shader-Objecte als String. Wen die Shader-Object als Dateien vorliegen, habe ich eine Hilfs-Funktion in de Shader Unit.<br>
Dies ist <b>FileToStr(...</b> . Im Tutorial wird immer diese verwendet.<br>
<pre><code><b><font color="0000BB">var</font></b>
  Shader : TShader;

<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create(Vertex_Shader, Fragment_Shader);  <i><font color="#FFFF00">// Shader laden</font></i>

  Shader.UseProgram;  <i><font color="#FFFF00">// Aktiviert den Shader</font></i>

  Shader.Free         <i><font color="#FFFF00">// Gibt den Shader frei</font></i></pre></code>
In folgenden Beispielen werden die Shader nur noch mit dieser Klasse geladen, damit es übersichtlicher wird.<br>
Wie man es nativ machen kann, wird im <b>Einstiegs-Tutorial</b> unter <b>erster Shader</b> gezeigt.<br>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
