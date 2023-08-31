unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglVector, oglMatrix, oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateVertex;
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png

(*
Man kann auch Punkte mit dem Shader darstellen, dies kann man auf verschiedene Weise.
Im Fragment-Shader kann man das Zeichen der Punkte manipulieren.
*)

//lineal

(*
Die Deklaration der Koordianten und Punktgrösse.
*)
//code+

type
  TPoint = record
    vec: TVector2f;
    col: TVector3f;
    PointSize: GLfloat;
  end;

var
  Points: array of TPoint;
  //code-

type
  TVB = record
    VAO,
    VBO, VBO_Size: GLuint;
  end;

var
  X_ID, Y_ID,
  PointTyp_ID,
  Color_ID: GLint;

  VBPoint: TVB;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Randomize;
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateVertex;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');
  X_ID := Shader.UniformLocation('x');
  Y_ID := Shader.UniformLocation('y');
  PointTyp_ID := Shader.UniformLocation('PointTyp');

  glGenVertexArrays(1, @VBPoint.VAO);
  glGenBuffers(1, @VBPoint.VBO);
  glGenBuffers(1, @VBPoint.VBO_Size);
end;

procedure TForm1.CreateVertex;
const
  r = 0.3;
  sek = 22;
var
  i: integer;
begin
  SetLength(Points, sek);
  for i := 0 to sek - 1 do begin
    Points[i].vec.x := sin(Pi * 2 / sek * i) * r;
    Points[i].vec.y := cos(Pi * 2 / sek * i) * r;
    Points[i].col[0]:=Random;
    Points[i].col[1]:=Random;
    Points[i].col[2]:=Random;
    Points[i].PointSize := (i + 1) * 3;
  end;
end;

(*
Daten für die Punkte in die Grafikkarte übertragen
*)

//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBPoint.VAO);

  // Daten für Punkt Position
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TPoint) * 4 * Length(Points), Pointer(Points), GL_STATIC_DRAW);

  Caption := IntToStr(SizeOf(TPoint));

  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, SizeOf(TPoint), nil);

  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, SizeOf(TPoint), Pointer(8));

  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 1, GL_FLOAT, False, SizeOf(TPoint), Pointer(20));

end;

//code-

(*
Zeichnen der Punkte
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  ofs = 0.4;
begin
  glEnable(GL_PROGRAM_POINT_SIZE);

  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBPoint.VAO);
  // gelb
  glUniform3f(Color_ID, 1.0, 1.0, 0.0);
  glDrawArrays(GL_POINTS, 0, Length(Points));


  ogc.SwapBuffers;
end;

//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBPoint.VAO);

  glDeleteBuffers(1, @VBPoint.VBO);
  glDeleteBuffers(1, @VBPoint.VBO_Size);
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
