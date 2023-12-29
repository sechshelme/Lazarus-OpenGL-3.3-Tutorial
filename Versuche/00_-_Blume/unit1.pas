unit Unit1;

{$mode objfpc}{$H+}
{$modeswitch typehelpers on}
{$modeswitch arrayoperators on}
//{$modeswitch multihelpers}
{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix,
  BlumeDonut;

  //image image.png
  //lineal
type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcResize(Sender: TObject);

    procedure CalcSphere;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

// https://svn.freepascal.org/cgi-bin/viewvc.cgi/trunk/tests/webtbs/tw28927.pp?view=markup&pathrev=47892
// https://www.math.uni-leipzig.de/pool/tuts/FreePascal/ref/node6.html

//{$packrecords 16}
// {$align 32}

type
  TUBOBuffer = record
    Isinstance: TGLint;
    pad: TVector3f;
    Material: record
      ambient: TVector3f;      // Umgebungslicht
      pad0: GLfloat;           // padding 4Byte
      diffuse: TVector3f;      // Farbe
      pad1: GLfloat;           // padding 4Byte
      specular: TVector3f;     // Spiegelnd
      shininess: GLfloat;      // Glanz
      end;
    Matrix: record
      ModelMatrix: Tmat4x4;
      Matrix: Tmat4x4;
      end;
    Position: record
      v: array [0..29] of record
        p: TVector2f;
        pad: TVector2f;
        end;
      end;
  end;

var
  UBOBuffer: TUBOBuffer;

  RingVertex, RingNormal: TVectors3f;
  ArcVertex, ArcNormal: TDonut3f;

var
  Mesh_Buffers: array [(mbVBOVektor, mbVBONormal, mbVBORingVektor, mbVBORingNormal, mbUBO)] of TGLuint;
  VAOs: array [(VAOArc, VAORing)] of TGLuint;

  FrustumMatrix, WorldMatrix, ModelMatrix: TMatrix;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;   // neues Ereigniss

  CreateScene;
end;

procedure TForm1.CalcSphere;
const
  size = 0.866 / 2;

  BlumTab: array of TVector2f = (
    (-0.5, 2 * size), (0.0, 2 * size), (0.5, 2 * size),
    (-0.75, size), (-0.25, size), (0.25, size), (0.75, size),
    (-1.0, 0), (-0.5, 0), (0.0, 0), (0.5, 0), (1.0, 0),

    (-1.25, -size), (-0.75, -size), (-0.25, -size), (0.25, -size), (0.75, -size), (1.25, -size),

    (-1.0, -2 * size), (-0.5, -2 * size), (0.0, -2 * size), (0.5, -2 * size), (1.0, -2 * size),
    (-0.75, -3 * size), (-0.25, -3 * size), (0.25, -3 * size), (0.75, -3 * size),
    (-0.5, -4 * size), (0.0, -4 * size), (0.5, -4 * size));
var
  i: integer;
  m2: Tmat2x2;

begin
  for i := 0 to 5 do begin
    m2.Identity;
    m2.Rotate(pi / 3 * i);
    m2.WriteMatrix;
    WriteLn();
  end;
  WriteLn(Length(BlumTab));


  ArcVertex := nil;
  ArcNormal := nil;
  ArcVertex.AddDonut6(0.025);
  ArcVertex.RotateC(pi / 6);
  ArcNormal.AddDonut6Normale;
  ArcNormal.RotateC(pi / 6);

  RingVertex := nil;
  RingNormal := nil;
  RingVertex.AddDonut(0.0125);
  RingVertex.Scale(3);
  RingNormal.AddDonutNormale;

  for i := 0 to Length(BlumTab) - 1 do begin
    UBOBuffer.Position.v[i].p := BlumTab[i];
  end;
end;

procedure TForm1.CreateScene;
var
  UBOBuffer_ID: GLuint;
begin
  CalcSphere;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -300.0);
  WorldMatrix.Scale(2.5);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;
  UBOBuffer_ID := Shader.UniformBlockIndex('UBO');

  glGenVertexArrays(Length(VAOs), VAOs);
  glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  Timer1.Enabled := True;

  // UBO
  with UBOBuffer.Material do begin
    ambient := vec3(0.17, 0.01, 0.01);
    diffuse := vec3(0.61, 0.04, 0.04);
    specular := vec3(0.73, 0.63, 0.63);
    shininess := 76.8;
  end;

  glBindBuffer(GL_UNIFORM_BUFFER, Mesh_Buffers[mbUBO]);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  glUniformBlockBinding(Shader.ID, UBOBuffer_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, Mesh_Buffers[mbUBO]);

  glClearColor(0.15, 0.15, 0.1, 1.0);

  // --- Vertex-Daten für Bögen
  glBindVertexArray(VAOs[VAOArc]);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOVektor]);
  glBufferData(GL_ARRAY_BUFFER, ArcVertex.Size, ArcVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBONormal]);
  glBufferData(GL_ARRAY_BUFFER, ArcNormal.Size, ArcNormal.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

  // --- Vertex-Daten für Ring
  glBindVertexArray(VAOs[VAORing]);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBORingVektor]);
  glBufferData(GL_ARRAY_BUFFER, RingVertex.Size, RingVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBORingNormal]);
  glBufferData(GL_ARRAY_BUFFER, RingNormal.Size, RingNormal.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  scal: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  scal := 25;

  UBOBuffer.Matrix.ModelMatrix.Identity;
  UBOBuffer.Matrix.ModelMatrix.Scale(scal);
  UBOBuffer.Matrix.ModelMatrix := ModelMatrix * UBOBuffer.Matrix.ModelMatrix;

  UBOBuffer.Matrix.Matrix := FrustumMatrix * WorldMatrix * UBOBuffer.Matrix.ModelMatrix;
  UBOBuffer.Isinstance := 1;
  glBufferSubData(GL_UNIFORM_BUFFER, 0, SizeOf(TUBOBuffer), @UBOBuffer);

  glBindVertexArray(VAOs[VAOArc]);
  glDrawArraysInstanced(GL_TRIANGLES, 0, ArcVertex.Count, Length(UBOBuffer.Position.v) * 6);

  UBOBuffer.Isinstance := 0;
  glBufferSubData(GL_UNIFORM_BUFFER, 0, SizeOf(TGLint), @UBOBuffer.Isinstance);
  glBindVertexArray(VAOs[VAORing]);
  glDrawArraysInstanced(GL_TRIANGLES, 0, RingVertex.Count, 1);

  ogc.SwapBuffers;
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(Length(VAOs), VAOs);
  glDeleteBuffers(Length(Mesh_Buffers), Mesh_Buffers);
end;

procedure TForm1.MenuItemClick(Sender: TObject);
begin
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  counter: int64 = 100;
  cd = 20;
var
  si: single;
  clr, clg, clb: record
    ambient, diffuse: single;
      end;
begin
    ModelMatrix.RotateA((sin(counter / 105)+1)/100);
    ModelMatrix.RotateB((sin(counter / 314)+1)/100);

    Inc(counter);

  si := sin(counter / cd) / 2 + 0.5;
  clr.ambient := mix(0.01, 0.17, si);
  clr.diffuse := mix(0.04, 0.61, si);

  si := sin(counter / cd * 1.3) / 2 + 0.5;
  clg.ambient := mix(0.01, 0.17, si);
  clg.diffuse := mix(0.04, 0.61, si);

  si := sin(counter / cd * 1.7) / 2 + 0.5;
  clb.ambient := mix(0.01, 0.17, si);
  clb.diffuse := mix(0.04, 0.61, si);

  UBOBuffer.Material.ambient := [clr.ambient, clg.ambient, clb.ambient];
  UBOBuffer.Material.diffuse := [clr.diffuse, clg.diffuse, clb.diffuse];
  ogc.Invalidate;
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
