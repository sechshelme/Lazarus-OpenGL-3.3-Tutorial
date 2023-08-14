unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, OpenGLContext, dglOpenGL;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Timer1: TTimer;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    bit: TBitmap;
    OpenGLControl: TOpenGLControl;
  end;

var
  Form1: TForm1;

implementation

{ TForm1 }

function CreateBitmap: TBitmap;
begin
  Result := TBitmap.Create;
  with  Result do begin
    Width := 512;
    Height := 512;
    with Canvas do begin
      Pen.Color := clWhite;
      Brush.Color := clWhite;
      Rectangle(0, 0, Result.Width, Result.Height);
      Pen.Color := clBlack;
      Line(0, 0, Result.Width, Result.Height);
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  glClearColor(Random, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);

  glDrawPixels(512,512, GL_RGB,GL_UNSIGNED_BYTE,bit.RawImage.Data) ;

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  bit:=CreateBitmap;

  OpenGLControl := TOpenGLControl.Create(Self);
  with OpenGLControl do begin
    Parent := Panel1;
    Align:=alClient;
    AutoResizeViewport:=True;
  end;
  InitOpenGL;
  OpenGLControl.MakeCurrent;
  ReadExtensions;
  ReadImplementationProperties;

  glClearColor(0,0,0,0);
  glShadeModel(GL_FLAT);
  glPixelStorei(GL_UNPACK_ALIGNMENT,1);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
end;

initialization

  {$I unit1.lrs}

end.
