<html>
    <b><h1>01 - Einrichten und Einstieg</h1></b>
    <b><h2>05 - Context erzeugen</h2></b>
<img src="image.png" alt="Selfhtml"><br><br>
OpenGL Context 3.3 erzeugen und OpenGL initialisieren.<br>
<b>Parent</b> kann z.B. auch ein TPanel sein. (Parent := Panel1;)<br>
<br>
Man kann die <b>TOpenGLControl</b>-Komponente auch über die Komponenten-Leiste auf dem Form erzeugen.<br>
Aber meine Erfahrung hat gezeigt, wenn man eine neuere Lazarus-Version installiert, dass es dann zu Problemen kommen kann.<br>
<hr><br>
Den Zeichen-Context mit <b>TOpenGLControl</b> deklarieren.<br>
<pre><code=pascal><b><font color="0000BB">type</font></b>
  TForm1 = <b><font color="0000BB">class</font></b>(TForm)
    <b><font color="0000BB">procedure</font></b> FormCreate(Sender: TObject);
  <b><font color="0000BB">private</font></b>
    ogc: TOpenGLControl;   <i><font color="#FFFF00">// Deklaration von ogc</font></i>
    <b><font color="0000BB">procedure</font></b> InitScene;
    <b><font color="0000BB">procedure</font></b> DrawScene(Sender: TObject);
  <b><font color="0000BB">end</font></b>;</code></pre>
Den Zeichen-Context erzeugen.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.FormCreate(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  ogc := TOpenGLControl.Create(<b><font color="0000BB">Self</font></b>); <i><font color="#FFFF00">// Den Zeichen-Context erzeugen.</font></i>
  <b><font color="0000BB">with</font></b> ogc <b><font color="0000BB">do</font></b> <b><font color="0000BB">begin</font></b>
    Parent := <b><font color="0000BB">Self</font></b>;
    Align := alClient;
    OpenGLMajorVersion := <font color="#0077BB">3</font>;          <i><font color="#FFFF00">// Dies ist wichtig, dass der Context 3.3 verwendet wird.</font></i>
    OpenGLMinorVersion := <font color="#0077BB">3</font>;
    OnPaint := @DrawScene;
    InitOpenGL;
    MakeCurrent;
    ReadExtensions;
    ReadImplementationProperties;
  <b><font color="0000BB">end</font></b>;
  InitScene;                          <i><font color="#FFFF00">// Rendert die Szene</font></i>
<b><font color="0000BB">end</font></b>;</code></pre>
Für die Contexterzeugung, habe ich eine Klasse geschrieben, diese beinhaltet den Teil im <b>with</b>-Block, ausgenommen <b>OnPaint</b>.<br>
In späteren Tutorial wird nur noch diese verwendet.<br>
<hr><br>
Rendern der Szene, momentan wird nur die Hintergrundfarbe festgelegt.<br>
Die Werte werden bei <b>glClearColor(...</b> als R, G, B, A eingegeben, wobei A keinen Einfluss hat.<br>
0.0 ist dunkel und 1.0 ist volle Intensität, somit wäre 0.0, 0.0, 0.0 Schwarz und 1.0, 1.0, 1.0 Weiss.<br>
Hier im Beispiel ist es ein Olivgrün.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.InitScene;
<b><font color="0000BB">begin</font></b>
  glClearColor(<font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">6</font>, <font color="#0077BB">0</font>.<font color="#0077BB">4</font>, <font color="#0077BB">1</font>.<font color="#0077BB">0</font>);  <i><font color="#FFFF00">// Hintergrundfarbe</font></i>
<b><font color="0000BB">end</font></b>;</code></pre>
Darstellen der Szene, momentan wird mit <b>glClear(...</b> nur der Frame-Puffer geleert und und mit der mit <b>glClearColor(...</b> festgelegten Farbe gefüllt.<br>
Der noch leere Frame-Puffer wird mit <b>ogc.SwapBuffers;</b> auf dem Bildschirm dargestellt.<br>
Somit ist nur der Hintergrund sichtbar und man sieht keine Änderung.<br>
<pre><code=pascal><b><font color="0000BB">procedure</font></b> TForm1.DrawScene(Sender: TObject);
<b><font color="0000BB">begin</font></b>
  glClear(GL_COLOR_BUFFER_BIT);  <i><font color="#FFFF00">// Frame-Buffer löschen und einfärben.</font></i>
<br>
  ogc.SwapBuffers;               <i><font color="#FFFF00">// Frame-Buffer auf den Bildschirm kopieren.</font></i>
<b><font color="0000BB">end</font></b>;</code></pre>
<br>
</html>
