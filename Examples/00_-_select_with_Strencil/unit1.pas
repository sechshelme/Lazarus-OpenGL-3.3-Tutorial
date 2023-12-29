unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix;

  //image image.png
  //lineal

type

  { TForm1 }

  TForm1 = class(TForm)
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
    procedure CalcCubePos;
    procedure ogcDrawScene(Sender: TObject);
    procedure ogcMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ogcResize(Sender: TObject);

    procedure CalcCube;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  CubeCount = 20;

type
  TUBOBuffer = record
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
    CubeEnabled: TGLint;
  end;

var
  UBOBuffer: TUBOBuffer;

  CubeVertex, CubeNormal: TVectors3f;
  CubeTexCoors: TVectors2f;
  VAOs: array [(vaMesh)] of TGLuint;
  Mesh_Buffers: array [(mbVBOVektor, mbVBOTexCoord, mbVBONormal, mbUBO)] of TGLuint;
  Textur_Buffers: array [(tbTexture)] of TGLuint;

  FrustumMatrix, WorldMatrix, ModelMatrix: TMatrix;

  CubePos: array[0..CubeCount - 1] of record
    Enabled: TGLint;
    pos: TVector3f;
    mat: Tmat4x4;
    end;

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
  ogc.OnResize := @ogcResize;
  ogc.OnMouseDown := @ogcMouseDown;

  CreateScene;
end;

procedure TForm1.CalcCubePos;

  function Rnd: single;
  const
    scale = 7;
  begin
    Result := (-0.5 + Random) * scale;
  end;

var
  i: integer;
begin
  for i := 0 to Length(CubePos) - 1 do begin
    CubePos[i].pos := [Rnd, Rnd, Rnd];
    CubePos[i].mat.Identity;
    CubePos[i].Enabled := 0;
  end;
end;

procedure TForm1.CalcCube;
begin
  CubeVertex := nil;
  CubeTexCoors := nil;
  CubeNormal := nil;
  CubeVertex.AddCube;
  CubeTexCoors.AddCubeTexCoords;
  CubeTexCoors.scale([2, 3]);
  CubeNormal.AddCubeNormale;
end;

procedure TForm1.LoadTextures;
var
  pic: TPicture;
begin
  glGenTextures(Length(Textur_Buffers), Textur_Buffers);
  pic := TPicture.Create;
  pic.LoadFromFile('opengl.bmp');

  glBindTexture(GL_TEXTURE_2D, Textur_Buffers[tbTexture]);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, pic.Width, pic.Height, 0, GL_BGR, GL_UNSIGNED_BYTE, pic.Bitmap.RawImage.Data);

  pic.Free;
end;

procedure TForm1.CreateScene;
var
  UBOBuffer_ID: GLuint;
begin
  CalcCube;
  CalcCubePos;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -300.0);
  WorldMatrix.Scale(2.5);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);
  // Stencil
  glEnable(GL_STENCIL_TEST);

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  glClearColor(0.15, 0.15, 0.1, 1.0);


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

  LoadTextures;

  // --- Vertex-Daten für Cube
  glBindVertexArray(VAOs[vaMesh]);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOVektor]);
  glBufferData(GL_ARRAY_BUFFER, CubeVertex.Size, CubeVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // TexturCoords
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOTexCoord]);
  glBufferData(GL_ARRAY_BUFFER, CubeTexCoors.Size, CubeTexCoors.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 2, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBONormal]);
  glBufferData(GL_ARRAY_BUFFER, CubeNormal.Size, CubeNormal.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(2);
  glVertexAttribPointer(2, 3, GL_FLOAT, False, 0, nil);

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  i: integer;
  m: Tmat4x4;
begin

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  // Stencil
  glClearStencil(0);
  glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT or GL_STENCIL_BUFFER_BIT);

  Shader.UseProgram;

  glBindVertexArray(VAOs[vaMesh]);

  for i := 0 to Length(CubePos) - 1 do begin
    UBOBuffer.Matrix.ModelMatrix.Identity;
    UBOBuffer.Matrix.ModelMatrix.Scale(10);

    m.Identity;
    m.Translate(CubePos[i].pos);
    m := m * CubePos[i].mat;

    UBOBuffer.Matrix.ModelMatrix := ModelMatrix * UBOBuffer.Matrix.ModelMatrix * m;
    UBOBuffer.Matrix.Matrix := FrustumMatrix * WorldMatrix * UBOBuffer.Matrix.ModelMatrix;

    UBOBuffer.CubeEnabled := CubePos[i].Enabled;

    glBufferSubData(GL_UNIFORM_BUFFER, 0, SizeOf(TUBOBuffer), @UBOBuffer);

    // Stencil
    glStencilFunc(GL_ALWAYS, i + 1, 0);

    glDrawArrays(GL_TRIANGLES, 0, CubeVertex.Count);
  end;

  ogc.SwapBuffers;
end;

procedure TForm1.ogcMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  index: TGLint;
begin
  y := ClientHeight - y;

  glReadPixels(x, y, 1, 1, GL_STENCIL_INDEX, GL_UNSIGNED_INT, @index);

  if index > 0 then begin
    CubePos[index - 1].Enabled := not CubePos[index - 1].Enabled;
  end;
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
var
  i: integer;
begin
  ModelMatrix.RotateA(0.011);
  ModelMatrix.RotateB(0.013);
  for i := 0 to Length(CubePos) - 1 do begin
    CubePos[i].mat.RotateA(0.005 * i);
    CubePos[i].mat.RotateB(0.005 * (CubeCount - i));
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
