unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, OpenGLContext, oglglad_gl;

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
  FSektoren = 6;

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
  ang, seg: single;
  i: integer;
begin
  glPushMatrix;
  glTranslatef(x, y, 0);
  seg := 2 / FSektoren * Pi;
  glbegin(GL_TRIANGLE_STRIP);
  for i := 0 to FSektoren do begin
    ang := i * seg;
    glColor3f(1, 0, 0);
    glVertex3f(0, 0, 0);
    glColor3f(0, 1, 0);
    glVertex3f(cos(ang) * ra, sin(ang) * ra, 0);
  end;
  glEnd();
  glPopMatrix;
end;

type
  TPlanetPos = record
    Jahr, Tag: single;
  end;

var
  Mond, Merkur, Venus, Erde, Mars: TPlanetPos;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  glClearColor(0.8, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  with Merkur do begin
    glPushMatrix;
    Jahr := Jahr + 1.4;
    Tag := Tag + 3;
    if Jahr > 360 then begin
      Jahr := Jahr - 360;
    end;
    if Tag > 360 then begin
      Tag := Tag - 360;
    end;
    glRotatef(Jahr, 0.0, 0.0, 1.0);
    glTranslatef(0.2, 0.0, 0.0);
    glRotatef(Tag, 0.0, 0.0, 1.0);
    Kreis(0.05, 0.0, 0.0);
    glPopMatrix;
  end;

  with Venus do begin
    glPushMatrix;
    Jahr := Jahr + 1.2;
    Tag := Tag + 10;
    if Jahr > 360 then begin
      Jahr := Jahr - 360;
    end;
    if Tag > 360 then begin
      Tag := Tag - 360;
    end;
    glRotatef(Jahr, 0.0, 0.0, 1.0);
    glTranslatef(0.3, 0.0, 0.0);
    glRotatef(Tag, 0.0, 0.0, 1.0);
    Kreis(0.075, 0.0, 0.0);
    glPopMatrix;
  end;

  with Erde do begin
    glPushMatrix;
    Jahr := Jahr + 1.0;
    Tag := Tag + 15;
    if Jahr > 360 then begin
      Jahr := Jahr - 360;
    end;
    if Tag > 360 then begin
      Tag := Tag - 360;
    end;
    glRotatef(Jahr, 0.0, 0.0, 1.0);
    glTranslatef(0.5, 0.0, 0.0);
    glRotatef(Tag, 0.0, 0.0, 1.0);
    //    Kreis(0.075, 0.0, 0.0);

    with Mond do begin
      Jahr := Jahr + 5.0;
      Tag := Tag + 5.0;
      if Jahr > 360 then begin
        Jahr := Jahr - 360;
      end;
      if Tag > 360 then begin
        Tag := Tag - 360;
      end;
      glRotatef(Jahr, 0.0, 0.0, 1.0);

      glPushMatrix;
      glTranslatef(0.1, 0.0, 0.0);
      glRotatef(Tag, 0.0, 0.0, 1.0);
      Kreis(0.025, 0.0, 0.0);   // Mond
      glPopMatrix;
      glTranslatef(-0.010, 0.0, 0.0);
      glRotatef(Tag, 0.0, 0.0, 1.0);
      Kreis(0.075, 0.0, 0.0);  // Erde
    end;

    glPopMatrix;
  end;

  with Mars do begin
    glPushMatrix;
    Jahr := Jahr + 0.7;
    Tag := Tag + 10;
    if Jahr > 360 then begin
      Jahr := Jahr - 360;
    end;
    if Tag > 360 then begin
      Tag := Tag - 360;
    end;
    glRotatef(Jahr, 0.0, 0.0, 1.0);
    glTranslatef(0.7, 0.0, 0.0);
    glRotatef(Tag, 0.0, 0.0, 1.0);
    Kreis(0.05, 0.0, 0.0);
    glPopMatrix;
  end;

  OpenGLControl1.SwapBuffers;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGLControl1 := TOpenGLControl.Create(Self);
  OpenGLControl1.Align := alClient;
  OpenGLControl1.AutoResizeViewport := True;
  OpenGLControl1.Parent := Self;
  OpenGLControl1.MakeCurrent;
  Load_GLADE;
end;

initialization

  {$I unit1.lrs}

end.
