unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch typehelpers}
{$modeswitch arrayoperators}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix;

type
  TJointIDs = type TGlInts;

  { TJointIDsHelper }

  TJointIDsHelper = type Helper(TglintsHelper) for TJointIDs
    procedure AddQuad(pri, sek: integer);
  end;

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure CreateJoints;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

//image image.png
//lineal

const
  JointCount = 16;

type
  TUBOBuffer = record
    proMatrix,
    modelMatrix: TMatrix;
    JointMatrix: array [0..jointCount] of Tmat4x4;
  end;

var
  UBOBuffer: TUBOBuffer;
  QuadVertex: TVectors2f;
  QuadColor: TVectors3f;
  QuadJoint: TJointIDs;

var
  //  VAO, VBOVektor, VBOColor, UBO: GLint;
  VAO: GLuint;

  Mesh_Buffers: array [(mbVBOVektor, mbVBOColor, mbVBOJoint, mbUBO)] of TGLuint;

  TimerCounter: integer = 0;

var
  JointsPos: array of single;

procedure TJointIDsHelper.AddQuad(pri, sek: integer);
begin
  Self += [sek, pri, pri, sek, pri, sek];
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 640;
  //  Height := 480;
  Height := 640;
  //remove-
  Randomize;
  Timer1.Enabled := False;
  Timer1.Interval := 1120;
  Randomize;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

// https://www.youtube.com/watch?app=desktop&v=lDaQ3a43x8A

procedure TForm1.CreateJoints;
const
  colors: array of PVector3f = (@vec3blue, @vec3green, @vec3cyan, @vec3red, @vec3magenta, @vec3yellow);
var
  tmpQuad: TVectors2f = nil;
  i: integer;
  LenCube, LenGlobal: single;
begin
  QuadVertex := nil;
  QuadColor := nil;
  QuadJoint := nil;

  JointsPos := nil;
  LenGlobal := 0;

  for i := 0 to JointCount - 1 do begin
    LenCube := (0.5 + Random) / JointCount * 90;

    tmpQuad := nil;
    tmpQuad.addrectangle;
    tmpQuad.Scale([LenCube, 4]);
    tmpQuad.Translate([-LenGlobal - (LenCube / 2), 0.0]);
    QuadVertex.Add(tmpQuad);

    LenGlobal += LenCube;
    JointsPos += [LenGlobal];

    QuadColor.AddRectangleColor(colors[i mod Length(colors)]^);
    if i = 0 then  begin
      QuadJoint.AddQuad(-1, 0);
    end else begin
      QuadJoint.AddQuad(i - 1, i);
    end;
  end;
end;

procedure TForm1.CreateScene;
var
  UBO_ID: GLuint;
begin
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;

  glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, Mesh_Buffers[mbUBO]);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, Mesh_Buffers[mbUBO]);

  UBOBuffer.proMatrix.Identity;
  UBOBuffer.proMatrix.Scale(0.02);
  UBOBuffer.proMatrix.Translate(0.9, 0.0, 0.0);

  UBOBuffer.modelMatrix.Identity;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe
  //  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

  CreateJoints;

  // Daten für Quadrat
  glGenVertexArrays(1, @VAO);
  glBindVertexArray(VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOVektor]);
  glBufferData(GL_ARRAY_BUFFER, QuadVertex.Size, QuadVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // Color
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOColor]);
  glBufferData(GL_ARRAY_BUFFER, QuadColor.Size, QuadColor.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // Joints
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOJoint]);
  glBufferData(GL_ARRAY_BUFFER, QuadJoint.Size, QuadJoint.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribIPointer(2, 1, GL_INT, 0, nil);

  Timer1.Enabled := True;
end;

// https://de.serlo.org/mathe/1565/sinus-kosinus-und-tangens?gclid=CjwKCAiAvdCrBhBREiwAX6-6UrPBauxtFzaYCH2OYk9thou_Em8hFJp8fPoMB-xizwmEYPQSwh29NxoCV60QAvD_BwE


procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
  m: TMatrix;
  angele: single = 0;
  sc: single;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glBindVertexArray(VAO);

  UBOBuffer.modelMatrix.Identity;

  for i := 0 to JointCount do begin
    UBOBuffer.JointMatrix[i].Identity;
  end;

  m.Identity;

  for i := 0 to JointCount do begin
   // angele := sin((TimerCounter + i) / 100) / 80;
    angele := (-0.5 + random) / 1;

    //case i of
    //  0: begin
    //    angele := pi / 4;
    //  end;
    //  2: begin
    //    angele := -pi / 4;
    //  end;
    //  3: begin
    //    angele := pi / 8;
    //  end;
    //  4: begin
    //    angele := -pi / 8;
    //  end;
    //  5: begin
    //    angele := -pi / 8;
    //  end;
    //  6: begin
    //    angele := -pi / 8;
    //  end;
    //  else begin
    //    angele := 0;
    //  end;
    //end;

    UBOBuffer.JointMatrix[i] := m;

    UBOBuffer.JointMatrix[i].TranslateLocalspace(-JointsPos[i], 0.0, 0.0);
    UBOBuffer.JointMatrix[i].RotateC(angele);

    sc := 1 / cos(abs(angele));

    UBOBuffer.JointMatrix[i].Scale(sc, sc, sc);
    UBOBuffer.JointMatrix[i].TranslateLocalspace(JointsPos[i], 0.0, 0.0);

    m.TranslateLocalspace(-JointsPos[i], 0.0, 0.0);
    m.RotateC(angele * 2);
    m.TranslateLocalspace(JointsPos[i], 0.0, 0.0);

    //    m.Scale(1, 0.95, 1);
  end;

  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glBindVertexArray(VAO);
  glDrawArrays(GL_TRIANGLES, 0, QuadVertex.Count);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VAO);
  glDeleteBuffers(Length(Mesh_Buffers), Mesh_Buffers);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Inc(TimerCounter);
  ogcDrawScene(Sender);
end;

//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
