<!DOCTYPE html>
<html>
  <body bgcolor="#DDDDFF">
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
<pre><code>type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    ogc: TOpenGLControl;   // Deklaration von ogc
    procedure InitScene;
    procedure DrawScene(Sender: TObject);
  end;</pre></code>
Den Zeichen-Context erzeugen.<br>
<pre><code>procedure TForm1.FormCreate(Sender: TObject);
begin
  ogc := TOpenGLControl.Create(Self); // Den Zeichen-Context erzeugen.
  with ogc do begin
    Parent := Self;
    Align := alClient;
    OpenGLMajorVersion := 3;          // Dies ist wichtig, dass der Context 3.3 verwendet wird.</font>
    OpenGLMinorVersion := 3;</font>
    OnPaint := @DrawScene;
    InitOpenGL;
    MakeCurrent;
    ReadExtensions;
    ReadImplementationProperties;
  end;
  InitScene;                          // Rendert die Szene
end;</pre></code>
Für die Contexterzeugung, habe ich eine Klasse geschrieben, diese beinhaltet den Teil im <b>with</b>-Block, ausgenommen <b>OnPaint</b>.<br>
In späteren Tutorial wird nur noch diese verwendet.<br>
<hr><br>
Rendern der Szene, momentan wird nur die Hintergrundfarbe festgelegt.<br>
Die Werte werden bei <b>glClearColor(...</b> als R, G, B, A eingegeben, wobei A keinen Einfluss hat.<br>
0.0 ist dunkel und 1.0 ist volle Intensität, somit wäre 0.0, 0.0, 0.0 Schwarz und 1.0, 1.0, 1.0 Weiss.<br>
Hier im Beispiel ist es ein Olivgrün.<br>
<pre><code>procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);  // Hintergrundfarbe</font>
end;</pre></code>
Darstellen der Szene, momentan wird mit <b>glClear(...</b> nur der Frame-Puffer geleert und und mit der mit <b>glClearColor(...</b> festgelegten Farbe gefüllt.<br>
Der noch leere Frame-Puffer wird mit <b>ogc.SwapBuffers;</b> auf dem Bildschirm dargestellt.<br>
Somit ist nur der Hintergrund sichtbar und man sieht keine Änderung.<br>
<pre><code>procedure TForm1.DrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);  // Frame-Buffer löschen und einfärben.

  ogc.SwapBuffers;               // Frame-Buffer auf den Bildschirm kopieren.
end;</pre></code>

    <br><br><br>
<h2><a href="../../index.html">zurück</a></h2>
  </body>
</html>
