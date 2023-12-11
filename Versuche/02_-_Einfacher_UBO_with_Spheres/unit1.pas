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
    size: TGLint;
  end;

var
  UBOBuffer: TUBOBuffer;

  SphereVertex, SphereNormal: TVectors3f;
  CubeSize: integer;

var
  Mesh_Buffers: array [(mbVBOVektor, mbVBONormal, mbUBO)] of TGLuint;
  VAO: GLuint;

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
begin
  SphereVertex := nil;
  SphereNormal := nil;
  SphereVertex.AddSphere;
  SphereNormal.AddSphereNormale;
end;

procedure TForm1.CreateScene;
var
  UBOBuffer_ID: GLuint;
begin
  CalcSphere;

  CubeSize := 4;

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

  glGenVertexArrays(1, @VAO);
  glGenBuffers(Length(Mesh_Buffers), Mesh_Buffers);

  Timer1.Enabled := True;

  // UBO
  with UBOBuffer.Material do begin
    ambient := vec3(0.17, 0.01, 0.01);
    diffuse := vec3(0.61, 0.04, 0.04);
    specular := vec3(0.73, 0.63, 0.63);
    shininess := 76.8;
  end;
  UBOBuffer.size := 9;

  glBindBuffer(GL_UNIFORM_BUFFER, Mesh_Buffers[mbUBO]);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  glUniformBlockBinding(Shader.ID, UBOBuffer_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, Mesh_Buffers[mbUBO]);

  glClearColor(0.15, 0.15, 0.1, 1.0);

  // --- Vertex-Daten für Kugel
  glBindVertexArray(VAO);

  // Vektor
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBOVektor]);
  glBufferData(GL_ARRAY_BUFFER, SphereVertex.Size, SphereVertex.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Normale
  glBindBuffer(GL_ARRAY_BUFFER, Mesh_Buffers[mbVBONormal]);
  glBufferData(GL_ARRAY_BUFFER, SphereNormal.Size, SphereNormal.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(1, 3, GL_FLOAT, False, 0, nil);

end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  scal, d: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VAO);

  d := (7 / (CubeSize * 2 + 1)) * 8;

  if CubeSize > 1 then begin
    scal := 80 / (CubeSize * 2 + 1);
  end else begin
    scal := 40;
  end;

  UBOBuffer.size := CubeSize;

  UBOBuffer.Matrix.ModelMatrix.Identity;
  UBOBuffer.Matrix.ModelMatrix.Scale(scal);
  UBOBuffer.Matrix.ModelMatrix := ModelMatrix * UBOBuffer.Matrix.ModelMatrix;

  UBOBuffer.Matrix.Matrix := FrustumMatrix * WorldMatrix * UBOBuffer.Matrix.ModelMatrix;
  glBufferSubData(GL_UNIFORM_BUFFER, 0, SizeOf(TUBOBuffer), @UBOBuffer);
  glDrawArraysInstanced(GL_TRIANGLES, 0, SphereVertex.Count, CubeSize * CubeSize * CubeSize);

  ogc.SwapBuffers;
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VAO);
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
