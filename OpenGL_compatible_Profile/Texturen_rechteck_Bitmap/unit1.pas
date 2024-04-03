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
    ToggleBox2: TToggleBox;
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

  PointPos:record
    x, y:GLfloat;
  end;

  Textur32: packed array[0..1, 0..1, 0..3] of byte = ((($FF, $00, $00, $FF), ($00, $FF, $00, $FF)), (($00, $00, $FF, $FF), ($FF, $00, $00, $FF)));


procedure TForm1.Timer1Timer(Sender: TObject);

  procedure Draw(size: GLfloat);
  begin
    glBegin(GL_QUADS);
    glColor3f(1.0, 1.0, 1.0);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(-size, -size, 0);
    glTexCoord2f(4.0, 0.0);
    glVertex3f(-size, size, 0);
    glTexCoord2f(4.0, 4.0);
    glVertex3f(size, size, 0);
    glTexCoord2f(0.0, 4.0);
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

  glPushMatrix;
  glBindTexture(GL_TEXTURE_2D, textureID0);
  glTranslatef(-0.5, 0.0, 0.0);
  glRotatef(winkel, 0.0, 0.0, 1.0);
  Draw(0.4);
  glPopMatrix;

  glBindTexture(GL_TEXTURE_2D, textureID1);
  glTranslatef(0.5, 0.0, 0.0);
  glRotatef(winkel, 0.0, 0.0, 1.0);
  Draw(0.4);

  glDisable(GL_TEXTURE_2D);


  if ToggleBox2.Checked then begin
    glLoadIdentity();
    with PointPos do begin
      x+=0.019; if x>1.0 then x:=-1.0;
      y+=0.021; if y>1.0 then y:=-1.0;
      glTranslatef(x, y, -0.85);
    end;

    glpointsize(15);
    glbegin(gl_Points);
    glcolor3f(0.3, 0.9, 0.5);
    glvertex3f(0, 0, 0);
    glend;
  end;

  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  pic: TPicture;
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

  // ------------ Texturen 0 laden --------------

  pic := TPicture.Create;
  pic.LoadFromFile('project1.ico');     // Es gehen auch jpg/bmp/ico
  with pic.Bitmap do begin
    glGenTextures(1, @textureID0);
    glBindTexture(GL_TEXTURE_2D, textureID0);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Width, Height, 0, GL_BGRA, GL_UNSIGNED_BYTE, RawImage.Data);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  end;
  pic.Free;


  // ------------ Texturen 1 laden --------------

  glGenTextures(1, @textureID1);
  glBindTexture(GL_TEXTURE_2D, textureID1);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 2, 2, 0, GL_RGBA, GL_UNSIGNED_BYTE, @Textur32);

  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

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
