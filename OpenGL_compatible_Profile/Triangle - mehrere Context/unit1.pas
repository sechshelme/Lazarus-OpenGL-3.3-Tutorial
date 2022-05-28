unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, OpenGLContext, dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    OpenGLControl2: TOpenGLControl;
    OpenGLControl3: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure OpenGLControl1Paint(Sender: TObject);
    procedure OpenGLControl2Paint(Sender: TObject);
    procedure OpenGLControl3Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    winkel: single;
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

procedure TForm1.OpenGLControl1Paint(Sender: TObject);
begin
  glClearColor(0.8, 0.9, 0.1, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glRotatef(winkel * 3, 0, 0, 1);

  glBegin(GL_TRIANGLES);
  glColor3f(1, 0, 0);
  glVertex3f(0, 1, 0);
  glColor3f(0, 1, 0);
  glVertex3f(-1, 0, 0);
  glColor3f(0, 0, 1);
  glVertex3f(1, 0, 0);
  glEnd();

  OpenGLControl1.SwapBuffers;
end;

procedure TForm1.OpenGLControl2Paint(Sender: TObject);
begin
  glClearColor(0.8, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glRotatef(winkel* 2, 0, 0, 1);
  glTranslatef(0.5, 0, 0);

  glBegin(GL_TRIANGLES);
  glColor3f(1, 0, 0);
  glVertex3f(0, 1, 0);
  glColor3f(1, 1, 0);
  glVertex3f(-1, 0, 0);
  glColor3f(1, 0, 1);
  glVertex3f(1, 0, 0);
  glEnd();

  OpenGLControl2.SwapBuffers;
end;

procedure TForm1.OpenGLControl3Paint(Sender: TObject);
begin
  glClearColor(0.3, 0.3, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glRotatef(winkel, 0, 0, 1);

  glBegin(GL_TRIANGLES);
  glColor3f(1, 0, 0);
  glVertex3f(0, 1, 0);
  glColor3f(1, 1, 0);
  glVertex3f(-1, 0, 0);
  glColor3f(1, 0, 1);
  glVertex3f(1, 0, 0);
  glEnd();

  OpenGLControl3.SwapBuffers;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  winkel := winkel + 1;
  if winkel > 360 then begin
    winkel := winkel - 360;
  end;
  Caption := FloatToStr(winkel);
  Repaint;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  InitOpenGL;
  //    MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;
end;

initialization
  {$I unit1.lrs}

end.
