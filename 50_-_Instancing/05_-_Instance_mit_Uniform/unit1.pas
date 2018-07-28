unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL, oglVector, oglMatrix,
  oglContext, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
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
Man kann für jede Instance einen eigenen Uniform-Wert zu ordnen. Dafür packt man die Uniform-Werte in ein Array,
welches >= anzahl Instancen ist.

Dieses Verfahren hat zwei Nachteile.
1. Man muss die Anzahl Intancen von Anfang an wissen.
2. Die Anzahl Uniform-Werte ist begrenzt, bei diesem Beispiel und einem Intel4000 ist bei gut 800 Instancen Schluss.

Diese Nachteile kann man umgehen, wen man anstelle von Uniformen VertexAttrib verwendet, dazu im nächasten Thema.
*)

//lineal

const
  Quad: array[0..1] of TFace2D =
    (((-0.01, -0.01), (-0.01, 0.01), (0.01, 0.01)),
    ((-0.01, -0.01), (0.01, 0.01), (0.01, -0.01)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

(*
Die Anzahl Instance
*)
//code+
const
  InstanceCount = 200;
//code-

(*
Die Deklaration, der Paramter für die einzelnen Instancen.
Die Size könnte man mit der Matrix kombinieren, aber hier geht es um die Funktionsweise der Uniform-Übergaben.
*)
//code+
var
  Matrix_ID, Color_ID, Size_ID: GLint;

  VBQuad: TVB;

  Data: record
    Size: array[0..InstanceCount - 1] of GLfloat;
    Matrix: array[0..InstanceCount - 1] of TMatrix;
    Color: array[0..InstanceCount - 1] of TVector3f;
  end;
//code-

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  InitScene;
  Timer1.Enabled := True;   // Timer starten
end;

(*
Das Auslesen der UniformID. Dies geschieht gleich wie bei einfachen Uniformen.
Die Instancen-Parameter mit zufälligen Werten belegen.
*)
//code+
procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Size_ID := Shader.UniformLocation('Size');
  Matrix_ID := Shader.UniformLocation('mat');
  Color_ID := Shader.UniformLocation('Color');

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBO);

  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Size[i] := Random() * 20 + 1.0;
    Data.Matrix[i].Identity;
    Data.Matrix[i].Translate(1.5 - Random * 3.0, 1.5- Random * 3.0, 0.0);
    Data.Color[i] := vec3(Random, Random, Random);
  end;
end;
//code-

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);
end;

(*
Die Übergabe der Uniform-Werte. Da es sich um Arrays handelt, muss man noch die Länge der Array übergeben.
Auch sieht man gut, das mal <b>glDrawArraysInstanced(...</b> nur einmal aufrufen muss.
Würde man dies ohne Instancen lössen, müsste man die Uniformübergabe und glDraw... 200x aufrufen.
Da sieht man den Vorteil, es ist viel weniger Kominikation mit der Grafikkarte nötig.
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBQuad.VAO);

  glUniform1fv(Size_ID, InstanceCount, @Data.Size);
  glUniformMatrix4fv(Matrix_ID, InstanceCount, False, @Data.Matrix);
  glUniform3fv(Color_ID, InstanceCount, @Data.Color);
  glDrawArraysInstanced(GL_TRIANGLES, 0, Length(Quad) * 3, InstanceCount);

  ogc.SwapBuffers;
end;
//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;
  Shader.Free;
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

(*
Die Matrizen drehen.
Dies muss man 200x machen, aber es sind nicht 200 Übergaben zur Grafikkarte nötig.
*)
//code+
procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(Data.Matrix) - 1 do begin
    Data.Matrix[i].RotateC(0.02);
  end;

  ogcDrawScene(Sender);  // Neu zeichnen
end;
//code-

//lineal

(*
<b>Vertex-Shader:</b>
Hier sieht man, das mit <b>gl_InstanceID</b> auf die eizelnen Array-Elemente zugegriffen wird.
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
