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
  JointCount = 12;

type
  TUBOBuffer = record
    proMatrix,
    modelMatrix: TMatrix;
  end;

var
  UBOBuffer: TUBOBuffer;
  QuadVertex: TVectors2f;
  QuadColor: TVectors3f;
  JointsPos: array of single;

  VAO: GLuint;
  Mesh_Buffers: array [(mbVBOVektor, mbVBOColor, mbUBO)] of TGLuint;

  TimerCounter: integer = 0;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 640;
  //  Height := 480;
  Height := 640;
  //remove-
  Randomize;
  Timer1.Enabled := False;
  Timer1.Interval := 20;
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

  JointsPos := [0];
  LenGlobal := 0;

  for i := 0 to JointCount - 1 do begin
    LenCube := (0.5 + Random) * 8;

    tmpQuad := nil;
    tmpQuad.addrectangle;
    tmpQuad.Scale([LenCube, 7]);
    tmpQuad.Translate([-LenGlobal - (LenCube / 2), 0.0]);
    QuadVertex.Add(tmpQuad);

    LenGlobal += LenCube;
    JointsPos += [LenGlobal];

    QuadColor.AddRectangleColor(colors[i mod Length(colors)]^);
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
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

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

  Timer1.Enabled := True;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
  bone: TMatrix;
  r: single;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;
  glBindVertexArray(VAO);

  UBOBuffer.modelMatrix.Identity;
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_TRIANGLES, 0, 6);

  for i := 0 to JointCount - 1 do begin
    r := sin(TimerCounter * i / 200) / 2;
    bone.Identity;
    bone.TranslateLocalspaceX(-JointsPos[i]);
    bone.RotateC(r);
    bone.TranslateLocalspaceX(JointsPos[i]);

    UBOBuffer.modelMatrix := UBOBuffer.modelMatrix * bone;
    glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
    glDrawArrays(GL_TRIANGLES, i * 6, 6);
  end;

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
