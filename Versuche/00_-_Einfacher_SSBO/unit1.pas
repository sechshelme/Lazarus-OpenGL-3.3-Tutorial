unit Unit1;

{$mode objfpc}{$H+}
{$ModeSwitch arrayoperators}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Menus,
  dglOpenGL,
  oglContext, oglShader, oglVector, oglMatrix, oglDebug;

  //image image.png
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
    Shader: TShader;
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
  TSSBOBuffer = record
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
  end;

var
  SSBOBuffer: TSSBOBuffer;

  SphereVertex, SphereNormal: array of Tmat3x3;
  CubeSize: integer;

type
  TVB = record
    VAO,
    VBO: GLuint;
  end;

var
  SSBO: GLuint;
  VBCube: TVB;

  FrustumMatrix,
  WorldMatrix,
  ModelMatrix: TMatrix;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;
  ogc.OnResize := @ogcResize;

  CreateScene;
  InitOpenGLDebug;
end;

procedure TForm1.CalcSphere;

  procedure Quads(Vector0, Vector1, Vector2, Vector3: TVector3f);
  begin
    SphereVertex += [Tmat3x3([Vector0, Vector1, Vector2]), Tmat3x3([Vector0, Vector2, Vector3])];

    Vector0.Normalize;
    Vector1.Normalize;
    Vector2.Normalize;
    Vector3.Normalize;

    SphereNormal += [Tmat3x3([Vector0, Vector1, Vector2]), Tmat3x3([Vector0, Vector2, Vector3])];
  end;

const
  Sektoren = 36;
var
  i, j: integer;
  t, rk: single;

  Tab: array of array of record
    a, b, c: single;
    end
  = nil;

begin
  t := 2 * pi / Sektoren;
  SetLength(Tab, Sektoren + 1, Sektoren div 2 + 1);
  for j := 0 to Sektoren div 2 do begin
    rk := sin(t * j);
    for i := 0 to Sektoren do begin
      with Tab[i, j] do begin
        a := sin(t * i) * rk;
        b := cos(t * i) * rk;
        c := cos(t * j);
      end;
    end;
  end;

  for j := 0 to Sektoren div 2 - 1 do begin
    for i := 0 to Sektoren - 1 do begin
      Quads(
        vec3(Tab[i + 0, j + 1].a, Tab[i + 0, j + 1].c, Tab[i + 0, j + 1].b),
        vec3(Tab[i + 1, j + 1].a, Tab[i + 1, j + 1].c, Tab[i + 1, j + 1].b),
        vec3(Tab[i + 1, j + 0].a, Tab[i + 1, j + 0].c, Tab[i + 1, j + 0].b),
        vec3(Tab[i + 0, j + 0].a, Tab[i + 0, j + 0].c, Tab[i + 0, j + 0].b));
    end;
  end;
  SetLength(Tab, 0, 0);
end;

procedure TForm1.CreateScene;
begin
  CalcSphere;

  CubeSize := 4;

  WorldMatrix.Identity;
  WorldMatrix.Translate(0, 0, -300.0);
  WorldMatrix.Scale(2.5);

  ModelMatrix.Identity;

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  // --- Shader laden
  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  // Material-Werte inizialisieren
  with SSBOBuffer.Material do begin
    ambient := vec3(0.17, 0.01, 0.01);
    diffuse := vec3(0.61, 0.04, 0.04);
    specular := vec3(0.73, 0.63, 0.63);
    shininess := 76.8;
  end;

  // SSBO mit Buffer reservieren
  glGenBuffers(1, @SSBO);
  glBindBuffer(GL_SHADER_STORAGE_BUFFER, SSBO);
  glBufferData(GL_SHADER_STORAGE_BUFFER, SizeOf(SSBOBuffer), nil, GL_DYNAMIC_DRAW);

  // SSBO mit dem Shader verbinden
  glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 3, SSBO);

  glBindBuffer(GL_SHADER_STORAGE_BUFFER, 0);
  //code-

  glClearColor(0.15, 0.15, 0.1, 1.0);

  // --- Vertex-Daten für Kugel

  glCreateBuffers(1, @VBCube.VBO);
  glNamedBufferData(VBCube.VBO, Length(SphereVertex) * SizeOf(Tmat3x3) * 2, nil, GL_STATIC_DRAW);
  glNamedBufferSubData(VBCube.VBO, 0, Length(SphereVertex) * SizeOf(Tmat3x3), PGLvoid(SphereVertex));
  glNamedBufferSubData(VBCube.VBO, Length(SphereVertex) * SizeOf(Tmat3x3), Length(SphereNormal) * SizeOf(Tmat3x3), PGLvoid(SphereNormal));

  glGenVertexArrays(1, @VBCube.VAO);
  glBindVertexArray(VBCube.VAO);

  glVertexAttribBinding(0, 10);
  glVertexAttribFormat(0, 3, GL_FLOAT, GL_FALSE, 0);
  glEnableVertexAttribArray(0);

  glVertexAttribBinding(1, 10);
  glVertexAttribFormat(1, 3, GL_FLOAT, GL_FALSE, Length(SphereVertex) * SizeOf(Tmat3x3));
  glEnableVertexAttribArray(1);

  glBindVertexBuffer(10, VBCube.VBO, 0, 12);

  Timer1.Enabled := True;
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
var
  x, y, z: integer;
  scal, d: single;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // Frame und Tiefen-Buffer löschen.

  glEnable(GL_CULL_FACE);
  glCullface(GL_BACK);

  Shader.UseProgram;

  glBindVertexArray(VBCube.VAO);

  // --- Konstruiere Kugeln

  d := (7 / (CubeSize * 2 + 1)) * 8;

  if CubeSize > 0 then begin
    scal := 20 / (CubeSize * 2 + 1);
  end else begin
    scal := 30;
  end;

  for x := -CubeSize to CubeSize do begin
    for y := -CubeSize to CubeSize do begin
      for z := -CubeSize to CubeSize do begin
        SSBOBuffer.Matrix.ModelMatrix.Identity;
        SSBOBuffer.Matrix.ModelMatrix.Translate(x * d, y * d, z * d);
        SSBOBuffer.Matrix.ModelMatrix.Scale(scal);
        SSBOBuffer.Matrix.ModelMatrix := ModelMatrix * SSBOBuffer.Matrix.ModelMatrix;

        SSBOBuffer.Matrix.Matrix := FrustumMatrix * WorldMatrix * SSBOBuffer.Matrix.ModelMatrix;

        glBindBuffer(GL_SHADER_STORAGE_BUFFER, SSBO);
        glBufferSubData(GL_SHADER_STORAGE_BUFFER, 0, SizeOf(SSBOBuffer), @SSBOBuffer);
        glDrawArrays(GL_TRIANGLES, 0, Length(SphereVertex) * 3);
      end;
    end;
  end;

  ogc.SwapBuffers;
end;

procedure TForm1.ogcResize(Sender: TObject);
begin
  FrustumMatrix.Perspective(45, ClientWidth / ClientHeight, 2.5, 1000.0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteVertexArrays(1, @VBCube.VAO);
  glDeleteBuffers(1, @VBCube.VBO);
  glDeleteBuffers(1, @SSBO);
end;

procedure TForm1.MenuItemClick(Sender: TObject);
begin
  if Sender = MenuItemPlus then begin
    if CubeSize < 7 then begin
      Inc(CubeSize);
    end;
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
