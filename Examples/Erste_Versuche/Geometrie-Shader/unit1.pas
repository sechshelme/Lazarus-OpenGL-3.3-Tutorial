unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Forms,
  Dialogs,
  ExtCtrls,
  Buttons, StdCtrls, OpenGLContext,
  oglMatrix, oglTextur,
  oglColorKoerper,
  oglUnit,
  oglSteuerung,   oglCamera,
  oglKoerper,
  oglBackGround, Geoshaderkoerper;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGL: TOpenGL;

    texBackGround: TTexturBuffer;
    tex3, texTextur: TTexturBuffer;

    TexturCube: TGeoShaderKoerper;

    MyBackGround: TBackGround;

    ProMatrix: TMatrix;
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
  texTextur := TTexturBuffer.Create;
  tex3 := TTexturBuffer.Create;

  texBackGround.LoadTextures(Image4.Picture.Bitmap.RawImage);

  texTextur.LoadTextures(Image1.Picture.Bitmap.RawImage);
  tex3.LoadTextures(Image3.Picture.Bitmap.RawImage);


  TexturCube := TGeoShaderKoerper.Create(True);
  TexturCube.SetTexCoord(2, 2);
  TexturCube.WriteVertex;

  MyBackGround := TBackGround.Create(1);
  MyBackGround.WriteVertex;
end;

procedure TForm1.RenderScene;
var
  Matrix: TMatrix;
begin
  Matrix.Identity;
  OpenGL.Clear;

  // MyBackGround;

  MyBackGround.Draw(texBackGround);

  // TexturCube;

  Matrix := ProMatrix;
  Matrix.Scale(0.5);
  Matrix.RotateC(-Pi / 2);
  Matrix.RotateB(Pi / 8);
  OpenGL.Camera.ObjectMatrix := Matrix;
  TexturCube.Draw(texTextur);

  OpenGL.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  ProMatrix.Identity;;
  OpenGL := TOpenGL.Create(Self);
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenGL.Free;
  TexturCube.Free;
  MyBackGround.Free;
  texBackGround.Free;
  texTextur.Free;
  tex3.Free;
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin
  OpenGL.Camera.ModifKey(Key);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
  OpenGL.Camera.Perspective(30, ClientWidth / ClientHeight, 0.3, 100, -25, 0.4);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ProMatrix.RotateB(Pi / 150);
  RenderScene;
end;

end.
