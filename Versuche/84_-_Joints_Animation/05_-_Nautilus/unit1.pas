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

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader;
    procedure CreateScene;
    procedure CreatJoints;
    procedure Draw;
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
  JointCount = 1;
  colors: array of PVector3f = (@vec3blue, @vec3green, @vec3cyan, @vec3red, @vec3magenta, @vec3yellow);


type
  TUBOBuffer = record
    ModelMatrix: TMatrix;
    JointMatrix: array [0..jointCount * 6 - 1] of Tmat4x4;
  end;

var
  UBOBuffer: TUBOBuffer;
  QuadVertex: TVectors2f = nil;
  QuadColor: TVectors3f = nil;
  QuadJoint: TJointIDs = nil;

type
  TVB = record
    VAO,
    VBOVektor, VBOColor, VBOJoint: GLuint;
  end;

var
  VBQuad: TVB;
  UBO_ID, UBO: GLint;

  { TJointIDsHelper }

procedure TJointIDsHelper.AddQuad(pri, sek: integer);
begin
  Self += [sek, pri, pri, sek, pri, sek];
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 640;
  Height := 480;
  //remove-
  Randomize;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  Timer1.Enabled := True;
end;

procedure TForm1.CreatJoints;
var
  i: integer;
  center: TVector3f;
  v: TVector4f;
  m: Tmat4x4;
begin
  center := [-0.1, 0, 0];
  for i := 0 to JointCount - 1 do begin
    UBOBuffer.JointMatrix[i].Identity;

    //m.Identity;
    //m.TranslateLocalspace(-center);
    //m.RotateC((0.5 - Random) / 3);
    //m.TranslateLocalspace(center);
    //
    //if i = 0 then  begin
    //  UBOBuffer.JointMatrix[i] := m;
    //end else begin
    //  UBOBuffer.JointMatrix[i] := UBOBuffer.JointMatrix[i - 1] * m;
    //end;
    //center.x := center.x + 0.1;
    //
    //center := (m * vec4(center, 1)).xyz;
    ////   WriteLn(center.x:10:5,' - ',center.y:10:5);

  end;
  WriteLn();
end;

function pirad(a: single): single;
begin
  Result := a / 180 * pi;
end;

// https://www.youtube.com/watch?app=desktop&v=lDaQ3a43x8A

function rotateVector(v, ofs: TVector2f; a: TGLfloat): TVector2f;
begin
  Result.x := v.x * cos(a) - v.y * sin(a) + ofs.x;
  Result.y := v.x * sin(a) + v.y * cos(a) + ofs.y;
end;

procedure Test;
var
  p, p1: TVector2f;
begin
  p := [4, 2];

  //  p1.x := p.x * cos(pirad) - p.y * sin(pirad) + 5;
  //  p1.y := p.x * sin(pirad) + p.y * cos(pirad) + 1;

  p1 := rotateVector(p, [5, 1], pirad(50));

  WriteLn('x: ', p1.x: 4: 2, 'x: ', p1.y: 6: 2);

end;

procedure TForm1.CreateScene;
var
  tmpQuad: TVectors2f = nil;
  i: integer;
begin
  Test;

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  glGenBuffers(1, @UBO);
  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, UBO);

  UBOBuffer.ModelMatrix.Identity;
  CreatJoints;

  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  for i := 0 to JointCount - 1 do begin
    tmpQuad := nil;
    tmpQuad.addrectangle(1, 3);
    tmpQuad.Translate([-i-0.5, -1.5]);
    tmpQuad.Scale(0.1);

    QuadVertex.Add(tmpQuad);
    QuadColor.AddRectangleColor(colors[i mod Length(colors)]^);
    if i = 0 then  begin
      QuadJoint.AddQuad(-1, i);
    end else begin
      QuadJoint.AddQuad(i - 1, i);
    end;
  end;

  // Daten für Quadrat
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  // Vektor
  glGenBuffers(1, @VBQuad.VBOVektor);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOVektor);
  glBufferData(GL_ARRAY_BUFFER, QuadVertex.Size, QuadVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // Color
  glGenBuffers(1, @VBQuad.VBOColor);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOColor);
  glBufferData(GL_ARRAY_BUFFER, QuadColor.Size, QuadColor.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // Joints
  glGenBuffers(1, @VBQuad.VBOJoint);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOJoint);
  glBufferData(GL_ARRAY_BUFFER, QuadJoint.Size, QuadJoint.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribIPointer(2, 1, GL_INT, 0, nil);
end;

procedure TForm1.Draw;
begin
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);

  // Zeichne Quadrat
  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, QuadVertex.Count);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: Integer;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  UBOBuffer.ModelMatrix.Identity;
  //  UBOBuffer.ModelMatrix.TranslateX(0.8);
  //UBOBuffer.ModelMatrix.Scale(0.5);

  for i := 0 to 150 do begin
    Draw;

    UBOBuffer.ModelMatrix.TranslateLocalspaceX(-0.1);
    UBOBuffer.ModelMatrix.RotateC(pi/8);
    UBOBuffer.ModelMatrix.TranslateLocalspaceX(-0.1);

    UBOBuffer.ModelMatrix.Scale(0.95);

  end;

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVektor);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  CreatJoints;
  Draw;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ogcDrawScene(Sender);
end;
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Fragment-Shader:</b>
*)
//includeglsl Fragmentshader.glsl

end.
