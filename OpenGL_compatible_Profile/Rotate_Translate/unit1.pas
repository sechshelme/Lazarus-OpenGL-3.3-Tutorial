unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, OpenGLContext, dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  public
    procedure ZeichenQuad(r, g, b: single);
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

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  ZeichenQuad(1, 0, 0); // ohne Bewegung

  glPushMatrix;
  glTranslatef(0.8, 0.0, 0.0);
  glRotatef(45, 0, 0, 1);
  ZeichenQuad(0, 1, 0); // zuerst schieben, dann drehen
  glPopMatrix;

  glPushMatrix;
  glRotatef(45, 0, 0, 1);
  glTranslatef(0.8, 0.0, 0.0);
  ZeichenQuad(0, 0, 1); // zuerst drehen, dann schieben
  glPopMatrix;

  glPushMatrix;
  glScalef(0.3,0.3,0.3);
  glRotatef(-90, 0, 0, 1);
  glTranslatef(0.8, 0.0, 0.0);
  glRotatef(90, 0, 0, 1);
  ZeichenQuad(1, 1, 1); // zuerst drehen, dann schieben, nochmals drehen
  glPopMatrix;

  OpenGLControl1.SwapBuffers;
end;

procedure TForm1.ZeichenQuad(r, g, b: single);
const
  l = 0.2;
  w = 0.04;
begin
  glBegin(GL_QUADS);
  glColor3f(r, g, b);
  glVertex3f(-l, -w, 0);
  glVertex3f(-l, w, 0);
  glVertex3f(l, w, 0);
  glVertex3f(l, -w, 0);
  glEnd();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  InitOpenGL;
  OpenGLControl1.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;
end;

initialization

  {$I unit1.lrs}

end.
