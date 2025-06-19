unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, OpenGLContext, gl;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    oglControl: TOpenGLControl;
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  glClearColor(0.8, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  // Projectionsmatrix
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  // Modelmatrix
  glMatrixMode(GL_MODELVIEW);
//  glLoadIdentity();
  glRotatef(5.0, 0.0, 0.0, 1.0); // Winkel ist in Grad.

  glBegin(GL_TRIANGLES);
  glColor3f(0.8, 0.0, 0.0);
  glVertex3f(0, 0.8, 0.0);
  glColor3f(0.0, 0.8, 0.0);
  glVertex3f(-0.8, -0.8, 0.0);
  glColor3f(0.0, 0.0, 0.8);
  glVertex3f(0.8, -0.8, 0.0);
  glEnd();

  oglControl.SwapBuffers;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Timer1.Interval := 40;
  oglControl := TOpenGLControl.Create(Self);
  oglControl.Align := alClient;
  oglControl.AutoResizeViewport := True;
  oglControl.Parent := Self;
end;

initialization

  {$I unit1.lrs}

end.
