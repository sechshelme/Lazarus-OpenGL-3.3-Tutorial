unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, OpenGLContext, dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure Disk(ri, ra: single);
    procedure Kreis(ra, x, y: single);
  public
    OpenGLControl1: TOpenGLControl;
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

const
  FSektoren = 7;

procedure TForm1.Disk(ri, ra: single);
var
  w, seg: single;
  i: integer;
begin
  glbegin(GL_TRIANGLE_STRIP);
  seg := 360 / FSektoren;
  for i := 0 to FSektoren do begin
    w := i * seg / 180 * Pi;
    glColor3f(1, 0, 0);
    glVertex3f(cos(w) * ri, sin(w) * ri, 0);
    glColor3f(0, 1, 0);
    glVertex3f(cos(w) * ra, sin(w) * ra, 0);
  end;
  glEnd();
end;


procedure TForm1.Kreis(ra, x, y: single);
var
  w, seg: single;
  i: integer;
begin
  glPushMatrix;
  glTranslatef(x, y, 0);
  seg := 2 / FSektoren * Pi;
  glbegin(GL_TRIANGLE_STRIP);
  for i := 0 to FSektoren do begin
    w := i * seg;
    glColor3f(1, 0, 0);
    glVertex3f(0, 0, 0);
    glColor3f(0, 1, 0);
    glVertex3f(cos(w) * ra, sin(w) * ra, 0);
  end;
  glEnd();
  glPopMatrix;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  glClearColor(0.8, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  Kreis(0.3, 0.2, 0.2);
  Disk(0.5, 0.8);
  //glBegin(GL_TRIANGLES);
  //glColor3f(1, 0, 0);
  //glVertex3f(0, 1, 0);
  //glColor3f(0, 1, 0);
  //glVertex3f(-1, 0, 0);
  //glColor3f(0, 0, 1);
  //glVertex3f(1, 0, 0);
  //glEnd();

  OpenGLControl1.SwapBuffers;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGLControl1 := TOpenGLControl.Create(Self);
  OpenGLControl1.Align := alClient;
  OpenGLControl1.AutoResizeViewport := True;
  OpenGLControl1.Parent := Self;

  InitOpenGL;
  OpenGLControl1.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;
end;

initialization

  {$I unit1.lrs}

end.
