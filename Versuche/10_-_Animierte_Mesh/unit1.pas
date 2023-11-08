unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  dglOpenGL, oglDebug,
  oglContext, oglShader, oglVector, oglVectors, oglMatrix,
  CubeHelp;

  //image image.png
  //lineal

(*
Den Geometrie-Shader kann man auch gut verwenden um Normale für Beleuchtungen zu berechnen.
*)

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ogc: TContext;
    Shader: TShader; // Shader-Object
    procedure CreateScene;
    procedure ogcDrawScene(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TUBOBuffer = record
    WorldMatrix: Tmat4x4;
    ModelMatrix: Tmat4x4;
    moveF: Tmat2x2;
    p0: TVector4f;
    moveN: Tmat2x2;
    p1: TVector4f;
    moveB: Tmat2x2;
    p2: TVector4f;
    moveR: Tmat2x2;
    p3: TVector4f;
    moveT: Tmat2x2;
    p4: TVector4f;
    moveL: Tmat2x2;
  end;

var
  cube: TVectors3f = nil;
  cubeAni: TCubeAnimate = nil;

type
  TVB = record
    VAO,
    VBO, VBOAni: GLuint;
  end;

var
  VBQuad: TVB;
  UBOBuffer: TUBOBuffer;
  UBO,
  UBO_ID: GLint;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //remove+
  Width := 340;
  Height := 240;
  //remove-
  ogc := TContext.Create(Self);
  ogc.OnPaint := @ogcDrawScene;

  CreateScene;
end;

procedure TForm1.CreateScene;
var
  i: integer;
begin
  InitOpenGLDebug;

  Shader := TShader.Create;
  Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
  Shader.LoadShaderObjectFromFile(GL_GEOMETRY_SHADER, 'GeometrieShader.glsl');
  Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
  Shader.LinkProgramm;
  Shader.UseProgram;

  // --- UBO
  UBOBuffer.ModelMatrix.Identity;
  UBOBuffer.ModelMatrix.Scale(1.5);
  //  UBOBuffer.ModelMatrix.RotateC(pi / 2);
  //  UBOBuffer.ModelMatrix.RotateB(pi / 2);
  UBOBuffer.moveF.Identity;
  UBOBuffer.moveN.Identity;
  UBOBuffer.moveB.Identity;
  UBOBuffer.moveR.Identity;
  UBOBuffer.moveT.Identity;
  UBOBuffer.moveL.Identity;

  glGenBuffers(1, @UBO);
  // UBO mit Daten laden
  glBindBuffer(GL_UNIFORM_BUFFER, UBO);
  glBufferData(GL_UNIFORM_BUFFER, SizeOf(TUBOBuffer), nil, GL_DYNAMIC_DRAW);

  // UBO mit dem Shader verbinden
  UBO_ID := Shader.UniformBlockIndex('UBO');
  glUniformBlockBinding(Shader.ID, UBO_ID, 0);
  glBindBufferBase(GL_UNIFORM_BUFFER, 0, UBO);


  Timer1.Enabled := True;
  glEnable(GL_DEPTH_TEST);

  glEnable(GL_CULL_FACE);   // Überprüfung einschalten
  glCullFace(GL_BACK);      // Rückseite nicht zeichnen.

  glClearColor(0.6, 0.6, 0.4, 1.0);

  // --- Daten für den Würfel
  glGenVertexArrays(1, @VBQuad.VAO);
  glBindVertexArray(VBQuad.VAO);

  // center
  cube.AddCube(1.0, 1.0, 1.0);
  cubeAni.AddCube(caLeft, 0, 0);

  // far
  cube.AddCube(0.5, 0.5, 1.0, 0, 0, 1);
  cubeAni.AddCube(caFar, 0, 01);

  // far far
  cube.AddCube(0.5, 0.5, 1.0, 0, 0, 2);
  cubeAni.AddCube(caFar, 1, 1);

  // near
  cube.AddCube(0.5, 0.5, 1.0, 0, 0, -1);
  cubeAni.AddCube(caNear, 0, 11);

  // near near
  cube.AddCube(0.5, 0.5, 1.0, 0, 0, -2);
  cubeAni.AddCube(caNear, 11, 11);

  // bottom
  cube.AddCube(0.5, 1.0, 0.5, 0, -1, 0);
  cubeAni.AddCube(caBottom, 0, 21);

  // bottom bottom
  cube.AddCube(0.5, 1.0, 0.5, 0, -2, 0);
  cubeAni.AddCube(caBottom, 21, 21);

  // right
  cube.AddCube(1.0, 0.5, 0.5, 1, 0, 0);
  cubeAni.AddCube(caRight, 0, 31);

  // right right
  cube.AddCube(1.0, 0.5, 0.5, 2, 0, 0);
  cubeAni.AddCube(caRight, 31, 31);

  // top
  cube.AddCube(0.5, 1.0, 0.5, 0, 1, 0);
  cubeAni.AddCube(caTop, 0, 41);

  // top top
  cube.AddCube(0.5, 1.0, 0.5, 0, 2, 0);
  cubeAni.AddCube(caTop, 41, 41);

  // left
  cube.AddCube(1.0, 0.5, 0.5, -1, 0, 0);
  cubeAni.AddCube(caLeft, 0, 51);

  // left left
  cube.AddCube(1.0, 0.5, 0.5, -2, 0, 0);
  cubeAni.AddCube(caLeft, 51, 51);

  // Vektor
  glGenBuffers(1, @VBQuad.VBO);

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBO);
  glBufferData(GL_ARRAY_BUFFER, cube.Size, cube.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(0, 3, GL_FLOAT, False, 0, nil);

  // Animate

  glGenBuffers(1, @VBQuad.VBOAni);

  // https://stackoverflow.com/questions/28014864/why-do-different-variations-of-glvertexattribpointer-exist

  glBindBuffer(GL_ARRAY_BUFFER, VBQuad.VBOAni);
  glBufferData(GL_ARRAY_BUFFER, cubeAni.Size, cubeAni.Ptr, GL_STATIC_DRAW);
  glEnableVertexAttribArray(1);
  glVertexAttribIPointer(1, 1, GL_INT, 0, nil);
end;

procedure TForm1.ogcDrawScene(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  Shader.UseProgram;

  // Zeichne den Würfel
  glBufferSubData(GL_UNIFORM_BUFFER, 0, sizeof(TUBOBuffer), @UBOBuffer);

  glBindVertexArray(VBQuad.VAO);
  glDrawArrays(GL_TRIANGLES, 0, cube.Count);

  ogc.SwapBuffers;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shader.Free;

  glDeleteBuffers(1, @UBO);
  glDeleteVertexArrays(1, @VBQuad.VAO);
  glDeleteBuffers(1, @VBQuad.VBO);
end;

procedure TForm1.FormResize(Sender: TObject);
var
  perm, wm: Tmat4x4;
begin
  wm.Identity;
  wm.Translate(0, 0, -15);
  wm.RotateA(0.3);
  perm.Perspective(30, ClientWidth / ClientHeight, 0.1, 100.0);

  UBOBuffer.WorldMatrix := perm * wm;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  step = 0.02;

begin
  //  UBOBuffer.ModelMatrix.RotateB(0.12);
  UBOBuffer.moveF.Rotate(step*1.1);
  UBOBuffer.moveN.Rotate(step*1.2);
  UBOBuffer.moveT.Rotate(step*1.3);
  UBOBuffer.moveB.Rotate(step*1.4);
  UBOBuffer.moveR.Rotate(step*1.5);
  UBOBuffer.moveL.Rotate(step*1.6);

  ogcDrawScene(Sender);
end;

//lineal

(*
<b>Vertex-Shader:</b>
*)
//includeglsl Vertexshader.glsl
//lineal

(*
<b>Geometrie-Shader:</b>
*)
//includeglsl Geometrieshader.glsl
//lineal

(*
<b>Fragment-Shader</b>
*)
//includeglsl Fragmentshader.glsl

end.
