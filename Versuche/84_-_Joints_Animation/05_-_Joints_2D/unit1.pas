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
  JointCount = 20;
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
  Width := 340;
  Height := 240;
  //remove-
  Randomize;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
  Timer1.Enabled := True;
end;

procedure TForm1.CreateScene;
var
  tmpQuad: TVectors2f = nil;
  i: integer;
begin
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
  for i := 0 to JointCount - 1 do begin
    UBOBuffer.JointMatrix[i].Identity;
//    UBOBuffer.JointMatrix[i].TranslateY((0.5 - Random) / 5);
UBOBuffer.JointMatrix[i].RotateC(Random / 3);

    if i > 0 then  begin
      UBOBuffer.JointMatrix[i] *= UBOBuffer.JointMatrix[i - 1];
    end;
  end;


  glClearColor(0.6, 0.6, 0.4, 1.0); // Hintergrundfarbe

  for i := 0 to JointCount - 1 do begin
    tmpQuad := nil;
    tmpQuad.addrectangle(1, 1);
    tmpQuad.Translate([-i, 0]);
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
begin
  glClear(GL_COLOR_BUFFER_BIT);
  Shader.UseProgram;

  UBOBuffer.ModelMatrix.Identity;
  Draw;

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;

  Shader.Free;

  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBOVektor);
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
