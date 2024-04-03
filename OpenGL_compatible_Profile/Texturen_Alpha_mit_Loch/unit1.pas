unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, OpenGLContext,
  oglglad_gl;


type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    OpenGLControl: TOpenGLControl;
  public
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

const
  size = 512;

var
  textureID0: GLuint;
  winkel: single;

  Textur: array[0..size - 1, 0..size - 1, 0..3] of byte;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  winkel := winkel + 1;
  if winkel > 360 then begin
    winkel := winkel - 360;
  end;

  glClearColor(0.8, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  // --- Textur Aktivieren

  glActiveTexture(GL_TEXTURE0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glRotatef(winkel, 0.0, 0.0, 1.0);

  glEnable(GL_TEXTURE_2D);

  glBegin(GL_QUADS);
  glTexCoord2f(0.0, 0.0);
  glVertex3f(-0.8, -0.8, 0);
  glTexCoord2f(1.0, 0.0);
  glVertex3f(-0.8, 0.8, 0);
  glTexCoord2f(1.0, 1.0);
  glVertex3f(0.8, 0.8, 0);
  glTexCoord2f(0.0, 1.0);
  glVertex3f(0.8, -0.8, 0);
  glEnd();

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  x, y, x2,y2: integer;
begin
  OpenGLControl := TOpenGLControl.Create(Self);
  with OpenGLControl do begin
    Parent := Self;
    Align := alClient;
    AutoResizeViewport := True;
  end;
  InitOpenGL;
  OpenGLControl.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  // ---- Textur erzeugen ----

  for x := 0 to size - 1 do begin
    for y := 0 to size - 1 do begin
      Textur[x, y, 0] := $FF;
      Textur[x, y, 1] := $00;
      Textur[x, y, 2] := $00;

      x2 :=x-size div 2;
      y2 :=y-size div 2;
      if sqrt(x2 * x2 + y2 * y2) > size div 4 then begin
        Textur[x, y, 3] := $FF;
      end else begin
        Textur[x, y, 3] := $00;
      end;
    end;
  end;

  // ------------ Texturen laden --------------

  glGenTextures(1, @textureID0);
  glBindTexture(GL_TEXTURE_2D, textureID0);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, size, size, 0, GL_BGRA, GL_UNSIGNED_BYTE, @Textur);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteTextures(1, @textureID0);
end;

initialization

  {$I unit1.lrs}

end.
