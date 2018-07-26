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

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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
  square_vertices: array[0..1] of TFace3D =
    (((-0.8, -0.8, 0.0), (-0.8, 0.8, 0.0), (0.8, 0.8, 0.0)),
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));

//  instance_colors: array[0..3] of TVector4f =
//    ((1.0, 0.0, 0.0, 1.0), (0.0, 1.0, 0.0, 1.0), (0.0, 0.0, 1.0, 1.0), (1.0, 1.0, 0.0, 1.0));
//code-

(*
Für die Farbe ist ein zusätzliches <b>Vertex Buffer Object</b> (VBO) hinzugekommen.
*)
//code+
type
  TVB = record
    VAO,
    VBOPos, VBOiMatrix, VBOiC: GLuint;
  end;
//code-

const
  Sektoren = 117;

var
  VBTriangle: TVB;

  Matrix: array[0..Sektoren - 1] of TMatrix;
  instance_colors: array[0..Sektoren - 1] of TVector3f;

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
  Timer1.Enabled := True;
end;

(*
CreateScene wurde um zwei Zeilen erweitert.
Die VB0 für den Farben-Puffer müssen noch generiert werden.
*)

procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenBuffers(1, @VBTriangle.VBOPos);
  glGenBuffers(1, @VBTriangle.VBOiMatrix);
  glGenBuffers(1, @VBTriangle.VBOiC);
end;

(*
Hier fast der wichtigste Teil, pro <b>Vertex Array Object</b> (VAO) wird ein zweiter Puffer in das VRAM geladen.
Die 10 und 11, muss indentisch sein, mit dem <b>location</b> im Shader.
*)
//code+
procedure TForm1.InitScene;
var
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOPos);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(square_vertices), @square_vertices, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Instance Color
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOiC);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(instance_colors), nil, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);
  glVertexAttribDivisor(1, 1);

  // Instance Matrix
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOiMatrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(TMatrix) * Length(Matrix), nil, GL_STATIC_DRAW);
  for i := 0 to 3 do begin
    glEnableVertexAttribArray(i + 2);
    //  glVertexAttribPointer(2, 16, GL_FLOAT, False, 0, nil);
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, False, SizeOf(TMatrix), Pointer(i * 16));
    glVertexAttribDivisor(i + 2, 1);
  end;
end;
//code-

(*
Jetzt kommt wieder ein grosser Vorteil von OpenGL 3.3, das Zeichnen geht gleich einfach wie wen man nur ein VBO hat.
*)
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  glBindVertexArray(VBTriangle.VAO);
  glDrawArraysInstanced(GL_TRIANGLE_FAN, 0, Length(square_vertices) * 3, Sektoren);

  ogc.SwapBuffers;
end;

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
  glDeleteBuffers(1, @VBTriangle.VBOiC);
  glDeleteBuffers(1, @VBTriangle.VBOiMatrix);
  //code-
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  r: GLfloat = 0.0;
var
  i: integer;
begin
  r += 0.01;
  if r > 2 * pi then begin
    r -= 2 * pi;
  end;

  for i := 0 to Sektoren - 1 do begin
    Matrix[i].Identity;
    Matrix[i].Scale(0.25, 0.01, 1.0);
    Matrix[i].RotateC(Pi * 2 / Sektoren * i + r);
    Matrix[i].TranslateLocalspace(2.0, 0.0, 0.0);

    instance_colors[i] := vec3(1 / Sektoren * i, 0.5, 1 - 1 / Sektoren * i);
  end;

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOiMatrix);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(TMatrix) * Length(Matrix), @Matrix);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBOiC);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(instance_colors), @instance_colors, GL_STATIC_DRAW);

  ogc.Invalidate;
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
