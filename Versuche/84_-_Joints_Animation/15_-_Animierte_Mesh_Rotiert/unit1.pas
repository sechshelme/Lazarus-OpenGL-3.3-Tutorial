unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls,
  dglOpenGL, oglDebug,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix,
  CubeJoints;

  //image image.png
  //lineal

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    time:Integer;
    procedure CreatJointsMatrix;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcKeyPress(Sender: TObject; var Key: char);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  jointCount = 6;

type
  TUBOBuffer = record
    WorldMatrix: Tmat4x4;
    ModelMatrix: Tmat4x4;
    JointMatrix: array [0..(jointCount + 1) * 6 - 1] of Tmat4x4;
  end;

var
  cube: TVectors3f = nil;
  cubeColor: TVectors3f = nil;
  cubeJointIDs: TJointIDs = nil;

type
  TVB = record
    VAO,
    VBO, VBOColor, VBOJoint: GLuint;
  end;

var
  VBQuad: TVB;
  UBOBuffer: TUBOBuffer;
  UBO,
  UBO_ID: GLint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 640;
  Height := 480;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnKeyPress := @ogcKeyPress;

  CreateScene;
end;

const
  rot = 1.0;

procedure TForm1.CreatJointsMatrix;
var
  i: integer;
  r: Single;
begin
  //for i := 0 to 100 do begin
  //  r := Double( now * 1000000000000);
  //  Sleep(1);
  //  WriteLn(r);
  //end;
  //

  for i := 0 to 5 do begin
    UBOBuffer.JointMatrix[i].Identity;
  end;

  UBOBuffer.JointMatrix[1].RotateB(pi);
  UBOBuffer.JointMatrix[2].RotateB(pi / 2 * 3);
  UBOBuffer.JointMatrix[3].RotateB(pi / 2);
  UBOBuffer.JointMatrix[4].RotateA(pi / 2);
  UBOBuffer.JointMatrix[5].RotateA(-pi / 2);

  for i := 6 to Length(UBOBuffer.JointMatrix) - 1 do begin
    if i > 5 then begin
      UBOBuffer.JointMatrix[i] := UBOBuffer.JointMatrix[i - 6];
    end;

    UBOBuffer.JointMatrix[i].TranslateLocalspace(0, 0, 1.0);
    r := (0.5 - random) / rot;
    r := sin(time/100)/1.2;

//    r:=Single(word(QWord( now)))/100000;
//    r:=Single(word(QWord( now/1000)))/1000000;

    case i mod 6 of
      0, 1: begin
        UBOBuffer.JointMatrix[i].RotateA(r);
      end;
      2, 3: begin
        UBOBuffer.JointMatrix[i].RotateB(r);
      end;
      4, 5: begin
        UBOBuffer.JointMatrix[i].RotateC(r);
      end;
    end;
    UBOBuffer.JointMatrix[i].TranslateLocalspace(0, 0, 1.0);
    UBOBuffer.JointMatrix[i].Scale(0.95);
  end;
end;

procedure TForm1.CreateScene;
var
  i: integer;
  tmpCube: TVectors3f;
  ofs: SizeInt;
const
  colors: array of PVector3f = (@vec3blue, @vec3green, @vec3cyan, @vec3red, @vec3magenta, @vec3yellow);
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
  glGenBuffers(1, @UBO);
  // UBO anlegen
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
  glClearColor(0.15, 0.15, 0.05, 1.0);

  CreatJointsMatrix;

  // center
  cube.AddCube;
  cube.scale(2);
  cubeColor.AddCubeColor([0.5, 0.5, 0.1]);
  cubeJointIDs.AddCube(-1, -1);

  // Arme
  for i := 0 to Length(UBOBuffer.JointMatrix) - 6 - 1 do begin
    tmpCube := nil;
    tmpCube.AddCubeLateral;
    tmpCube.Scale([1, 1, 0]);
    tmpCube.Translate([0.0, 0.0, 1.0]);
    cube.Add(tmpCube);
    cubeColor.AddCubeLateralColor(colors[(i div 6) mod 6]^);
    cubeJointIDs.AddCubeLateral(i, i + 6);
  end;

  // Abschluss
  for i := 0 to 5 do begin
    tmpCube := nil;
    tmpCube.AddRectangle;
    tmpCube.Translate([0.0, 0.0, 1.0]);
    cube.Add(tmpCube);

    ofs := i + Length(UBOBuffer.JointMatrix) - 6;
    cubeColor.AddRectangleColor(colors[((ofs - 6) div 6) mod 6]^);
    cubeJointIDs.AddRectangle(ofs);
  end;

  // --- Create VAO Buffer
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

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
  glGenBuffers(1, @VBQuad.VBOJoint);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOJoint);
  glBufferData(GL_ARRAY_BUFFER, cubeJointIDs.Size, cubeJointIDs.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribIPointer(2, 1, GL_INT, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  Shader.UseProgram;

  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, cube.Count);

  ogc.SwapBuffers;
end;

procedure TForm1.ogcKeyPress(Sender: TObject; var Key: char);
begin
  CreatJointsMatrix;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteBuffers(1, @UBO);
  glDeleteBuffers(1, @VBQuad.VBO);
  glDeleteBuffers(1, @VBQuad.VBOColor);
  glDeleteBuffers(1, @VBQuad.VBOJoint);
  glDeleteVertexArrays(1, @VBQuad.VAO);
end;

procedure TForm1.FormResize(Sender: TObject);
var
  perm, wm: Tmat4x4;
begin
  wm.Identity;
  wm.Translate(0, 0, -50);
  wm.RotateA(0.3);
  perm.Perspective(30, ClientWidth / ClientHeight, 0.1, 1000.0);

  UBOBuffer.WorldMatrix := perm * wm;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  inc(time);
  CreatJointsMatrix;
  UBOBuffer.ModelMatrix.RotateB(0.012);
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
