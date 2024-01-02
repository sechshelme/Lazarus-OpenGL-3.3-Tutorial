unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Math,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix;

  //image image.png
  //lineal

type
  TTextureBuffer = record
    Width, Height: integer;
    Data: array of byte;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItemMinus: TMenuItem;
    MenuItemPlus: TMenuItem;
    MenuItemRotateCube: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader Klasse
    procedure LoadTextures;
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcResize(Sender: TObject);

    function CalcTexture: TTextureBuffer;
    procedure CalcSphere;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TUBOBuffer = record
    Matrix: record
      Matrix: Tmat4x4;
      end;
  end;

var
  UBOBuffer: TUBOBuffer;

  RectangleVertex: TVectors3f;
  CubeSize: integer;

  VAOs: array [(vaMesh)] of TGLuint;
  Mesh_Buffers: array [(mbVBOVektor, mbUBO)] of TGLuint;
  Textur_Buffers: array [(tbTexture)] of TGLuint;

  FrustumMatrix, WorldMatrix, ModelMatrix: TMatrix;

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  Randomize;
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;   // neues Ereigniss

  CreateScene;
end;

procedure TForm1.CalcSphere;
const
  tileCount = 200;
var
  x, y: integer;
begin
  RectangleVertex := nil;
  for x := 0 to tileCount - 0 do begin
    for y := 0 to tileCount - 1 do begin
      RectangleVertex.Add([x, y, 0]);
      RectangleVertex.Add([x, y + 1, 0]);

      RectangleVertex.Add([y, x, 0]);
      RectangleVertex.Add([y + 1, x, 0]);
    end;
  end;
  RectangleVertex.translate([-tileCount / 2, -tileCount / 2, 0]);
  RectangleVertex.scale(1 / tileCount);
end;

function TForm1.CalcTexture: TTextureBuffer;
const
  N = 256;
var
  i, j: integer;
  x, y, d, z: TGlfloat;
begin
  Result.Width := N;
  Result.Height := N;
  SetLength(Result.Data, Result.Width * Result.Height);
  for i := 0 to Result.Width - 1 do begin
    for j := 0 to Result.Height - 1 do begin
      x := (i - N / 2) / (N / 2);
      y := (j - N / 2) / (N / 2);

      d := Hypot(x, y) * 4;
      z := (1 - d * d) * Exp(d * d / -2);

      Result.Data[i + j * Result.Width] := Trunc(z * 127 + 128);
    end;
  end;
end;

procedure TForm1.LoadTextures;
var
  textur: TTextureBuffer;
begin
  glGenTextures(Length(Textur_Buffers), Textur_Buffers);
  textur := CalcTexture;

  glBindTexture(GL_TEXTURE_2D, Textur_Buffers[tbTexture]);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RED, textur.Width, textur.Height, 0, GL_RED, GL_UNSIGNED_BYTE, PGLvoid(textur.Data));
end;

procedure TForm1.CreateScene;
var
  UBOBuffer_ID: GLuint;
begin
  CalcSphere;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -300.0);
  WorldMatrix.Scale(150);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgram;
  Shader.UseProgram;

  glUniform1i(Shader.UniformLocation('Texture'), 0);
  UBOBuffer_ID := Shader.UniformBlockIndex('UBO');

  glGenVertexArrays(Length(VAOs), VAOs);
  glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  Timer1.Enabled := True;

  // UBO
  glBindBuffer(GL_UNIFORM_BUFFER, Mesh_Buffers[mbUBO]);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  glUniformBlockBinding(Shader.ID, UBOBuffer_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, Mesh_Buffers[mbUBO]);

  glClearColor(0.15, 0.15, 0.1, 1.0);

  LoadTextures;

  // --- Vertex-Daten für Kugel
  glBindVertexArray(VAOs[vaMesh]);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOVektor]);
  glBufferData(GL_ARRAY_BUFFER, RectangleVertex.Size, RectangleVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VAOs[vaMesh]);

  UBOBuffer.Matrix.Matrix := FrustumMatrix * WorldMatrix * ModelMatrix;
  glBufferSubData(GL_UNIFORM_BUFFER, 0, SizeOf(TUBOBuffer), @UBOBuffer);
  glDrawArrays(GL_LINES, 0, RectangleVertex.Count);

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
  if Sender = MenuItemPlus then begin
    Inc(CubeSize);
  end else if Sender = MenuItemMinus then begin
    if CubeSize > 0 then begin
      Dec(CubeSize);
    end;
  end;
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
