# 01 - Einrichten und Einstieg
## 05 - Context erzeugen

![image.png](image.png)

OpenGL Context 3.3 erzeugen und OpenGL initialisieren.
**Parent** kann z.B. auch ein TPanel sein. (Parent := Panel1;)

Man kann die **TOpenGLControl**-Komponente auch über die Komponenten-Leiste auf dem Form erzeugen.
Aber meine Erfahrung hat gezeigt, wenn man eine neuere Lazarus-Version installiert, dass es dann zu Problemen kommen kann.

---
Den Zeichen-Context mit **TOpenGLControl** deklarieren.

```pascal
type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    ogc: TOpenGLControl;   // Deklaration von ogc
    procedure InitScene;
    procedure DrawScene(Sender: TObject);
  end;
```

Den Zeichen-Context erzeugen.

```pascal
procedure TForm1.FormCreate(Sender: TObject);
begin
  ogc := TOpenGLControl.Create(Self); // Den Zeichen-Context erzeugen.
  with ogc do begin
    Parent := Self;
    Align := alClient;
    OpenGLMajorVersion := 3;          // Dies ist wichtig, dass der Context 3.3 verwendet wird.
    OpenGLMinorVersion := 3;
    OnPaint := @DrawScene;
    InitOpenGL;
    MakeCurrent;
    ReadExtensions;
    ReadImplementationProperties;
  end;
  InitScene;                          // Rendert die Szene
end;
```

Für die Contexterzeugung, habe ich eine Klasse geschrieben, diese beinhaltet den Teil im **with**-Block, ausgenommen **OnPaint**.
In späteren Tutorial wird nur noch diese verwendet.

---
Rendern der Szene, momentan wird nur die Hintergrundfarbe festgelegt.
Die Werte werden bei **glClearColor(...** als R, G, B, A eingegeben, wobei A keinen Einfluss hat.
0.0 ist dunkel und 1.0 ist volle Intensität, somit wäre 0.0, 0.0, 0.0 Schwarz und 1.0, 1.0, 1.0 Weiss.
Hier im Beispiel ist es ein Olivgrün.

```pascal
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);  // Hintergrundfarbe
end;
```

Darstellen der Szene, momentan wird mit **glClear(...** nur der Frame-Puffer geleert und und mit der mit **glClearColor(...** festgelegten Farbe gefüllt.
Der noch leere Frame-Puffer wird mit **ogc.SwapBuffers;** auf dem Bildschirm dargestellt.
Somit ist nur der Hintergrund sichtbar und man sieht keine Änderung.

```pascal
procedure TForm1.DrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);  // Frame-Buffer löschen und einfärben.

  ogc.SwapBuffers;               // Frame-Buffer auf den Bildschirm kopieren.
end;
```


