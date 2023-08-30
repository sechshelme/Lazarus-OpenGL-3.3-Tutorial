unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglVector, oglMatrix, oglShader;

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

  //code+
var
  Point: array of TVector3f;
  PointSize: array of GLfloat;
  //code-

  glModelViewProjectionMatrix: Tmat4x4;
  glModelViewMatrix: Tmat4x4;
  glModelViewProjectionMatrixInverse: Tmat4x4;
  glProjectionMatrixInverse: Tmat4x4;

  glModelViewProjectionMatrix_ID: GLint;
  glModelViewMatrix_ID: GLint;
  glModelViewProjectionMatrixInverse_ID: GLint;
  glProjectionMatrixInverse_ID: GLint;



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
var
  viewport: TVector4f;
  vp_ID: GLint;
//  aviewport: PGLfloat;
begin
  glModelViewProjectionMatrix.Identity;
  glModelViewMatrix.Identity;
  glModelViewProjectionMatrixInverse.Identity;
  glProjectionMatrixInverse.Identity;

  glModelViewProjectionMatrix.Scale(0.1);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;
  Color_ID := Shader.UniformLocation('Color');
  X_ID := Shader.UniformLocation('x');
  Y_ID := Shader.UniformLocation('y');
  PointTyp_ID := Shader.UniformLocation('PointTyp');

  glModelViewProjectionMatrix_ID := Shader.UniformLocation('glModelViewProjectionMatrix');
  glModelViewMatrix_ID := Shader.UniformLocation('glModelViewMatrix');
  glModelViewProjectionMatrixInverse_ID := Shader.UniformLocation('glModelViewProjectionMatrixInverse');
  glProjectionMatrixInverse_ID := Shader.UniformLocation('glProjectionMatrixInverse');

  //WriteLn(glModelViewProjectionMatrix_ID);
  //WriteLn(glModelViewMatrix_ID);
  //WriteLn(glModelViewProjectionMatrixInverse_ID);
  //WriteLn(glProjectionMatrixInverse_ID);

  glGenVertexArrays(1, @VBPoint.VAO);
  glGenBuffers(1, @VBPoint.VBO);
  glGenBuffers(1, @VBPoint.VBO_Size);

  glGetFloatv(GL_VIEWPORT, PGLfloat(viewport));
  WriteLn(viewport[0]:10:5);
  WriteLn(viewport[1]:10:5);
  WriteLn(viewport[2]:10:5);
  WriteLn(viewport[3]:10:5);
  vp_ID := Shader.UniformLocation('viewport');
  glUniform4fv(vp_ID,1,viewport);

  WriteLn(vp_ID);

end;

procedure TForm1.CreateVertex;
const
  r = 0.3;
  sek = 140;
var
  i: integer;
begin
  SetLength(Point, sek);
  SetLength(PointSize, sek);
  for i := 0 to sek - 1 do begin
    Point[i, 0] := sin(Pi * 2 / sek * i) * r;
    Point[i, 1] := cos(Pi * 2 / sek * i) * r;
    Point[i, 2] := 0.0;
    PointSize[i] := i * 3;
  end;
end;

(*
Daten für die Punkte in die Grafikkarte übertragen
*)

//code+
procedure TForm1.InitScene;
begin
  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  // Daten für Punkt Position
  glBindVertexArray(VBPoint.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TVector3f) * Length(Point), Pointer(Point), GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // Daten für Punkt Grösse
  glBindVertexArray(VBPoint.VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO_Size);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * Length(PointSize), Pointer(PointSize), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 1, GL_FLOAT, False, 0, nil);
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

  glModelViewProjectionMatrix.Uniform(glModelViewProjectionMatrix_ID);
  glModelViewMatrix.Uniform(glModelViewMatrix_ID);
  glModelViewProjectionMatrixInverse.Uniform(glModelViewProjectionMatrixInverse_ID);
  glProjectionMatrixInverse.Uniform(glProjectionMatrixInverse_ID);


  glBindVertexArray(VBPoint.VAO);
  // gelb
  glUniform1i(PointTyp_ID, 0);
  glUniform3f(Color_ID, 1.0, 1.0, 0.0);
  glUniform1f(X_ID, -ofs);
  glUniform1f(Y_ID, -ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));

  // rot
  glUniform1i(PointTyp_ID, 1);
  glUniform3f(Color_ID, 1.0, 0.0, 0.0);
  glUniform1f(X_ID, ofs);
  glUniform1f(Y_ID, -ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));

  // grün
  glUniform1i(PointTyp_ID, 2);
  glUniform3f(Color_ID, 0.0, 1.0, 0.0);
  glUniform1f(X_ID, ofs);
  glUniform1f(Y_ID, ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));

  // blau
  glUniform1i(PointTyp_ID, 3);
  glUniform3f(Color_ID, 0.0, 0.0, 1.0);
  glUniform1f(X_ID, -ofs);
  glUniform1f(Y_ID, ofs);
  glDrawArrays(GL_POINTS, 0, Length(Point));

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
