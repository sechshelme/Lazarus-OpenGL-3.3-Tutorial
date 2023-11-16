unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch typehelpers}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix;

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

//image image.png

(*
<b>Matrix um beliebigen Punt drehen.</b>

https://www.frassek.org/3d-mathe/rotationen-im-raum/3d-rotation-um-koordinatenachsen/
https://www.euclideanspace.com/maths/geometry/affine/aroundPoint/index.htm

<b>Kombinierte Rotation und Translation</b>
Um die Rotation um einen beliebigen Punkt zu berechnen,
müssen wir seine neue Rotation und Translation berechnen.
Mit anderen Worten ist die Drehung um einen Punkt eine „echte“ Isometrietransformation,
was bedeutet, dass sie eine lineare und eine rotatorische Komponente hat.

Mit den folgenden 3 einfacheren Transformationen, die, wenn sie in der richtigen Reihenfolge durchgeführt werden, äquivalent sind:

- Verschieben Sie den beliebigen Punkt zum Ursprung (subtrahieren Sie P, was durch -Px, -Py, -Pz übersetzt wird).
- um den Ursprung drehen (kann 3×3-Matrix R0 verwenden)
- dann zurückübersetzen. (P hinzufügen, was durch +Px,+Py,+Pz übersetzt wird)

[resultierende Transformation] = [+Px,+Py, +Pz] * [Rotation] * [-Px,-Py,-Pz]

Für die Translation muss LacalSpace verwendet werden.
*)

//lineal

const
  Triangle: TVectors2f = (
    -0.4, 0.1, 0.4, 0.1, 0.0, 0.7,

    -0.2, -0.6, -0.2, -0.1, 0.2, -0.1,
    -0.2, -0.6, 0.2, -0.1, 0.2, -0.6);

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  MatrixRot: Tmat2x2;
  MatrixRot_ID: GLint;
  Color_ID: GLint;

  VBTriangle: TVB;

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
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');
  MatrixRot_ID := Shader.UniformLocation('mat');
  MatrixRot.Identity;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenBuffers(1, @VBTriangle.VBO);
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Dreieck
  glBindVertexArray(VBTriangle.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO);
  glBufferData(GL_ARRAY_BUFFER, Triangle.Size, Triangle.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);
end;


procedure mat4_RotateCxxx(var m: Tmat4x4; ofs: TVector2f; a: GLfloat);
var
  i: integer;
  x, y, c, s: GLfloat;
begin
  c := cos(a);
  s := sin(a);
  for i := 0 to 2 do begin
    x := m[i, 0];
    y := m[i, 1];
    m[i, 0] := x * c - y * s + ofs.x;
    m[i, 1] := x * s + y * c + ofs.y;
  end;
end;

procedure mat4_RotateC(var m: Tmat2x2; ofs: TVector2f; a: GLfloat);
var
  i: integer;
  c, s, x, y: GLfloat;
begin
  c := cos(a);
  s := sin(a);
  for i := 0 to 1 do begin
    x := m[i, 0] - ofs.x;
    y := m[i, 1] - ofs.y;
    m[i, 0] := x * c - y * s + ofs.x;
    m[i, 1] := x * s + y * c + ofs.y;
  end;
end;


function rotateVector(v, ofs: TVector2f; a: TGLfloat): TVector2f;
begin
  Result.x := v.x * cos(a) - v.y * sin(a) + ofs.x;
  Result.y := v.x * sin(a) + v.y * cos(a) + ofs.y;
end;



procedure TForm1.ogcDrawScene(Sender: TObject);
var
  m: Tmat2x2;
const
  r: single = 0;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  m.Identity;
  //  mat4_RotateC(m, [0, -0.8], r);
  r += 0.05;

  //m.TranslateLocalspace(0, -0.4, 0);
  //r += 0.1;
  //m.RotateC(r);
  //m.TranslateLocalspaceY(0.4);



  //  m := MatrixRot * m;
  m.Uniform(MatrixRot_ID);

  // Zeichne Dreieck
  glUniform3f(Color_ID, 0.0, 1.0, 1.0);
  glBindVertexArray(VBTriangle.VAO);
  glDrawArrays(GL_TRIANGLES, 0, Triangle.Count);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);
  glDeleteBuffers(1, @VBTriangle.VBO);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step: GLfloat = 0.0;
begin
  MatrixRot.Rotate(step);
  step += 0.11;

  glUniform1f(Shader.UniformLocation('angele'), step);

  ogcDrawScene(Sender);
end;
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
