unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics,
  Forms, Dialogs, ExtCtrls, FileUtil, LazUTF8, types, Controls, ComCtrls,
  Buttons, StdCtrls, OpenGLContext,
  oglMatrix, oglShader,
  oglColorKoerper,
  oglUnit,
  oglSteuerung, oglTextur,
  oglTexturKoerper,
  oglKoerper,
  oglBackGround;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGL: TOpenGL;

    Cube: TTexturBox;

    texKiste,
    texBackGround: TTexturBuffer;

    MyBackGround: TBackGround;

    procedure InitScene;
    procedure RenderScene;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.InitScene;
begin
  texBackGround := TTexturBuffer.Create;
  texKiste := TTexturBuffer.Create;

  texBackGround.LoadTextures('Wald.jpg');
  texKiste.LoadTextures(Image1.Picture.Bitmap.RawImage);

  Cube := TTexturBox.Create(1);
  Cube.WriteVertex;

  MyBackGround := TBackGround.Create(1);
  MyBackGround.WriteVertex;
end;

procedure TForm1.RenderScene;
var
  m: TMatrix;
begin
  OpenGL.Clear;

  with  OpenGL.Camera do begin
    m := ObjectMatrix;

    // MyBackGround
    MyBackGround.Draw(texBackGround);

    // Cube
    ObjectMatrix.RotateA(Pi / 8);
    ObjectMatrix.RotateB(Pi / 8);
    Cube.Draw(texKiste);

    ObjectMatrix := m;
  end;

  OpenGL.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGL := TOpenGL.Create(Self);
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenGL.Free;

  Cube.Free;
  texBackGround.Free;
  texKiste.Free;
end;


procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
  OpenGL.Camera.Perspective(30, ClientWidth / ClientHeight, 0.01, 700, -50.0, 5.0);
  OpenGL.Camera.MouseMoveStep := 0.01;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RenderScene;
end;

end.
