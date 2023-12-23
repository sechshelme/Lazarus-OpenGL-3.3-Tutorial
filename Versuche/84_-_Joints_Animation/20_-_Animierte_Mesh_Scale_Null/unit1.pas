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
    timeCounter: integer;
    procedure CreatJointsMatrix;
    procedure CreateArms;
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
  isCylinder: boolean = False;
  is3Darm: boolean = True;

type
  TUBOBuffer = record
    WorldMatrix, ModelMatrix: Tmat4x4;
    JointMatrix: array [0..(jointCount + 1) * 6 - 1] of Tmat4x4;
  end;

var
  VAO: TGLuint;
  Mesh_Buffers: array [(mbVBO, mbVBOColor, mbVBONormal, mbVBOJoint, mbUBO)] of TGLuint;
  UBOBuffer: TUBOBuffer;
  VertexCount: integer;

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

procedure TForm1.CreatJointsMatrix;
var
  i: integer;
  angele: single;
  matrixs: array of Pmat4x4 = (@mat4x4Identity, @mat4x4B180, @mat4x4B270, @mat4x4B90, @mat4x4A90, @mat4x4A270);

begin
  for i := 0 to 5 do begin
    UBOBuffer.JointMatrix[i] := matrixs[i]^;
  end;

  for i := 6 to Length(UBOBuffer.JointMatrix) - 1 do begin
    UBOBuffer.JointMatrix[i] := UBOBuffer.JointMatrix[i - 6];

    UBOBuffer.JointMatrix[i].TranslateLocalspace(0.0, 0.0, 2.0);
    angele := sin(timeCounter / 400 * i) / 1.2;

    case i mod 6 of
      0, 1: begin
        UBOBuffer.JointMatrix[i].RotateA(angele);
        if is3Darm then  begin
          UBOBuffer.JointMatrix[i].RotateB(angele * 1.2);
        end;
      end;
      2, 3: begin
        UBOBuffer.JointMatrix[i].RotateB(angele);
        if is3Darm then  begin
          UBOBuffer.JointMatrix[i].RotateC(angele * 1.2);
        end;
      end;
      4, 5: begin
        UBOBuffer.JointMatrix[i].RotateC(angele);
        if is3Darm then  begin
          UBOBuffer.JointMatrix[i].RotateA(angele * 1.2);
        end;
      end;
    end;
    UBOBuffer.JointMatrix[i].Scale(0.95);
  end;
end;

procedure TForm1.CreateArms;
const
  colors: array of PVector3f = (@vec3blue, @vec3green, @vec3cyan, @vec3red, @vec3magenta, @vec3yellow);
var
  tmpCube: TVectors3f;
  ofs: SizeInt;
  i: integer;
var
  cubeVertex: TVectors3f = nil;
  cubeColor: TVectors3f = nil;
  cubeNormale: TVectors3f = nil;
  cubeJointIDs: TJointIDs = nil;
  m: Tmat4x4;
begin
  m.Identity;
  m.RotateC(pi / 4);
  m.WriteMatrix;


  // center
  cubeVertex.AddCube;
  cubeVertex.scale(2);
  cubeColor.AddCubeColor([0.5, 0.5, 0.1]);
  cubeNormale.AddCubeNormale;
  cubeJointIDs.AddCube(-1, -1);

  // Arme
  for i := 0 to Length(UBOBuffer.JointMatrix) - 6 - 1 do begin
    tmpCube := nil;
    if isCylinder then begin
      tmpCube.AddZylinder;
      tmpCube.Scale([1, 1, 0]);
      tmpCube.Translate([0.0, 0.0, 1.0]);
      cubeVertex.Add(tmpCube);
      cubeColor.AddZylinderColor(colors[(i div 6) mod 6]^);
      cubeNormale.AddZylinderNormale;
      cubeJointIDs.AddZylinder(i, i + 6);
    end else begin
      tmpCube.AddCubeLateral;
      tmpCube.Scale([1, 1, 0]);
      tmpCube.Translate([0.0, 0.0, 1.0]);
      cubeVertex.Add(tmpCube);
      cubeColor.AddCubeLateralColor(colors[(i div 6) mod 6]^);
      cubeNormale.AddCubeLateralNormale;
      cubeJointIDs.AddCubeLateral(i, i + 6);
    end;
  end;

  // Abschluss
  for i := 0 to 5 do begin
    tmpCube := nil;
    ofs := i + Length(UBOBuffer.JointMatrix) - 6;
    if isCylinder then begin
      tmpCube.AddDisc;
      tmpCube.Translate([0.0, 0.0, 1.0]);
      cubeVertex.Add(tmpCube);

      cubeColor.AddDiscColor(colors[((ofs - 6) div 6) mod 6]^);
      cubeNormale.AddDiscNormal;
      cubeJointIDs.AddDisc(ofs);
    end else begin
      tmpCube.AddRectangle;
      tmpCube.Translate([0.0, 0.0, 1.0]);
      cubeVertex.Add(tmpCube);

      cubeColor.AddRectangleColor(colors[((ofs - 6) div 6) mod 6]^);
      cubeNormale.AddRectangleNormale;
      cubeJointIDs.AddRectangle(ofs);
    end;
  end;

  //  VAO Buffer
  glBindVertexArray(VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBO]);
  glBufferData(GL_ARRAY_BUFFER, cubeVertex.Size, cubeVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Color
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOColor]);
  glBufferData(GL_ARRAY_BUFFER, cubeColor.Size, cubeColor.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBONormal]);
  glBufferData(GL_ARRAY_BUFFER, cubeNormale.Size, cubeNormale.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 3, GL_FLOAT, False, 0, nil);

  // Joints
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOJoint]);
  glBufferData(GL_ARRAY_BUFFER, cubeJointIDs.Size, cubeJointIDs.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(3);
  glVertexAttribIPointer(3, 1, GL_INT, 0, nil);

  VertexCount := cubeVertex.Count;
end;

procedure TForm1.CreateScene;
var
  UBO_ID: GLuint;
begin
  InitOpenGLDebug;

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  // --- Buffer anlegen
  glGenVertexArrays(1, @VAO);
  glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  // --- UBO
  UBOBuffer.ModelMatrix.Identity;
  UBOBuffer.ModelMatrix.Scale(1.5);
  // UBO anlegen
  glBindBuffer(GL_UNIFORM_BUFFER, Mesh_Buffers[mbUBO]);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, Mesh_Buffers[mbUBO]);

  Timer1.Enabled := True;

  glEnable(GL_DEPTH_TEST);
  glEnable(GL_CULL_FACE);   // Überprüfung einschalten
  glCullFace(GL_BACK);      // Rückseite nicht zeichnen.
  glClearColor(0.15, 0.15, 0.05, 1.0);

  CreatJointsMatrix;
  CreateArms;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  Shader.UseProgram;

  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);

  glBindVertexArray(VAO);
  glDrawArrays(GL_TRIANGLES, 0, VertexCount);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteBuffers(Length(Mesh_Buffers), Mesh_Buffers);
  glDeleteVertexArrays(1, @VAO);
end;

procedure TForm1.FormResize(Sender: TObject);
var
  perm, wm: Tmat4x4;
begin
  wm.Identity;
  wm.Translate(0, 0, -50);
  wm.RotateA(0.30);
  perm.Perspective(30, ClientWidth / ClientHeight, 2.5, 1000.0);

  UBOBuffer.WorldMatrix := perm * wm;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Inc(timeCounter);
  CreatJointsMatrix;
  UBOBuffer.ModelMatrix.RotateB(0.012);
  ogcDrawScene(Sender);
end;

procedure TForm1.ogcKeyPress(Sender: TObject; var Key: char);
begin
  case Key of
    '2': begin
      is3Darm := False;
    end;
    '3': begin
      is3Darm := True;
    end;
    'c': begin
      isCylinder := True;
    end;
    't': begin
      Timer1.Enabled := not Timer1.Enabled;
    end;
    'q': begin
      isCylinder := False;
    end;
  end;
  CreateArms;
  CreatJointsMatrix;
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
