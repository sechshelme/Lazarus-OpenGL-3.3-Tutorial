unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
//  ExtCtrls, ComCtrls, StdCtrls, OpenGLContext, oglglad_gl;
ExtCtrls, ComCtrls, StdCtrls, OpenGLContext, gl;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    mpos: record
      a, b, c, x, y, z: single;
    end;
    Schritt: integer;
    procedure Disk(ri, ra: single);
    procedure DrawScene;
    procedure OpenGLControl1Paint(Sender: TObject);
  public
    OpenGLControl: TOpenGLControl;
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

const
  FSektoren = 6;
  maxSchritt = 500;

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

procedure TForm1.DrawScene;
begin
  glClearColor(0.8, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  with mpos do begin
    glTranslatef(x, y, z);
    glRotatef(a, 1, 0, 0);
    glRotatef(b, 0, 1, 0);
    glRotatef(c, 0, 0, 1);
    Disk(0.5, 0.8);

    x := x / maxSchritt * Schritt;
    y := y / maxSchritt * Schritt;
    z := z / maxSchritt * Schritt;
    a := a / maxSchritt * Schritt;
    b := b / maxSchritt * Schritt;
    c := c / maxSchritt * Schritt;
    if Schritt > 0 then begin
      Dec(Schritt);
    end;
  end;

  OpenGLControl.SwapBuffers;
end;

procedure TForm1.OpenGLControl1Paint(Sender: TObject);
begin
  DrawScene;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  OpenGLControl.Invalidate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGLControl := TOpenGLControl.Create(Self);
  OpenGLControl.Parent := Self;
  OpenGLControl.Align := alClient;
  OpenGLControl.AutoResizeViewport := True;
  OpenGLControl.OnPaint:=@OpenGLControl1Paint;

//  InitOpenGL;
  OpenGLControl.MakeCurrent;
//  ReadExtensions;
//  ReadImplementationProperties;
  Schritt := 0;
  Randomize;
end;

procedure TForm1.Button1Click(Sender: TObject);

  function r(w: single): single;
  begin
    Result := Random * w - w / 2;
  end;

const
  rxyz = 2.5;
  rabc = 360;
begin
  with mpos do begin
    x := r(rxyz);
    y := r(rxyz);
    z := r(rxyz);
    a := r(rabc);
    b := r(rabc);
    c := r(rabc);
  end;
  Schritt := maxSchritt;

end;

initialization

  {$I unit1.lrs}

end.
