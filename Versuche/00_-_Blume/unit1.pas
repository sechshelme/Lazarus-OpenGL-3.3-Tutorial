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
  oglContext, oglShader, oglVector, oglVectors, oglMatrix;

  //image image.png
  //lineal
type
  TDonut3f = type TVectors3f;

  { TDonut3fHelper }

  TDonut3fHelper = type Helper(TVectors3fHelper) for TDonut3f
  public
    procedure AddDonut6(rd: single = 0.5);
    procedure AddDonut6Normale;
  end;


type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItemRotateCube: TMenuItem;
    MenuItemPlus: TMenuItem;
    MenuItemMinus: TMenuItem;
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

type
  TUBOBuffer = record
    Isinstance:TGLint;
    pad: TVector3f;           // padding 4Byte
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
VAOs:array [(  VAOArc, VAORing)]of TGLuint;

  FrustumMatrix, WorldMatrix, ModelMatrix: TMatrix;

  { TDonut3fHelper }

procedure TDonut3fHelper.AddDonut6(rd: single);
type
  quadVector = array[0..3] of TVector3f;

  procedure Quads(Vector: quadVector); inline;
  begin
    Self.Add([Vector[0], Vector[1], Vector[2], Vector[0], Vector[2], Vector[3]]);
  end;

var
  Donut: array of array of record
    x, y, z: single;
    end;
  i, j: integer;
  pi2sek, x1, y1, y2: single;
begin
  SetLength(Donut, Sektoren + 1, Sektoren + 1);

  pi2sek := Pi * 2 / Sektoren;

  for i := 0 to Sektoren do begin
    x1 := sin(i * pi2sek) * 0.5;
    y1 := cos(i * pi2sek) * 0.5;
    for j := 0 to Sektoren do begin
      y2 := cos(j * pi2sek) * rd;
      Donut[i, j].z := sin(j * pi2sek) * rd;
      Donut[i, j].x := (x1 + sin(i * pi2sek) * y2);
      Donut[i, j].y := (y1 + cos(i * pi2sek) * y2);
    end;
  end;

  for i := 0 to Sektoren div 6 - 1 do begin
    for j := 0 to Sektoren - 1 do begin
      Quads([
        [Donut[i + 0, j + 0].x, Donut[i + 0, j + 0].y, Donut[i + 0, j + 0].z],
        [Donut[i + 0, j + 1].x, Donut[i + 0, j + 1].y, Donut[i + 0, j + 1].z],
        [Donut[i + 1, j + 1].x, Donut[i + 1, j + 1].y, Donut[i + 1, j + 1].z],
        [Donut[i + 1, j + 0].x, Donut[i + 1, j + 0].y, Donut[i + 1, j + 0].z]]);
    end;
  end;
end;

procedure TDonut3fHelper.AddDonut6Normale;
type
  quadVector = array[0..3] of TVector3f;

  procedure Quads(Vector: quadVector); inline;
  begin
    Self.Add([Vector[0], Vector[1], Vector[2], Vector[0], Vector[2], Vector[3]]);
  end;

var
  Donut: array of array of record
    x, y, z: single;
    end;
  i, j: integer;
  pi2sek,  y2: single;
begin
  SetLength(Donut, Sektoren + 1, Sektoren + 1);

  pi2sek := Pi * 2 / Sektoren;

  for i := 0 to Sektoren do begin
    for j := 0 to Sektoren do begin
      y2 := cos(j * pi2sek) * 1;
      Donut[i, j].z := sin(j * pi2sek) * 1;
      Donut[i, j].x :=  + sin(i * pi2sek) * y2;
      Donut[i, j].y :=  + cos(i * pi2sek) * y2;
    end;
  end;

  for i := 0 to Sektoren div 6 - 1 do begin
    for j := 0 to Sektoren - 1 do begin
      Quads([
        [Donut[i + 0, j + 0].x, Donut[i + 0, j + 0].y, Donut[i + 0, j + 0].z],
        [Donut[i + 0, j + 1].x, Donut[i + 0, j + 1].y, Donut[i + 0, j + 1].z],
        [Donut[i + 1, j + 1].x, Donut[i + 1, j + 1].y, Donut[i + 1, j + 1].z],
        [Donut[i + 1, j + 0].x, Donut[i + 1, j + 0].y, Donut[i + 1, j + 0].z]]);
    end;
  end;

end;

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
    m2.Rotate(pi/3*i);
    m2.WriteMatrix;
    WriteLn();
  end;
  WriteLn(Length(BlumTab));


  ArcVertex := nil;
  ArcNormal := nil;
  ArcVertex.AddDonut6(0.025);
  ArcVertex.RotateC(pi/6);
  ArcNormal.AddDonut6Normale;
  ArcNormal.RotateC(pi/6);

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
  Shader.LinkProgramm;
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
  UBOBuffer.Isinstance:=1;
  glBufferSubData(GL_UNIFORM_BUFFER, 0, SizeOf(TUBOBuffer), @UBOBuffer);

  glBindVertexArray(VAOs[VAOArc]);
  glDrawArraysInstanced(GL_TRIANGLES, 0, ArcVertex.Count, Length(UBOBuffer.Position.v) * 6);

  UBOBuffer.Isinstance:=0;
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
begin
  if MenuItemRotateCube.Checked then begin
    ModelMatrix.RotateA(0.0123);  // Drehe um X-Achse
    ModelMatrix.RotateB(0.0234);  // Drehe um Y-Achse
  end;

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
