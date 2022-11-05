# 02 - Shader
## 00 - Einleitung und laden der Shader

![image.png](image.png)

In **OpenGL 3.3** gibt es drei verschiedene **Shadertypen**, den **Vertex-**, **Geometry-** und **Fragment-Shader**.
Wobei der **Vertex-Shader immer** vorhanden sein muss. Der **Fragment-Shader** wird benötigt, wenn die Ausgabe des Rendervorgangs ein Bild sein soll, also fast immer.
Der **Geometry-Shader** ist optional.
In OpenGL 4.0 wurden noch zwei **Tessellations-Shader** eingeführt, aber dies gehört eigentlich nicht hier hin.

Die Shader werden mit der Programmiersprache **OpenGL Shading Language (GLSL)** programmiert. Die ist eine C/C++ ähnliche Sprache.
Daher muss auf **Gross- und Kleinschreibung** geachtet werden.

Somit sind auch Kommentare wie in C/C++ möglich.

```// Ich bin ein Kommentar
/* Ich bin ein Kommentar */
```


Der kompilierte Code von GLSL läufen direkt in der Grafikkarte (GPU).

---
Damit das Laden der Shader einfacher ist, habe ich im Unit-Verzeichnis eine Unit **Shader.pas** erstellt, welche eine Klasse für den Shader enthält.
Somit ist der Ablauf sehr einfach.
Der Konstructor verlangt die Shader-Objecte als String. Wen die Shader-Object als Dateien vorliegen, habe ich eine Hilfs-Funktion in de Shader Unit.
Dies ist **FileToStr(...** . Im Tutorial wird immer diese verwendet.

```pascal
var
  Shader : TShader;

begin
  Shader := TShader.Create(Vertex_Shader, Fragment_Shader);  // Shader laden

  Shader.UseProgram;  // Aktiviert den Shader

  Shader.Free         // Gibt den Shader frei
```

In folgenden Beispielen werden die Shader nur noch mit dieser Klasse geladen, damit es übersichtlicher wird.
Wie man es nativ machen kann, wird im **Einstiegs-Tutorial** unter **erster Shader** gezeigt.

