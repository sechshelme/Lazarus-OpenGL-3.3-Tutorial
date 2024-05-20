unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, OpenGLContext, gl,GLext;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Timer1: TTimer;
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
  with Result do begin
    SetSize(512,512);
    with Canvas do begin
      Pen.Color := clWhite;
      Brush.Color := clWhite;
      Rectangle(0, 0, Result.Width, Result.Height);
      Pen.Color := clBlack;
      Line(0, 0, Result.Width, Result.Height);
      Line(0, Result.Height, Result.Width, 0);
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  glClearColor(Random, 0.5, 0.3, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);

//  glDrawPixels(512, 512, GL_RGB, GL_UNSIGNED_BYTE, bit.RawImage.Data);
  glDrawPixels(Image1.Picture.Bitmap.Width, Image1.Picture.Bitmap.Height, GL_BGRA, GL_UNSIGNED_BYTE, Image1.Picture.Bitmap.RawImage.Data);

  OpenGLControl.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  bit := CreateBitmap;

  OpenGLControl := TOpenGLControl.Create(Self);
  with OpenGLControl do begin
    Parent := Panel1;
    Align := alClient;
    AutoResizeViewport := True;
  end;
  OpenGLControl.MakeCurrent;

  glClearColor(0, 0, 0, 0);
  glShadeModel(GL_FLAT);
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  bit.Free;
end;

initialization

  {$I unit1.lrs}

end.
