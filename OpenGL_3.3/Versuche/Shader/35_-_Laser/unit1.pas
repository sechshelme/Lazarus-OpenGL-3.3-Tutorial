unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix;

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
Zum Schluss eine kleine Spielerei: Hier wird ein Mandelbrot im Shader (also auf der GPU) berechnet.
Mit der CPU hatte ich noch keine so schnelle Berechnung hingekriegt, trotz Assembler.

Anmerkung: Bei diesem Beispiel geht es nicht um mathematische Hintegründe, sondern es soll legentlich demonstrieren, das man mit Shader-Programs sehr komplexe Berechnungen machen kann.

Der Lazarus-Code ist nichts besonderes, es wird nur ein Rechteck gerendert und anschliessend mit einer Matrix gedreht. Was eine Matrix ist, wird im Kapitel Matrix beschrieben.
<b>Achtung:</b> Eine lahme Grafikkarte kann bei Vollbild ins Stockern kommen.
Zur Beschleunigung kann der Wert <b>#define depth 1000.0</b> im Fragment-Shader verkleinert werden.
*)

//lineal

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

const
  Quad: array[0..1] of TFace =
    (((-0.8, -0.8, 0.0), (-0.8, 0.8, 0.0), (0.8, 0.8, 0.0)),
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  RotMatrix: TMatrix;
  Matrix_ID: GLint;
  MandelRot_ID,
  LichtRichtung_ID,
  Color_ID: GLint;

  LichtRichtung: array[0..3] of GLfloat;
  MandelRot: GLfloat;

  c: single;

  VBQuad: TVB;

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

procedure TForm1.CreateScene;
var
  i: integer;
begin
  Randomize;
  for i := 0 to Length(LichtRichtung) - 1 do begin
    LichtRichtung[i] := Random() * pi * 2;
  end;

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    UseProgram;
    Color_ID := UniformLocation('col');
    LichtRichtung_ID := UniformLocation('LichtRichtung');
    MandelRot_ID := UniformLocation('MandelRot');
    Matrix_ID := UniformLocation('mat');
  end;
  RotMatrix.Identity;

  glGenVertexArrays(1, @VBQuad.VAO);

  glGenBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.2, 0.1, 0.0, 1.0); // Hintergrundfarbe

  // Daten für Quadrat
  glBindVertexArray(VBQuad.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(10);
  glVertexAttribPointer(10, 3, GL_FLOAT, False, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  RotMatrix.Uniform(Matrix_ID);

  // Zeichne Quadrat

  glUniform1fv(LichtRichtung_ID, Length(LichtRichtung), @LichtRichtung);
  glUniform1f(Color_ID, c);
  glUniform1f(MandelRot_ID, MandelRot);
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Length(Quad) * 3);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.01;
var
  i: integer;
begin
  c += 0.1;
  if c >= 10.0 then begin
    c := c - 10.0;
  end;

  MandelRot += 0.0044;
  if MandelRot > 2 * pi then begin
    MandelRot -= 2 * pi;
  end;

  for i := 0 to Length(LichtRichtung) - 1 do begin
    LichtRichtung[i] += (0.084 * i / 10);
    if LichtRichtung[i] > 2 * pi then begin
      LichtRichtung[i] -= 2 * pi;
    end;
  end;

  RotMatrix.RotateC(step); // RotMatrix rotieren
  ogcDrawScene(Sender);    // Neu zeichnen
end;

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>

Hier steckt die ganze Berechnung für das Mandelbrot.
*)
//includeglsl Fragmentshader.glsl

end.
