unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls,
  oglglad_gl,
  oglVector, oglMatrix,
  oglContext, oglShader;

//image image.png
(*
Mit <b>VertexAttribDivisor</b> kann man nicht nur bestimmen, das es sich im ein Instance-Attribut handelt.
Man kann auch festlegen, das ein Attribut-Wert mehrmals verwendet wird, bevor er um eins weiter springt.
Im Beispiel sieht man, das der Farb-Wert vier mal verwendet wird, bevor der nächste wert kommt.
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
Für die Farben werden nur 4 Werte benötigt. Diese werden als Konstante deklariert,
da diese sich zur Laufzeit nicht mehr ändern.
*)
//code+
const
  Quad: array[0..1] of TFace3D =
    (((-0.8, -0.8, 0.0), (-0.8, 0.8, 0.0), (0.8, 0.8, 0.0)),
    ((-0.8, -0.8, 0.0), (0.8, -0.8, 0.0), (0.8, 0.8, 0.0)));

  Instance_Color: array[0..3] of TVector3f =
    ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0), (1.0, 1.0, 0.0));
//code-

(*
Rechtecke gibt es 16 Stück, die Matrizen dafür sind dynamisch.
*)
//code+
var
  Instance_Matrix: array[0..15] of TMatrix;
//code-

type
  TVB = record
    VAO: GLuint;
    VBO: record
      Pos, iMatrix, iColor: GLuint;
    end;
  end;

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
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
var
  i: integer;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  glGenVertexArrays(1, @VBTriangle.VAO);
  glGenBuffers(3, @VBTriangle.VBO);
end;

(*
Mit <b>glVertexAttribDivisor(...</b> kann man nicht nur bestimmen, das es sich um ein Instance-Attribut handelt.
Sondern man kann auch sagen wie viel mal ein Attribut-Wert verwendet wird.
Dies geschieht mit dem zweiten Parameter.
*)
//code+
procedure TForm1.InitScene;
var
  i: integer;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  glBindVertexArray(VBTriangle.VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.Pos);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Quad), @Quad, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glVertexAttribDivisor(0, 0);

  // Instance Color
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iColor);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(Instance_Color), @Instance_Color, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, nil);
  glVertexAttribDivisor(1, 4); // Wert 4x verwenden.

  // Instance Matrix
  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iMatrix);
  glBufferData(GL_ARRAY_BUFFER, SizeOf(TMatrix) * Length(Instance_Matrix), nil, GL_STATIC_DRAW);
  for i := 0 to 3 do begin
    glEnableVertexAttribArray(i + 2);
    glVertexAttribPointer(i + 2, 4, GL_FLOAT, GL_FALSE, SizeOf(TMatrix), Pointer(i * 16));
    glVertexAttribDivisor(i + 2, 1); // Wert 1x verwenden.
  end;
end;
//code-

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT);

  Shader.UseProgram;

  glBindVertexArray(VBTriangle.VAO);
  glDrawArraysInstanced(GL_TRIANGLE_FAN, 0, Length(Quad) * 3, 16);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBTriangle.VAO);

  glDeleteBuffers(3, @VBTriangle.VBO);
end;

(*
Matrizen drehen und anschliessend, neu laden.
*)
//code+
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

  for i := 0 to 15 do begin
    Instance_Matrix[i].Identity;
    Instance_Matrix[i].Scale(0.25, 0.05, 1.0);
    Instance_Matrix[i].RotateC(Pi * 2 / 16 * i + r);
    Instance_Matrix[i].TranslateLocalspace(2.0, 0.0, 0.0);
  end;

  glBindVertexArray(VBTriangle.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBTriangle.VBO.iMatrix);
  glBufferSubData(GL_ARRAY_BUFFER, 0, SizeOf(TMatrix) * Length(Instance_Matrix), @Instance_Matrix);

  ogc.Invalidate;
end;
//code-

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
