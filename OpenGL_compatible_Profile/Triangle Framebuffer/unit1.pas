unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, OpenGLContext, dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    textureID0, textureID1: GLuint;

    // Render Bufffer
    FramebufferName, depthrenderbuffer: GLuint;
    procedure initScene;
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

const
  TexturSize = 256;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  // In Buffer rendern

  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
  glClearColor(1.0, 0.5, 0.5, 1.0);
  glViewport(0, 0, TexturSize, TexturSize);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);

  glDisable(GL_TEXTURE_2D);

  glRotatef(1.0, 0.0, 0.0, 1.0);

  glBegin(GL_TRIANGLES);
  glColor3f(1, 0, 0);
  glVertex3f(0, 1, 0);
  glColor3f(0, 1, 0);
  glVertex3f(-1, 0, 0);
  glColor3f(0, 0, 1);
  glVertex3f(1, 0, 0);
  glEnd;

  // in Bildschirm rendern

  glBindFramebuffer(GL_FRAMEBUFFER, 0);
  glClearColor(0.5, 1.0, 0.5, 1.0);
  glViewport(0, 0, OpenGLControl1.Width, OpenGLControl1.Height);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

//  glEnable(GL_BLEND);
//  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);

  glEnable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, textureID1);

  glBegin(GL_QUADS);
  glColor3f(1, 1, 1);

  glTexCoord2f(1, 0);
  glVertex3f(-0.8, 0.8, 0);
  glTexCoord2f(1, 1);
  glVertex3f(-0.8, -0.8, 0);
  glTexCoord2f(0, 1);
  glVertex3f(0.8, -0.8, 0);
  glTexCoord2f(0, 0);
  glVertex3f(0.8, 0.8, 0);
  glEnd;

  OpenGLControl1.SwapBuffers;
end;

procedure TForm1.initScene;
var
  pic: TPicture;
begin
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

  // Leere Textur erzeugen

  glGenTextures(1, @textureID1);
  glBindTexture(GL_TEXTURE_2D, textureID1);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturSize, TexturSize, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  // Frame Buffer erzeugen

  glGenFramebuffers(1, @FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  glGenRenderbuffers(1, @depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);

  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, TexturSize, TexturSize);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, textureID1, 0);

//  glBindFramebuffer(GL_FRAMEBUFFER, 0);
  Timer1.Enabled := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Timer1.Enabled := False;
  Timer1.Interval := 10;
  InitOpenGL;
  OpenGLControl1.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  initScene;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Picture.Bitmap.Clear;
  Image1.Picture.Bitmap.Width := TexturSize;
  Image1.Picture.Bitmap.Height := TexturSize;
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
  glReadPixels(0, 0, TexturSize, TexturSize, GL_BGRA, GL_UNSIGNED_BYTE, Image1.Picture.Bitmap.RawImage.Data);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteFramebuffers(1, @FramebufferName);
  glDeleteRenderbuffers(1, @depthrenderbuffer);
  glDeleteTextures(1, @textureID0);
end;

initialization
  {$I unit1.lrs}

end.
