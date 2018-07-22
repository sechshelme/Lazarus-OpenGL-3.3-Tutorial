unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  dglOpenGL,
  oglVector, oglMatrix,
  oglContext, oglShader;

//image image.png
(*
Bis jetzt wurde immer nur ein Vertex-Puffer pro Mesh geladen, hier wird ein zweiter geladen, welcher die Farben der Vektoren enthält.
Somit werden die Mesh mehrfarbig.
*)

//lineal

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

(*
Es sind zwei zusätzliche Vertex-Konstanten dazu gekommen, welche die Farben der Ecken enthält.
*)
//code+
const
  square_vertices: array[0..5] of TVector2f =
    ((-0.8, -0.8), (-0.8, 0.8), (0.8, 0.8),
    (-0.8, -0.8), (0.8, -0.8), (0.8, 0.8));

  Instance_Col: array[0..3] of TVector3f =
    ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0));
  Instance_Pos: array[0..3] of TVector2f =
    ((-2.0, -2.0), (2.0, -2.0), (2.0, 2.0), (-2.0, 2.0));
//code-

(*
Für die Farbe ist ein zusätzliches <b>Vertex Buffer Object</b> (VBO) hinzugekommen.
*)
//code+
type
  TVB = record
    VAO,
    VBOPos, VBOInstancePos, VBOInstanceColor: GLuint;
  end;
//code-

var
  VBTriangle: TVB;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
end;

(*
CreateScene wurde um zwei Zeilen erweitert.
Die VB0 für den Farben-Puffer müssen noch generiert werden.
*)

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenBuffers(1, @VBTriangle.VBOPos);
  glGenBuffers(1, @VBTriangle.VBOInstancePos);
  glGenBuffers(1, @VBTriangle.VBOInstanceColor);
end;

(*
Hier fast der wichtigste Teil, pro <b>Vertex Array Object</b> (VAO) wird ein zweiter Puffer in das VRAM geladen.
Die 10 und 11, muss indentisch sein, mit dem <b>location</b> im Shader.
*)
//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOPos);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(square_vertices), @square_vertices, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // --- Instanzen ---
  // Color
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOInstanceColor);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Instance_Col), @Instance_Col, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(1, 1);

  // Position
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOInstancePos);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Instance_Pos), @Instance_Pos, GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 2, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(2, 1);
end;
//code-

(*
Jetzt kommt wieder ein grosser Vorteil von OpenGL 3.3, das Zeichnen geht gleich einfach wie wen man nur ein VBO hat.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  glBindVertexArray(VBTriangle.VAO);
  glDrawArraysInstanced(GL_TRIANGLE_FAN, 0, Length(square_vertices) * 3, 4);

  ogc.SwapBuffers;
end;
//code-

(*
Am Ende müssen noch die zusätzlichen VBO-Puffer frei gegeben werden.
Freigaben müssen immer gleich viele sein wie Erzeugungen.
*)

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);

  //code+
  glDeleteBuffers(1, @VBTriangle.VBOPos);
  glDeleteBuffers(1, @VBTriangle.VBOInstanceColor);
  glDeleteBuffers(1, @VBTriangle.VBOInstancePos);
  //code-
end;

//lineal

(*
<b>Vertex-Shader:</b>

Hier ist eine zweite Location hinzugekommen, wichtig ist, das die Location-Nummer übereinstimmt, mit denen beim Vertex-Laden.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.


