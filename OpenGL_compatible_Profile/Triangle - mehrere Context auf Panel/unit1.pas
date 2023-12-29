unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Menus, OpenGLContext, dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    OpenGLControl1: TOpenGLControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure OpenGLControl1Paint(Sender: TObject);
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

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  OpenGLControl1.Parent:=Panel1;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  OpenGLControl1.Parent:=Panel2;

end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  OpenGLControl1.Parent:=Panel3;

end;

initialization
  {$I unit1.lrs}

end.
