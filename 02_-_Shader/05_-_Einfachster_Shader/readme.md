# 02 - Shader
## 05 - Einfachster Shader

<img src="image.png" alt="Selfhtml"><br><br>
Hier wird ein sehr einfacher Shader geladen, welcher nichts anderes macht, als die Dreiecke rot darzustellen.
<hr><br>
Hier wird noch ein Objekt der Klasse TShader deklariert.

```pascal
type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
```

Dieser Code wurde um 2 Zeilen erweitert.

In der ersten Zeile wird der Shader in die Grafikkarte geladen.
Da die Shader-Objecte als Text-Dateien vorliegen, wird hier <b>FileToStr(Datei)</b> verwendet.
Die zweite Zeile aktiviert den Shader.

```pascal
procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
```

Beim Zeichnen muss man auch mit <b>Shader[x].UseProgram(...</b> den Shader wählen, wenn man mehr als einen Shader verwendet.
In der Shader-Klasse steht nichts anderes als<b>glUseProgram(ShaderID);</b> .
Bei diesem Mini-Code mit nur einem Shader könnte dies weggelassen werden.

```pascal
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;
```

Am Ende werden mit <b>Shader.Free</b> die Shader in der Grafikkarte wieder freigeben.
In diesem Destruktor steht <b>glDeleteShader(ShaderID);</b>

```pascal
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;
```

<hr><br>
Diese Kommentare, welche man hier im Shader sind, werden auch dem der Grafik-Teiber übergeben, aber dieser ingnoriert sie dann.
Wen man voll auf Perfornance beim laden ab ist, sollte man Kommentare im Shader-Code meiden.
Auch jede Leerzeile und jede Einrückung bremsen ein wenig ab.
Auf die später Zeichengeschwindigkeit hat dies aber keinen Einfluss.
Aber hier im Tutorial wird voll auf solche Optimierungen verzichtet, da wir übersichtlichen Shader-Code sehen wollen.
<hr><br>
<b>Vertex-Shader:</b>

```glsl
#version 330

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten
 
void main(void)
{
  gl_Position = vec4(inPos, 1.0);
}

```

<hr><br>
<b>Fragment-Shader</b>

```glsl
#version 330

out vec4 outColor;                     // ausgegebene Farbe

void main(void)
{
  outColor = vec4(1.0, 0.0, 0.0, 1.0); // Die Ausgabe ist immer Rot
}

```

<hr><br>
So könnte ein optimierter Shader-Code aussehen, dafür ist er aber sehr schlecht leserlich.
<b>Vertex-Shader:</b>

```glsl
#version 330
layout(location=10)in vec3 inPos;
void main(void){gl_Position=vec4(inPos, 1.0);}

```


