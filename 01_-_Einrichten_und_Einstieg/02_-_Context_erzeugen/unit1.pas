unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs,
  OpenGLContext,
  dglOpenGL;

//image image.png

(*
OpenGL Context 3.3 erzeugen und OpenGL initialisieren.
<b>Parent</b> kann z.B. auch ein TPanel sein. (Parent := Panel1;)

Man kann die <b>TOpenGLControl</b>-Komponente auch über die Komponenten-Leiste auf dem Form erzeugen.
Aber meine Erfahrung hat gezeigt, wenn man eine neuere Lazarus-Version installiert, dass es dann zu Problemen kommen kann.
*)

//lineal
(*
Den Zeichen-Context mit <b>TOpenGLControl</b> deklarieren.
*)
//code+
type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    ogc: TOpenGLControl;   // Deklaration von ogc
    procedure InitScene;
    procedure DrawScene(Sender: TObject);
  end;
//code-

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

(*
Den Zeichen-Context erzeugen.
*)
//code+
procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
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
//code-
(*
Für die Contexterzeugung, habe ich eine Klasse geschrieben, diese beinhaltet den Teil im <b>with</b>-Block, ausgenommen <b>OnPaint</b>.
In späteren Tutorial wird nur noch diese verwendet.
*)
//lineal

(*
Rendern der Szene, momentan wird nur die Hintergrundfarbe festgelegt.
Die Werte werden bei <b>glClearColor(...</b> als R, G, B, A eingegeben, wobei A keinen Einfluss hat.
0.0 ist dunkel und 1.0 ist volle Intensität, somit wäre 0.0, 0.0, 0.0 Schwarz und 1.0, 1.0, 1.0 Weiss.
Hier im Beispiel ist es ein Olivgrün.
*)

//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0);  // Hintergrundfarbe
end;
//code-

(*
Darstellen der Szene, momentan wird mit <b>glClear(...</b> nur der Frame-Puffer geleert und und mit der mit <b>glClearColor(...</b> festgelegten Farbe gefüllt.
Der noch leere Frame-Puffer wird mit <b>ogc.SwapBuffers;</b> auf dem Bildschirm dargestellt.
Somit ist nur der Hintergrund sichtbar und man sieht keine Änderung.
*)

//code+
procedure TForm1.DrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);  // Frame-Buffer löschen und einfärben.

  ogc.SwapBuffers;               // Frame-Buffer auf den Bildschirm kopieren.
end;
//code-

end.
