unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, OpenGLContext, oglglad_gl;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    ToggleBox1: TToggleBox;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    OpenGLControl1: TOpenGLControl;
  public
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

var
  textureID0,
  textureID1: GLuint;
  winkel: single;

  Textur24: packed array[0..11] of byte = ($FF, $00, $00, $00, $FF, $00, $00, $00, $FF, $FF, $00, $00);
  //  Textur24: packed array[0..13] of byte = ($FF, $00, $00, $00, $FF, $00, $00, $00, $00, $00, $FF, $FF, $00, $00, $00, $00);
  //Textur32: packed array[0..1, 0..1, 0..3] of byte = ((($FF, $00, $00, $FF), ($00, $FF, $00, $FF)), (($00, $00, $FF, $FF), ($FF, $00, $00, $FF)));
  Textur32Alpha: packed array[0..1, 0..1, 0..3] of byte = ((($FF, $00, $00, $FF), ($00, $FF, $00, $FF)), (($00, $00, $FF, $00), ($FF, $00, $00, $00)));


procedure TForm1.Timer1Timer(Sender: TObject);

  procedure Draw(size: GLfloat);
  begin
    glBegin(GL_QUADS);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(-size, -size, 0);
    glTexCoord2f(1.0, 0.0);
    glVertex3f(-size, size, 0);
    glTexCoord2f(1.0, 1.0);
    glVertex3f(size, size, 0);
    glTexCoord2f(0.0, 1.0);
    glVertex3f(size, -size, 0);
    glEnd();
  end;

begin
  if ToggleBox1.Checked then begin
    winkel := winkel + 1;
    if winkel > 360 then begin
      winkel := winkel - 360;
    end;
  end;

  glClearColor(0.8, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  glEnable(GL_TEXTURE_2D);

  glBindTexture(GL_TEXTURE_2D, textureID0);

  glPushMatrix;
  glTranslatef(-0.5, 0.0, 0.0);
  glRotatef(winkel, 0.0, 0.0, 1.0);
  Draw(0.4);

  glBindTexture(GL_TEXTURE_2D, textureID1);
  glPopMatrix;
  glTranslatef(0.5, 0.0, 0.0);
  glRotatef(winkel, 0.0, 0.0, 1.0);

  Draw(0.4);
  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGLControl1 := TOpenGLControl.Create(Self);
  OpenGLControl1.Parent := Self;
  OpenGLControl1.Align := alClient;
  OpenGLControl1.AutoResizeViewport := True;

  InitOpenGL;
  OpenGLControl1.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;


  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  // ------------ Texturen 1 laden --------------

  glGenTextures(1, @textureID0);
  glBindTexture(GL_TEXTURE_2D, textureID0);
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 2, 2, 0, GL_RGB, GL_UNSIGNED_BYTE, @Textur24);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);

  // ------------ Texturen 2 laden --------------

  glGenTextures(1, @textureID1);
  glBindTexture(GL_TEXTURE_2D, textureID1);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32Alpha);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glMatrixMode(GL_TEXTURE);  // Textur Scalieren
  glLoadIdentity();

  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteTextures(1, @textureID0);
  glDeleteTextures(1, @textureID1);
end;

initialization

  {$I unit1.lrs}

end.
