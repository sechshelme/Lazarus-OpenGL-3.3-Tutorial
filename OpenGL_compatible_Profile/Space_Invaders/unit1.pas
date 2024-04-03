unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, OpenGLContext, oglglad_gl, oglTextur;

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
  BKTextur: TTexturBuffer;

  Sprite: record
    Baum, icon: TTexturBuffer;
  end;

  winkel: single;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i, j: integer;

  procedure DrawBkground;
  begin
    BKTextur.ActiveAndBind;
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(-1.0, -1.0, 0.99);
    glTexCoord2f(1.0, 0.0);
    glVertex3f(-1.0, 1.0, 0.99);
    glTexCoord2f(1.0, 1.0);
    glVertex3f(1.0, 1.0, 0.99);
    glTexCoord2f(0.0, 1.0);
    glVertex3f(1.0, -1.0, 0.99);
    glEnd();
  end;

  procedure Draw(size, z: GLfloat; TexturPuffer: TTexturBuffer);
  begin
    TexturPuffer.ActiveAndBind;
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(-size, -size, z);
    glTexCoord2f(1.0, 0.0);
    glVertex3f(-size, size, z);
    glTexCoord2f(1.0, 1.0);
    glVertex3f(size, size, z);
    glTexCoord2f(0.0, 1.0);
    glVertex3f(size, -size, z);
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
  DrawBkground;


  for i := 0 to 5 do begin
    for j := 0 to 5 do begin
      glPushMatrix;
      glTranslatef(-0.5 + i * 0.2, -0.5 + j * 0.2, 0.0);
      glRotatef(winkel, 0.0, 0.0, 1.0);
      Draw(0.08, 0.0, Sprite.icon);
      glPopMatrix;

    end;
  end;

  glPushMatrix;
  glTranslatef(-0.2, 0.0, 0.0);
  glRotatef(-90.0, 0.0, 0.0, 1.0);
  Draw(0.5, -0.1, Sprite.Baum);
  glPopMatrix;

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

  with Sprite do begin
    Baum := TTexturBuffer.Create;
    Baum.LoadTextures('baum.png');

    icon := TTexturBuffer.Create;
    icon.LoadTextures('project1.ico');
  end;

  BKTextur := TTexturBuffer.Create;
  BKTextur.LoadTextures('Wald.jpg');


  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  BKTextur.Free;

  with Sprite do begin
    Baum.Free;
    icon.Free;
  end;
end;

initialization

  {$I unit1.lrs}

end.
