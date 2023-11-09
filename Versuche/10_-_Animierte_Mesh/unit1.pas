unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  dglOpenGL, oglDebug,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix,
  CubeJoints;

  //image image.png
  //lineal

(*
Den Geometrie-Shader kann man auch gut verwenden um Normale für Beleuchtungen zu berechnen.
*)

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{$PACKRECORDS 32}

type
  TUBOBuffer = record
    WorldMatrix: Tmat4x4;
    ModelMatrix: Tmat4x4;
    moveJoints: array [0..5] of record
      mat0: Tmat2x2;
        p0:TVector4f;
        mat1: Tmat2x2;
        p1:TVector4f;
      end;
  end;

var
  cube: TVectors3f = nil;
  cubeColor: TVectors3f = nil;
  cubeAni: TJointIDs = nil;

type
  TVB = record
    VAO,
    VBO,VBOColor, VBOAni: GLuint;
  end;

var
  VBQuad: TVB;
  UBOBuffer: TUBOBuffer;
  UBO,
  UBO_ID: GLint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

procedure TForm1.CreateScene;
var
  i: integer;
begin
  InitOpenGLDebug;

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_GEOMETRY_SHADER, 'GeometrieShader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  // --- UBO
  UBOBuffer.ModelMatrix.Identity;
  UBOBuffer.ModelMatrix.Scale(1.5);
  //  UBOBuffer.ModelMatrix.RotateC(pi / 2);
  //  UBOBuffer.ModelMatrix.RotateB(pi / 2);
  for i := 0 to Length(UBOBuffer.moveJoints) - 1 do begin
    UBOBuffer.moveJoints[i].mat0.Identity;
  end;

  glGenBuffers(1, @UBO);
  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, UBO);


  Timer1.Enabled := True;
  glEnable(GL_DEPTH_TEST);

  glEnable(GL_CULL_FACE);   // Überprüfung einschalten
  glCullFace(GL_BACK);      // Rückseite nicht zeichnen.

  glClearColor(0.6, 0.6, 0.4, 1.0);

  // --- Daten für den Würfel
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  // center
  cube.AddCube(1.0, 1.0, 1.0);
  cubeColor.AddCubeColor([0.5,0.5,0.1]);
  cubeAni.AddCube(jdLeft, 0, 0);

  // far
  cube.AddCube(0.5, 0.5, 1.0, 0, 0, 1);
  cubeColor.AddCubeColor([0.5,0.1,0.1]);
  cubeAni.AddCube(jdFar, 0, 01);

  // far far
  cube.AddCube(0.5, 0.5, 1.0, 0, 0, 2);
  cubeColor.AddCubeColor([0.1,0.1,0.5]);
  cubeAni.AddCube(jdFar, 1, 1);

  // near
  cube.AddCube(0.5, 0.5, 1.0, 0, 0, -1);
  cubeColor.AddCubeColor([0.5,0.1,0.1]);
  cubeAni.AddCube(jdNear, 0, 11);

  // near near
  cube.AddCube(0.5, 0.5, 1.0, 0, 0, -2);
  cubeColor.AddCubeColor([0.1,0.1,0.5]);
  cubeAni.AddCube(jdNear, 11, 11);

  // bottom
  cube.AddCube(0.5, 1.0, 0.5, 0, -1, 0);
  cubeColor.AddCubeColor([0.5,0.1,0.1]);
  cubeAni.AddCube(jdBottom, 0, 21);

  // bottom bottom
  cube.AddCube(0.5, 1.0, 0.5, 0, -2, 0);
  cubeColor.AddCubeColor([0.1,0.1,0.5]);
  cubeAni.AddCube(jdBottom, 21, 21);

  // right
  cube.AddCube(1.0, 0.5, 0.5, 1, 0, 0);
  cubeColor.AddCubeColor([0.5,0.1,0.1]);
  cubeAni.AddCube(jdRight, 0, 31);

  // right right
  cube.AddCube(1.0, 0.5, 0.5, 2, 0, 0);
  cubeColor.AddCubeColor([0.1,0.1,0.5]);
  cubeAni.AddCube(jdRight, 31, 31);

  // top
  cube.AddCube(0.5, 1.0, 0.5, 0, 1, 0);
  cubeColor.AddCubeColor([0.5,0.1,0.1]);
  cubeAni.AddCube(jdTop, 0, 41);

  // top top
  cube.AddCube(0.5, 1.0, 0.5, 0, 2, 0);
  cubeColor.AddCubeColor([0.1,0.1,0.5]);
  cubeAni.AddCube(jdTop, 41, 41);

  // left
  cube.AddCube(1.0, 0.5, 0.5, -1, 0, 0);
  cubeColor.AddCubeColor([0.5,0.1,0.1]);
  cubeAni.AddCube(jdLeft, 0, 51);

  // left left
  cube.AddCube(1.0, 0.5, 0.5, -2, 0, 0);
  cubeColor.AddCubeColor([0.1,0.1,0.5]);
  cubeAni.AddCube(jdLeft, 51, 51);

  WriteLn('len vert: ', cube.Size);
  WriteLn('len col: ', cubeColor.Size);
  WriteLn('len joints: ', cubeAni.Size);

  // Vektor
  glGenBuffers(1, @VBQuad.VBO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, cube.Size, cube.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Vektor
  glGenBuffers(1, @VBQuad.VBOColor);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOColor);
  glBufferData(GL_ARRAY_BUFFER, cubeColor.Size, cubeColor.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // Joints
  glGenBuffers(1, @VBQuad.VBOAni);

  // https://stackoverflow.com/questions/28014864/why-do-different-variations-of-glvertexattribpointer-exist

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOAni);
  glBufferData(GL_ARRAY_BUFFER, cubeAni.Size, cubeAni.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribIPointer(2, 1, GL_INT, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Shader.UseProgram;

  // Zeichne den Würfel
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, cube.Count);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteBuffers(1, @UBO);
  glDeleteBuffers(1, @VBQuad.VBO);
  glDeleteBuffers(1, @VBQuad.VBOColor);
  glDeleteBuffers(1, @VBQuad.VBOAni);
  glDeleteVertexArrays(1, @VBQuad.VAO);
end;

procedure TForm1.FormResize(Sender: TObject);
var
  perm, wm: Tmat4x4;
begin
  wm.Identity;
  wm.Translate(0, 0, -15);
  wm.RotateA(0.3);
  perm.Perspective(30, ClientWidth / ClientHeight, 0.1, 100.0);

  UBOBuffer.WorldMatrix := perm * wm;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step = 0.02;
var
  i: integer;

begin
  UBOBuffer.ModelMatrix.RotateB(0.0012);
  for i := 0 to Length(UBOBuffer.moveJoints) - 1 do begin
    UBOBuffer.moveJoints[i].mat0.Rotate(step * (1 + (i * 0.2)));
  end;

  //UBOBuffer.moveF.Rotate(step*1.1);
  //UBOBuffer.moveN.Rotate(step*1.2);
  //UBOBuffer.moveT.Rotate(step*1.3);
  //UBOBuffer.moveB.Rotate(step*1.4);
  //UBOBuffer.moveR.Rotate(step*1.5);
  //UBOBuffer.moveL.Rotate(step*1.6);

  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Geometrie-Shader:</b>
*)
//includeglsl Geometrieshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
