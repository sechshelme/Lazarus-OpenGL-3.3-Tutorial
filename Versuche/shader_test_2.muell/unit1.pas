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
  Col: array of TVector3f;
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
    VBO, VBO_Size, VBOCol: GLuint;
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
  glGenBuffers(1, @VBPoint.VBOCol);
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

const
        RAND_MAX = 32767;

function rand_minus_one_one: TGLfloat;
var
  i: integer;
begin
  i := Random(2) * 2 - 1;
  Result := Random / RAND_MAX * i;
/////G/G(/7    WriteLn(Result: 10: 5);
end;

function rand_zero_one: TGLfloat;
begin
  Result := Random / RAND_MAX;
end;



procedure TForm1.CreateVertex;
const
  r = 1.3;
  sek = 1600;
var
  i: integer;
begin
  SetLength(Point, sek);
  SetLength(Col, sek);
  SetLength(PointSize, sek);
  for i := 0 to sek - 1 do begin
//    Point[i, 0] := rand_minus_one_one / 2;
//    Point[i, 1] := rand_minus_one_one / 2;
    Point[i, 0] := Random / 2;
    Point[i, 1] := Random / 2;
    Point[i, 2] := 0;
    PointSize[i] := Random * 1;
    col[i, 0] := Random;
    col[i, 1] := Random;
    col[i, 2] := Random;
    col[i, 0] := 0;
    col[i, 1] := 1;
    col[i, 2] := 0;

    Point[i, 0] := sin(Pi * 2 / sek * i*10) * r/2;
    Point[i, 1] := cos(Pi * 2 / sek * i*10) * r/2;
 // WriteLn(Point[i, 0]:10:5 ,      '       ', Point[i, 1] :10:5);

    //Point[i, 2] := 0.0;
    //PointSize[i] := Random * 1;
    //col[i, 0] := Random;
    //col[i, 1] := Random;
    //col[i, 2] := Random;
    //col[i, 0] := 0;
    //col[i, 1] := 1;
    //col[i, 2] := 0;
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
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

    // Daten für Color
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBOCol);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TVector3f) * Length(col), Pointer(col), GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // Daten für Punkt Grösse
  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO_Size);
  glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * Length(PointSize), Pointer(PointSize), GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 1, GL_FLOAT, False, 0, nil);
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
