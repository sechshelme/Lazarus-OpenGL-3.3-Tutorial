unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, gl,
  glu, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    hrc: HGLRC;
    DC: hdc;
    procedure DrawScene;

  public
    { public declarations }
  end;

var
  Form1: TForm1;

  Snake: record
    x, y: single;
  end;



implementation

{$R *.lfm}
const
  Feld: array[1..10, 1..10] of byte = (
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
    (1, 0, 0, 0, 0, 0, 0, 0, 0, 1),
    (1, 0, 3, 3, 3, 3, 3, 0, 0, 1),
    (1, 0, 0, 0, 0, 0, 0, 0, 0, 1),
    (1, 0, 0, 0, 0, 0, 0, 0, 0, 1),
    (1, 0, 0, 0, 0, 0, 0, 0, 0, 1),
    (1, 0, 0, 2, 2, 2, 2, 2, 0, 1),
    (1, 0, 0, 0, 0, 0, 0, 0, 0, 1),
    (1, 0, 0, 0, 0, 0, 0, 0, 0, 1),
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1));


procedure SetDCPixelFormat(Handle: HDC);
var
  pfd: TPixelFormatDescriptor;
  nPixelFormat: integer;

begin
  FillChar(pfd, SizeOf(pfd), 0);

  with pfd do begin
    nSize := sizeof(pfd);                               // Size of this structure
    nVersion := 1;                                         // Version number
    dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;  // Flags
    iPixelType := PFD_TYPE_RGBA;                             // RGBA pixel values
    cColorBits := 24;                                        // 24-bit color
    cDepthBits := 32;                                        // 32-bit depth buffer
    iLayerType := PFD_MAIN_PLANE;                            // Layer type
  end;

  nPixelFormat := ChoosePixelFormat(Handle, @pfd);
  SetPixelFormat(Handle, nPixelFormat, @pfd);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DC := GetDC(Handle);
  SetDCPixelFormat(Canvas.Handle);
  hrc := wglCreateContext(Canvas.Handle);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  wglMakeCurrent(DC, hrc);
  DrawScene;
  wglMakeCurrent(0, 0);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Snake.x := Snake.x + 0.004;
  if Snake.x > 1 then begin
    Snake.x := 0;
  end;
  Snake.y := Snake.y + 0.006;
  if Snake.y > 1 then begin
    Snake.y := 0;
  end;
  FormPaint(Sender);
end;

procedure TForm1.DrawScene;
const
  b = 0.1;
var
  x, y: integer;

begin
  glEnable(GL_DEPTH_TEST);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glMatrixMode(GL_MODELVIEW);

  glLoadIdentity;
  glTranslatef(-b * 5, -b * 5, 0);  // Koordinatenverschieben
  for x := 1 to 10 do begin
    for y := 1 to 10 do begin
      glBegin(GL_QUADS);
      case Feld[x, y] of
        0: begin
          glColor3f(1, 1, 1);
        end;
        1: begin
          glColor3f(1, 0, 0);
        end;
        2: begin
          glColor3f(0, 0, 1);
        end;
        3: begin
          glColor3f(0, 1, 0);
        end;
      end;
      glVertex2f(x * b, y * b);
      glVertex2f(x * b + b, y * b);
      glVertex2f(x * b + b, y * b + b);
      glVertex2f(x * b, y * b + b);
      glEnd;
    end;
  end;
  glTranslatef(0, 0, -0.01); // Sprite ein bischen höher als Spielfeld
  glBegin(GL_QUADS);
  glColor3f(1, 1, 0);
  glVertex2f(Snake.x, Snake.y);
  glVertex2f(Snake.x + b, Snake.y);
  glVertex2f(Snake.x + b, Snake.y + b);
  glVertex2f(Snake.x, Snake.y + b);
  glEnd;

  SwapBuffers(DC);
end;



end.
