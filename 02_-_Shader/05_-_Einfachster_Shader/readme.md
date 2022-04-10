<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
    <b><h1>02 - Shader</h1></b>
    <b><h2>05 - Einfachster Shader</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
Hier wird ein sehr einfacher Shader geladen, welcher nichts anderes macht, als die Dreiecke rot darzustellen.<br>
<hr><br>
Hier wird noch ein Objekt der Klasse TShader deklariert.<br>
<pre><code>type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object</pre></code>
Dieser Code wurde um 2 Zeilen erweitert.<br>
<br>
In der ersten Zeile wird der Shader in die Grafikkarte geladen.<br>
Da die Shader-Objecte als Text-Dateien vorliegen, wird hier <b>FileToStr(Datei)</b> verwendet.<br>
Die zweite Zeile aktiviert den Shader.<br>
<pre><code>procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);</font>
  Shader.UseProgram;</pre></code>
Beim Zeichnen muss man auch mit <b>Shader[x].UseProgram(...</b> den Shader wählen, wenn man mehr als einen Shader verwendet.<br>
In der Shader-Klasse steht nichts anderes als<b>glUseProgram(ShaderID);</b> .<br>
Bei diesem Mini-Code mit nur einem Shader könnte dies weggelassen werden.<br>
<pre><code>procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;</pre></code>
Am Ende werden mit <b>Shader.Free</b> die Shader in der Grafikkarte wieder freigeben.<br>
In diesem Destruktor steht <b>glDeleteShader(ShaderID);</b><br>
<pre><code>procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;</pre></code>
<hr><br>
Diese Kommentare, welche man hier im Shader sind, werden auch dem der Grafik-Teiber übergeben, aber dieser ingnoriert sie dann.<br>
Wen man voll auf Perfornance beim laden ab ist, sollte man Kommentare im Shader-Code meiden.<br>
Auch jede Leerzeile und jede Einrückung bremsen ein wenig ab.<br>
Auf die später Zeichengeschwindigkeit hat dies aber keinen Einfluss.<br>
Aber hier im Tutorial wird voll auf solche Optimierungen verzichtet, da wir übersichtlichen Shader-Code sehen wollen.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>

layout (location = 10) in vec3 inPos; // Vertex-Koordinaten</font>
 
void main(void)
{
  gl_Position = vec4(inPos, 1.0);</font>
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code>#version 330</font>

out vec4 outColor;                     // ausgegebene Farbe

void main(void)
{
  outColor = vec4(1.0, 0.0, 0.0, 1.0); // Die Ausgabe ist immer Rot</font>
}
</pre></code>
<hr><br>
So könnte ein optimierter Shader-Code aussehen, dafür ist er aber sehr schlecht leserlich.<br>
<b>Vertex-Shader:</b><br>
<pre><code>#version 330</font>
layout(location=10)in vec3 inPos;</font>
void main(void){gl_Position=vec4(inPos, 1.0);}</font>
</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
