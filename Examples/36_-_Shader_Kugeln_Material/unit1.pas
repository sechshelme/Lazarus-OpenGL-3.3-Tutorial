unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  oglglad_gl,
  oglVector, oglMatrix, oglContext, oglShader, oglLightingShader;

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
    procedure CreateVertex;
    procedure CreateScene;
    procedure InitScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcResize(Sender: TObject);
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
    vec: TVector3f;
    PointSize: GLfloat;

    Mambient, Mdiffuse, Mspecular: TVector3f;
    Mshininess: GLfloat;
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
  ViewPort_ID,
  ProjectionMatrix_ID, ModelMatrix_ID: GLint;

  VBPoint: TVB;

  WorldMatrix, FrustumMatrix: Tmat4x4;

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
  ogc.OnResize := @ogcResize;
  ogc.AutoResizeViewport := False;

  CreateVertex;

  CreateScene;
  InitScene;
end;

procedure TForm1.CreateScene;
const v=1.0;
begin
  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  Shader.UseProgram;

  FrustumMatrix.Ortho(-v, v, -v, v, 2.5, 2000);
// FrustumMatrix.Frustum(-v, v, -v, v, 0.1, 1500);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -1000);

  ModelMatrix_ID := Shader.UniformLocation('ModelMatrix');
  ProjectionMatrix_ID := Shader.UniformLocation('ProjectionMatrix');
  ViewPort_ID := Shader.UniformLocation('viewport');

  glGenVertexArrays(1, @VBPoint.VAO);
  glGenBuffers(1, @VBPoint.VBO);
  glGenBuffers(1, @VBPoint.VBO_Size);
end;

procedure TForm1.CreateVertex;
const
  s = 2.2;
  sek = 200;
var
  i: integer;
  l: GLfloat;
  m: integer;
begin
  SetLength(Points, sek);

  for i := 0 to sek - 1 do begin
    repeat
      Points[i].vec := vec3(Random - 0.5, Random - 0.5, Random - 0.5);
      l := Points[i].vec.Length;
    until l <= 0.5;
    Points[i].vec.Scale(s);
    Points[i].PointSize := Random / 8;

    m := Random(Length(MaterialPara));
    Points[i].Mambient := MaterialPara[m].ambient.xyz;
    Points[i].Mdiffuse := MaterialPara[m].diffuse.xyz;
    Points[i].Mspecular := MaterialPara[m].specular.xyz;
    Points[i].Mshininess := MaterialPara[m].shininess;
  end;
end;

(*
Daten für die Punkte in die Grafikkarte übertragen
*)

//code+
procedure TForm1.InitScene;
var
  ofs:Pointer=nil;
begin
  glClearColor(0.1, 0.1, 0.4, 1.0);
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glBindVertexArray(VBPoint.VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBPoint.VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(TPoint) * Length(Points), Pointer(Points), GL_STATIC_DRAW);

  // Daten für Punkt Position
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, SizeOf(TPoint), ofs);
  Inc(ofs, SizeOf(TPoint.vec));

  // Daten für Punkt Grösse
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 1, GL_FLOAT, GL_FALSE, SizeOf(TPoint), ofs);
  Inc(ofs, SizeOf(TPoint.PointSize));

  // Daten für ambient
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, SizeOf(TPoint), ofs);
  Inc(ofs, SizeOf(TPoint.Mambient));

  // Daten für diffuse
  glEnableVertexAttribArray(3);
  glVertexAttribPointer(3, 3, GL_FLOAT, GL_FALSE, SizeOf(TPoint), ofs);
  Inc(ofs, SizeOf(TPoint.Mdiffuse));

  // Daten für specular
  glEnableVertexAttribArray(4);
  glVertexAttribPointer(4, 3, GL_FLOAT, GL_FALSE, SizeOf(TPoint), ofs);
  Inc(ofs, SizeOf(TPoint.Mspecular));

  // Daten für shininess
  glEnableVertexAttribArray(5);
  glVertexAttribPointer(5, 1, GL_FLOAT, GL_FALSE, SizeOf(TPoint), ofs);

  Timer1.Enabled := True;
end;

//code-

(*
Zeichnen der Punkte
*)
//code+
procedure TForm1.ogcDrawScene(Sender: TObject);
const
  ofs = 0.4;
var
  vp: TVector4f;
  Matrix: Tmat4x4;
begin
  glEnable(GL_PROGRAM_POINT_SIZE);

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Puffer löschen. glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  glBindVertexArray(VBPoint.VAO);

  glGetFloatv(GL_VIEWPORT, @vp);
  WriteLn(vp[0]: 10: 5, '  ', vp[1]: 10: 5, '  ', vp[2]: 10: 5, '  ', vp[3]: 10: 5, '  ');
  glUniform4fv(ViewPort_ID, 1, vp);

  Matrix := FrustumMatrix * WorldMatrix;
  //  Matrix:=ModelMatrix;
  Matrix.Uniform(ModelMatrix_ID);


  WriteLn(ProjectionMatrix_ID);
  WriteLn(ModelMatrix_ID);
  WriteLn(ViewPort_ID);

  FrustumMatrix.Uniform(ProjectionMatrix_ID);

  glDrawArrays(GL_POINTS, 0, Length(Points));

  ogc.SwapBuffers;
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  if ogc.Width > ogc.Height then begin
    glViewport(0, -(ogc.Width - ogc.Height) div 2, ogc.Width, ogc.Width);
  end else begin
    glViewport(-(ogc.Height - ogc.Width) div 2, 0, ogc.Height, ogc.Height);
  end;
end;

//code-

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBPoint.VAO);

  glDeleteBuffers(1, @VBPoint.VBO);
  glDeleteBuffers(1, @VBPoint.VBO_Size);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  WorldMatrix.RotateB(0.01);
  ogc.Invalidate;
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
