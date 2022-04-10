<img src="image.png" alt="Selfhtml"><br><br>
Hier wird ein sehr einfacher Shader geladen, welcher nichts anderes macht, als die Dreiecke rot darzustellen.<br>
<hr><br>
Hier wird noch ein Objekt der Klasse TShader deklariert.<br>
<pre><code><b><font color="0000BB">type</font></b>

  <font color="#FFFF00">{ TForm1 }</font>

  TForm1 = <b><font color="0000BB">class</font></b>(TForm)
    <b><font color="0000BB">procedure</font></b> FormCreate(Sender: TObject);
    <b><font color="0000BB">procedure</font></b> FormDestroy(Sender: TObject);
  <b><font color="0000BB">private</font></b>
    ogc: TContext;
    Shader: TShader; <i><font color="#FFFF00">// Shader-Object</font></i></pre></code>
Dieser Code wurde um 2 Zeilen erweitert.<br>
<br>
In der ersten Zeile wird der Shader in die Grafikkarte geladen.<br>
Da die Shader-Objecte als Text-Dateien vorliegen, wird hier <b>FileToStr(Datei)</b> verwendet.<br>
Die zweite Zeile aktiviert den Shader.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.CreateScene;
<b><font color="0000BB">begin</font></b>
  Shader := TShader.Create([FileToStr(<font color="#FF0000">'Vertexshader.glsl'</font>), FileToStr(<font color="#FF0000">'Fragmentshader.glsl'</font>)]);
  Shader.UseProgram;</pre></code>
Beim Zeichnen muss man auch mit <b>Shader[x].UseProgram(...</b> den Shader wählen, wenn man mehr als einen Shader verwendet.<br>
In der Shader-Klasse steht nichts anderes als<b>glUseProgram(ShaderID);</b> .<br>
Bei diesem Mini-Code mit nur einem Shader könnte dies weggelassen werden.<br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.ogcDrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;</pre></code>
Am Ende werden mit <b>Shader.Free</b> die Shader in der Grafikkarte wieder freigeben.<br>
In diesem Destruktor steht <b>glDeleteShader(ShaderID);</b><br>
<pre><code><b><font color="0000BB">procedure</font></b> TForm1.FormDestroy(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  Shader.Free;</pre></code>
<hr><br>
Diese Kommentare, welche man hier im Shader sind, werden auch dem der Grafik-Teiber übergeben, aber dieser ingnoriert sie dann.<br>
Wen man voll auf Perfornance beim laden ab ist, sollte man Kommentare im Shader-Code meiden.<br>
Auch jede Leerzeile und jede Einrückung bremsen ein wenig ab.<br>
Auf die später Zeichengeschwindigkeit hat dies aber keinen Einfluss.<br>
Aber hier im Tutorial wird voll auf solche Optimierungen verzichtet, da wir übersichtlichen Shader-Code sehen wollen.<br>
<hr><br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">layout</font></b> (location = <font color="#0077BB">10</font>) <b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos; <i><font color="#FFFF00">// Vertex-Koordinaten</font></i>
 
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  gl_Position = <b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);
}
</pre></code>
<hr><br>
<b>Fragment-Shader</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>

<b><font color="0000BB">out</font></b> <b><font color="0000BB">vec4</font></b> outColor;                     <i><font color="#FFFF00">// ausgegebene Farbe</font></i>

<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>)
{
  outColor = <b><font color="0000BB">vec4</font></b>(<font color="#0077BB">1</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">0</font>.<font color="#0077BB">0</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>); <i><font color="#FFFF00">// Die Ausgabe ist immer Rot</font></i>
}
</pre></code>
<hr><br>
So könnte ein optimierter Shader-Code aussehen, dafür ist er aber sehr schlecht leserlich.<br>
<b>Vertex-Shader:</b><br>
<pre><code><b><font color="#008800">#version</font></b> <font color="#0077BB">330</font>
<b><font color="0000BB">layout</font></b>(location=<font color="#0077BB">10</font>)<b><font color="0000BB">in</font></b> <b><font color="0000BB">vec3</font></b> inPos;
<b><font color="0000BB">void</font></b> main(<b><font color="0000BB">void</font></b>){gl_Position=<b><font color="0000BB">vec4</font></b>(inPos, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);}
</pre></code>

