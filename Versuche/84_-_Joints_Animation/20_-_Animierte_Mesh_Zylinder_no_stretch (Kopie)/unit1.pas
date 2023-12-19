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
    time: integer;
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
  cubeSize=2;
  boneCount = 10;
  boneSize=12/boneCount;
  jointCount = boneCount + 1;
  isCylinder: boolean = False;
  is3Darm: boolean = False;

type
  TUBOBuffer = record
    WorldMatrix, ModelMatrix: Tmat4x4;
    JointMatrix: array [0..jointCount * 6 - 1] of Tmat4x4;
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
  i, j, ofs: integer;
  sc, angeleu, transSize, angelem: single;
  matrixs: array of Pmat4x4 = (@mat4x4Identity, @mat4x4B180, @mat4x4B270, @mat4x4B90, @mat4x4A90, @mat4x4A270);
  m: Tmat4x4;

begin
  for j := 0 to 5 do begin
    m := matrixs[j]^;
    for i := 0 to jointCount - 1 do begin
      ofs := j * jointCount + i;
      transSize:=cubeSize/2 + i * boneSize;
//      angeleu := sin(time / 100 * i) / 2.5;
      angeleu := sin(time / 100 * (i/boneCount)) / boneCount*3;
      angelem := angeleu * 2;

      UBOBuffer.JointMatrix[ofs] := m;
      UBOBuffer.JointMatrix[ofs].TranslateLocalspace(0.0, 0.0, transSize);

      m.TranslateLocalspace(0.0, 0.0, transSize);

      case j of
        0, 1: begin
          UBOBuffer.JointMatrix[ofs].RotateA(angeleu);
          m.RotateA(angelem);
          if is3Darm then  begin
            UBOBuffer.JointMatrix[ofs].RotateB(angeleu * 1.2);
            m.RotateB(angelem * 1.2);
          end;
        end;
        2, 3: begin
          UBOBuffer.JointMatrix[ofs].RotateB(angeleu);
          m.RotateB(angeleu);
          if is3Darm then  begin
            UBOBuffer.JointMatrix[ofs].RotateC(angeleu * 1.2);
            m.RotateC(angelem * 1.2);
          end;
        end;
        4, 5: begin
          UBOBuffer.JointMatrix[ofs].RotateC(angeleu);
          m.RotateC(angeleu);
          if is3Darm then  begin
            UBOBuffer.JointMatrix[ofs].RotateA(angeleu * 1.2);
            m.RotateA(angelem * 1.2);
          end;
        end;
      end;

      sc := 1 / cos(angeleu);
      UBOBuffer.JointMatrix[ofs].Scale(sc, sc, sc);
      UBOBuffer.JointMatrix[ofs].TranslateLocalspace(0.0, 0.0, -transSize);

      m.TranslateLocalspace(0.0, 0.0, -transSize);


      //      UBOBuffer.JointMatrix[ofs].Scale(0.95);
    end;
  end;
end;

procedure TForm1.CreateArms;
const
  colors: array of PVector3f = (@vec3blue, @vec3green, @vec3cyan, @vec3red, @vec3magenta, @vec3yellow);
var
  tmpCube: TVectors3f;
  ofs: SizeInt;
  i, j: integer;
  transSize:Single;

  cubeVertex: TVectors3f = nil;
  cubeColor: TVectors3f = nil;
  cubeNormale: TVectors3f = nil;
  cubeJointIDs: TJointIDs = nil;
begin

  // center
  cubeVertex.AddCube;
  cubeVertex.scale(cubeSize);
  cubeColor.AddCubeColor([0.5, 0.5, 0.1]);
  cubeNormale.AddCubeNormale;
  cubeJointIDs.AddCube(-1, -1);

  // Arme
  for j := 0 to 5 do begin
    for i := 0 to boneCount - 1 do begin
      ofs := j * jointCount + i;
      tmpCube := nil;
      transSize:=boneSize/2+cubeSize /2 + boneSize * i;

      if isCylinder then begin
        tmpCube.AddZylinder;
        tmpCube.Scale([1, 1, boneSize]);
        tmpCube.Translate([0.0, 0.0, transSize]);
        cubeVertex.Add(tmpCube);
        cubeColor.AddZylinderColor(colors[i mod 6]^);
        cubeNormale.AddZylinderNormale;
        cubeJointIDs.AddZylinder(ofs, ofs + 1);
      end else begin
        tmpCube.AddCubeLateral;
        tmpCube.Scale([1, 1, boneSize]);
//        tmpCube.Translate([0.0, 0.0,  cubeSize + i * 2]);
        tmpCube.Translate([0.0, 0.0,  transSize]);
        cubeVertex.Add(tmpCube);
        cubeColor.AddCubeLateralColor(colors[i mod 6]^);
        cubeNormale.AddCubeLateralNormale;
        cubeJointIDs.AddCubeLateral(ofs, ofs + 1);
      end;
    end;

    // Abschluss
    tmpCube := nil;
    if isCylinder then begin
      tmpCube.AddDisc;
      tmpCube.Translate([0.0, 0.0, boneCount * boneSize + cubeSize/2]);
      cubeVertex.Add(tmpCube);

      cubeColor.AddDiscColor(colors[(boneCount - 1) mod 6]^);
      cubeNormale.AddDiscNormal;
      cubeJointIDs.AddDisc(ofs + 1);
    end else begin
      tmpCube.AddRectangle;
      tmpCube.Translate([0.0, 0.0, boneCount * boneSize + cubeSize/2]);
      cubeVertex.Add(tmpCube);

      cubeColor.AddRectangleColor(colors[(boneCount - 1) mod 6]^);
      cubeNormale.AddRectangleNormale;
      cubeJointIDs.AddRectangle(ofs + 1);
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
  Inc(time);
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
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
