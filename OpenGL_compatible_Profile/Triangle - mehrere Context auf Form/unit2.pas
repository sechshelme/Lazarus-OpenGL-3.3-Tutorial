unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, oglglad_gl;

type

  { TForm2 }

  TForm2 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure OpenGLControl1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.OpenGLControl1Paint(Sender: TObject);
const
  winkel: single = 0.0;
begin
  winkel += 0.4;
  glClearColor(0.1, 0.9, 0.1, 1.0);
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

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  OpenGLControl1.Invalidate;
end;

end.

