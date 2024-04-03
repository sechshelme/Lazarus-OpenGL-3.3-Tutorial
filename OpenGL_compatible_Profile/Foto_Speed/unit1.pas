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

const
//  FotoPfad = '/n4800/Multimedia/Pictures/Fotos/Bregenzerwaldbahn';
  FotoPfad = '/n4800/Multimedia/Pictures/Fotos';

var
  FotoTextur: array of TTexturBuffer;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  p: integer = 0;

  procedure Draw(puf: TTexturBuffer);
  begin
    puf.ActiveAndBind;
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

begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_TEXTURE_2D);

  glRotatef(-90.0, 0.0, 0.0, 1.0);
  Inc(p);
  if p >= Length(FotoTextur) then begin
    p := 0;
  end;
  Draw(FotoTextur[p]);

  OpenGLControl1.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  sl: TStringList;
  i: integer;
begin
  OpenGLControl1 := TOpenGLControl.Create(Self);
  OpenGLControl1.Parent := Self;
  OpenGLControl1.Align := alClient;
  OpenGLControl1.AutoResizeViewport := True;

  InitOpenGL;
  OpenGLControl1.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  sl := FindAllFiles(FotoPfad);
  SetLength(FotoTextur, sl.Count);
  for i := 0 to Length(FotoTextur) - 1 do begin
    FotoTextur[i] := TTexturBuffer.Create;
    FotoTextur[i].LoadTextures(sl[i]);
    WriteLn(i, ' von ', sl.Count,' geladen.');
  end;
  sl.Free;

  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(FotoTextur) - 1 do begin
    FotoTextur[i].Free;
  end;
end;

initialization

  {$I unit1.lrs}

end.
