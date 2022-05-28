unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, dglOpenGL, oglShader;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    uiVBO: array[0..1] of GLint;
    uiVAO: array[0..0] of GLint;

    pos_id, col_id: GLint;
    Matrix_id: GLint;


    procedure InitScene;
    procedure RenderScene;
  public
    Shader: TShader;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

type
  TVertex3f = array[0..2] of GLfloat;
  TFace = array[0..2] of TVertex3f;

  TMatrix = array[0..3, 0..3] of GLfloat;

  TCube = array[0..11] of TFace;

var
  FrustumMatrix: TMatrix;

const
  EinheitsMatrix: TMatrix = ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));

  Matrix: TMatrix =
    ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));
  CameraMatrix: TMatrix =
    ((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 1.0));

  Cube: TCube =
    (((-0.2, -0.2, -0.2), (-0.2, -0.2, 0.2), (-0.2, 0.2, 0.2)), ((0.2, 0.2, -0.2), (-0.2, -0.2, -0.2), (-0.2, 0.2, -0.2)),
    ((0.2, -0.2, 0.2), (-0.2, -0.2, -0.2), (0.2, -0.2, -0.2)), ((0.2, 0.2, -0.2), (0.2, -0.2, -0.2), (-0.2, -0.2, -0.2)),
    ((-0.2, -0.2, -0.2), (-0.2, 0.2, 0.2), (-0.2, 0.2, -0.2)), ((0.2, -0.2, 0.2), (-0.2, -0.2, 0.2), (-0.2, -0.2, -0.2)),
    ((-0.2, 0.2, 0.2), (-0.2, -0.2, 0.2), (0.2, -0.2, 0.2)), ((0.2, 0.2, 0.2), (0.2, -0.2, -0.2), (0.2, 0.2, -0.2)),
    ((0.2, -0.2, -0.2), (0.2, 0.2, 0.2), (0.2, -0.2, 0.2)), ((0.2, 0.2, 0.2), (0.2, 0.2, -0.2), (-0.2, 0.2, -0.2)),
    ((0.2, 0.2, 0.2), (-0.2, 0.2, -0.2), (-0.2, 0.2, 0.2)), ((0.2, 0.2, 0.2), (-0.2, 0.2, 0.2), (0.2, -0.2, 0.2)));
  CubeColor: TCube =
    (((0.0, 0.0, 0.0), (0.0, 0.0, 1.0), (0.0, 1.0, 1.0)), ((1.0, 1.0, 0.0), (0.0, 0.0, 0.0), (0.0, 1.0, 0.0)),
    ((1.0, 0.0, 1.0), (0.0, 0.0, 0.0), (1.0, 0.0, 0.0)), ((1.0, 1.0, 0.0), (1.0, 0.0, 0.0), (0.0, 0.0, 0.0)),
    ((0.0, 0.0, 0.0), (0.0, 1.0, 1.0), (0.0, 1.0, 0.0)), ((1.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 0.0)),
    ((0.0, 1.0, 1.0), (0.0, 0.0, 1.0), (1.0, 0.0, 1.0)), ((1.0, 1.0, 1.0), (1.0, 0.0, 0.0), (1.0, 1.0, 0.0)),
    ((1.0, 0.0, 0.0), (1.0, 1.0, 1.0), (1.0, 0.0, 1.0)), ((1.0, 1.0, 1.0), (1.0, 1.0, 0.0), (0.0, 1.0, 0.0)),
    ((1.0, 1.0, 1.0), (0.0, 1.0, 0.0), (0.0, 1.0, 1.0)), ((1.0, 1.0, 1.0), (0.0, 1.0, 1.0), (1.0, 0.0, 1.0)));

operator * (const m1, m2: TMatrix) res: TMatrix;
var
  i, j, k: integer;
begin
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      Res[i, j] := 0;
      for k := 0 to 3 do begin
        Res[i, j] := Res[i, j] + m2[i, k] * m1[k, j];
      end;
    end;
  end;
end;

procedure SetFrustum(left, right, bottom, top, znear, zfar: glFloat);
begin
  FrustumMatrix := EinheitsMatrix;
  FrustumMatrix[0, 0] := 2 * znear / (right - left);
  FrustumMatrix[1, 1] := 2 * znear / (top - bottom);
  FrustumMatrix[2, 0] := (right + left) / (right - left);
  FrustumMatrix[2, 1] := (top + bottom) / (top - bottom);
  FrustumMatrix[2, 2] := -(zfar + znear) / (zfar - znear);
  FrustumMatrix[2, 3] := -1;
  FrustumMatrix[3, 2] := -2 * zfar * znear / (zfar - znear);
  FrustumMatrix[3, 3] := 0;
end;

procedure Translate(var Matrix: TMatrix; x, y, z: GLfloat);
begin
  Matrix[3, 0] := Matrix[3, 0] + x;
  Matrix[3, 1] := Matrix[3, 1] + y;
  Matrix[3, 2] := Matrix[3, 2] + z;
end;

procedure Scale(var Matrix: TMatrix; Faktor: GLfloat);
var
  x, y: integer;
begin
  for x := 0 to 2 do begin
    for y := 0 to 2 do begin
      Matrix[x, y] := Matrix[x, y] * Faktor;
    end;
  end;
end;

procedure RotateX(var Matrix: TMatrix; Winkel: GLfloat);
var
  y, z: GLfloat;
  i: integer;
begin
  for i := 0 to 2 do begin
    y := Matrix[i, 1];
    z := Matrix[i, 2];
    Matrix[i, 1] := y * cos(Winkel) - z * sin(Winkel);
    Matrix[i, 2] := y * sin(Winkel) + z * cos(Winkel);
  end;
end;

procedure RotateY(var Matrix: TMatrix; Winkel: GLfloat);
var
  x, z: GLfloat;
  i: integer;
begin
  for i := 0 to 2 do begin
    x := Matrix[i, 0];
    z := Matrix[i, 2];
    Matrix[i, 0] := x * cos(Winkel) - z * sin(Winkel);
    Matrix[i, 2] := x * sin(Winkel) + z * cos(Winkel);
  end;
end;

procedure RotateZ(var Matrix: TMatrix; Winkel: GLfloat);
var
  x, y: GLfloat;
  i: integer;
begin
  for i := 0 to 2 do begin
    x := Matrix[i, 0];
    y := Matrix[i, 1];
    Matrix[i, 0] := x * cos(Winkel) - y * sin(Winkel);
    Matrix[i, 1] := x * sin(Winkel) + y * cos(Winkel);
  end;
end;

procedure TForm1.InitScene;
begin
  glClearColor(0.0, 0.5, 1.0, 1.0);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Shader := TShader.Create([FileToStr('Vertexshader.glsl'), FileToStr('Fragmentshader.glsl')]);
  with Shader do begin
    pos_id := AttribLocation('inPos');
    col_id := AttribLocation('inColor');

    Matrix_id := UniformLocation('Matrix');
  end;

  glGenVertexArrays(1, @uiVAO);
  glGenBuffers(2, @uiVBO);

  glBindVertexArray(uiVAO[0]);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[0]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(Cube), @Cube, GL_STATIC_DRAW);
  glEnableVertexAttribArray(pos_id);
  glVertexAttribPointer(pos_id, 3, GL_FLOAT, False, 0, nil);

  glBindBuffer(GL_ARRAY_BUFFER, uiVBO[1]);
  glBufferData(GL_ARRAY_BUFFER, sizeof(CubeColor), @CubeColor, GL_STATIC_DRAW);
  glEnableVertexAttribArray(col_id);
  glVertexAttribPointer(col_id, 3, GL_FLOAT, False, 0, nil);

  SetFrustum(-1.0, 1.0, -1.0, 1.0, 10, 70.0);

  Translate(CameraMatrix, 0, 0, -15);
  Scale(CameraMatrix, 0.5);
end;

procedure TForm1.RenderScene;
var
  x, y, z: integer;
  m: TMatrix;

begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);  // We just clear color

  glBindVertexArray(uiVAO[0]); // Würfel

  for x := -3 to 3 do begin
    for y := -3 to 3 do begin
      for z := -3 to 3 do begin
        Matrix := EinheitsMatrix;
        Translate(Matrix, x * 0.6, y * 0.6, z * 0.6);

        m := FrustumMatrix * CameraMatrix * Matrix;
        glUniformMatrix4fv(Matrix_id, 1, False, @m);
        glDrawArrays(GL_TRIANGLES, 0, Length(Cube) * 3);
      end;
    end;
  end;

  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  InitOpenGL;

  OpenGLControl1.MakeCurrent;

  ReadExtensions;
  ReadImplementationProperties;

  InitScene;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteBuffers(2, @uiVBO);
  glDeleteBuffers(1, @uiVAO);
  Shader.Free;
end;


procedure TForm1.FormPaint(Sender: TObject);
begin
  RenderScene;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
  RenderScene;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RotateX(CameraMatrix, Pi / 640);
  RotateY(CameraMatrix, Pi / 1280);
  FormPaint(Sender);
end;


end.
