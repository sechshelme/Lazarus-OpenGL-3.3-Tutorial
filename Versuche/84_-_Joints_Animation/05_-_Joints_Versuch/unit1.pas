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

  { TForm1 }

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

type
  TUBOBuffer = record
    proMatrix,
    modelMatrix: TMatrix;
  end;

var
  UBOBuffer: TUBOBuffer;
  QuadVertex: TVectors2f;
  QuadColor: TVectors3f;

var
  VAO, VBOVektor, VBOColor, UBO: GLint;
  TimerCounter: integer = 0;

const
  JointCount = 8;

var
  JointsPos: array of single;


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
  l: single;
begin
  QuadVertex := nil;
  QuadColor := nil;

  JointsPos := nil;
  //  JointsPos += [0.0];

  l := 8;

//    JointsPos:=[0,8,16,24,32,40,48,56];

  for i := 0 to JointCount - 1 do begin
    //if i = 0 then begin
    //  l := 8;
    //end else begin
    //  l := (0.5 + Random) * 8;
    ////  l := 8;
    //end;
    l := 8;

    tmpQuad := nil;
    tmpQuad.addrectangle;
    tmpQuad.Scale([l, 4]);
    tmpQuad.Translate([-l * i, 0.0]);
    QuadVertex.Add(tmpQuad);

//    JointsPos +=[i* 8];

    if i = 0 then  begin
      JointsPos +=[ 0];
    end else begin
      JointsPos += [(JointsPos[i - 1]) + l];
    end;
    //

    WriteLn(JointsPos[i]: 10: 5);


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
  glGenBuffers(1, @VBOVektor);
  glBindBuffer(GL_ARRAY_BUFFER, VBOVektor);
  glBufferData(GL_ARRAY_BUFFER, QuadVertex.Size, QuadVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 2, GL_FLOAT, False, 0, nil);

  // Color
  glGenBuffers(1, @VBOColor);
  glBindBuffer(GL_ARRAY_BUFFER, VBOColor);
  glBufferData(GL_ARRAY_BUFFER, QuadColor.Size, QuadColor.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  Timer1.Enabled := True;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
  Hand: TMatrix;
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
    Hand.Identity;
    Hand.TranslateLocalspaceX(-JointsPos[i] + 4);
    Hand.RotateC(r);
    Hand.TranslateLocalspaceX(JointsPos[i] - 4);
    //Hand.TranslateLocalspaceX(-i * 8 + 4);
    //Hand.RotateC(r);
    //Hand.TranslateLocalspaceX(i * 8 - 4);

//    WriteLn(JointsPos[i]: 10: 5);
//    WriteLn('--- ', single(i * 8 + 4): 10: 5);



    UBOBuffer.modelMatrix := UBOBuffer.modelMatrix * Hand;
    glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);
    glDrawArrays(GL_TRIANGLES, i * 6, 6);
  end;

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VAO);
  glDeleteBuffers(1, @VBOVektor);
  glDeleteBuffers(1, @VBOColor);
  glDeleteBuffers(1, @UBO);
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
