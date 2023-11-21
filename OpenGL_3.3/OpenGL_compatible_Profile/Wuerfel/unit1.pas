unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, dglOpenGL, Types, math;

type

  { TForm1 }


  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: integer);
    procedure OpenGLControl1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    MousePos: TPoint;
    MyMatrix: TMatrix4f;

    procedure DrawScene;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure Identity(var m: TMatrix4f);
const
  mi: TMatrix4f = ((1, 0, 0, 0), (0, 1, 0, 0), (0, 0, 1, 0), (0, 0, 0, 1));
begin
  m := mi;
end;

procedure RotateA(var m: TMatrix4f; Winkel: GLfloat);
var
  i: integer;
  y, z, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    y := m[i, 1];
    z := m[i, 2];
    m[i, 1] := y * c - z * s;
    m[i, 2] := y * s + z * c;
  end;
end;

procedure RotateB(var m: TMatrix4f; Winkel: GLfloat);
var
  i: integer;
  x, z, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    x := m[i, 0];
    z := m[i, 2];
    m[i, 0] := x * c - z * s;
    m[i, 2] := x * s + z * c;
  end;
end;


procedure RotateC(var m: TMatrix4f; Winkel: GLfloat);
var
  i: integer;
  x, y, c, s: GLfloat;
begin
  c := cos(Winkel);
  s := sin(Winkel);
  for i := 0 to 2 do begin
    x := m[i, 0];
    y := m[i, 1];
    m[i, 0] := x * c - y * s;
    m[i, 1] := x * s + y * c;
  end;
end;

procedure Translate(var m: TMatrix4f; x, y, z: GLfloat);
begin
  m[3, 0] := m[3, 0] + x;
  m[3, 1] := m[3, 1] + y;
  m[3, 2] := m[3, 2] + z;
end;

procedure Scale(var m: TMatrix4f; Faktor: GLfloat);
var
  x, y: integer;
begin
  for x := 0 to 2 do begin
    for y := 0 to 2 do begin
      m[x, y] *= Faktor;
    end;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  InitOpenGL;
  ReadExtensions;
  ReadImplementationProperties;
  OpenGLControl1.MakeCurrent;

  glClearColor(0.0, 0.5, 1.0, 1.0);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;

  Identity(MyMatrix);

  //  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  glMatrixMode(GL_PROJECTION);

  glLoadIdentity;
  gluPerspective(30.0, ClientWidth / ClientHeight, 0.10, 3000);

  glTranslatef(0, 0, -8);
  glViewport(0, 0, ClientWidth, ClientHeight);
end;

//procedure TForm1.OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState;
//  X, Y: integer);
//const
//  MoveStep = 1.0 / 100;
//  RotStep = 500;
//begin
//  if Shift = [ssLeft] then begin
//    Translate(MyMatrix, (X - MousePos.x) * MoveStep, -(Y - MousePos.y) * MoveStep, 0.0);
//  end;
//  if Shift = [ssRight] then begin
//    RotateB(MyMatrix, -(X - MousePos.x) / RotStep);
//    RotateA(MyMatrix, (Y - MousePos.y) / RotStep);
//  end;
//  if Shift = [ssMiddle] then begin
//    RotateC(MyMatrix, -(X - MousePos.x) / RotStep);
//  end;
//
//  MousePos.x := X;
//  MousePos.y := Y;
//end;


procedure TForm1.OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
const
  MoveStep = 1.0 / 100;
  RotStep = 100;
var
  phi1, phi2, dphi: Double;
  ctr: TPoint;
begin
  if Shift = [ssLeft] then begin
    Translate(MyMatrix, (X - MousePos.x) * MoveStep, -(Y - MousePos.y) * MoveStep, 0.0);
  end;
  if Shift = [ssRight] then begin
    RotateB(MyMatrix, -(X - MousePos.x) / RotStep);
    RotateA(MyMatrix, (Y - MousePos.y) / RotStep);
  end;
  if Shift = [ssMiddle] then begin
    ctr := Point(Width div 2, Height div 2);
    phi1 := arctan2(MousePos.Y - ctr.Y, MousePos.X - ctr.X);
    phi2 := arctan2(Y - ctr.Y, X - ctr.X);
    dphi := phi2 - phi1;
    if (phi2 > pi/2) and (phi1 < -pi/2) then
      dphi := 2*pi - dphi
    else
    if (phi1 > pi/2) and (phi2 < -pi/2) then
      dphi := 2*pi + dphi;
    RotateC(MyMatrix, -RadToDeg(dphi) / RotStep);
  end;

  MousePos.x := X;
  MousePos.y := Y;
end;


procedure TForm1.OpenGLControl1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
const
  StepP = 1.1;
  StepM = 0.9;
begin
  glMatrixMode(GL_MODELVIEW);
  if WheelDelta < 0 then begin
    Scale(MyMatrix, StepP);
  end else begin
    Scale(MyMatrix, StepM);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  DrawScene;
end;

procedure TForm1.DrawScene;
begin
  glEnable(GL_DEPTH_TEST);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;

  glMultMatrixf(@MyMatrix);

  glBegin(GL_POLYGON);
  glColor3f(1, 0, 0);
  glNormal3f(0.0, 0.0, 1.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glEnd;

  glBegin(GL_POLYGON);
  glColor3f(0, 1, 0);
  glNormal3f(0.0, 0.0, -1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glVertex3f(-1.0, -1.0, -1.0);
  glVertex3f(-1.0, 1.0, -1.0);
  glEnd;

  glBegin(GL_POLYGON);
  glColor3f(0, 0, 1);
  glNormal3f(-1.0, 0.0, 0.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glVertex3f(-1.0, 1.0, -1.0);
  glVertex3f(-1.0, -1.0, -1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glEnd;

  glBegin(GL_POLYGON);
  glColor3f(1, 1, 0);
  glNormal3f(1.0, 0.0, 0.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glEnd;

  glBegin(GL_POLYGON);
  glColor3f(1, 0, 1);
  glNormal3f(0.0, 1.0, 0.0);
  glVertex3f(-1.0, 1.0, -1.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glEnd;

  glBegin(GL_POLYGON);
  glColor3f(0, 1, 1);
  glNormal3f(0.0, -1.0, 0.0);
  glVertex3f(-1.0, -1.0, -1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glEnd;

  OpenGLControl1.SwapBuffers;
end;

end.
