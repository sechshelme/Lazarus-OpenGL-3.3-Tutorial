unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, Controls, Forms, ExtCtrls, Buttons, StdCtrls,
  oglUnit, oglVector, oglMatrix, oglTextur,
  oglSteuerung, oglKoerper, oglBackground,
  VLIFluegeli;

const
  AnzFluegeli = 220;

type
  TFluegeliWert = record
    Matrix: TMatrix;
    ColorVorn, ColorHinten: TVector4f;
  end;
  TFluegeliWerte = array[0..anzFluegeli] of TFluegeliWert;

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGL: TOpenGL;

    Fluegeli: TFluegeli;
    BK: TBackGround;
    texBK: TTexturBuffer;

    FlugelMatrix, ProMatrix: TMatrix;
    FluegeliWerte: TFluegeliWerte;
    procedure BewegeFluegeli;
    procedure InitScene;
    procedure InitTFluegeliWerte;
    procedure RenderScene;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function RndFloat: double; inline;
begin
  Result := Random(High(int64)) / High(int64);
end;

procedure TForm1.InitTFluegeliWerte;
var
  i, j: integer;

  function rnd: single; inline;
  const
    Faktor = 0.7;
  begin
    Result := 0.5 / Faktor - RndFloat / Faktor;
  end;

begin
  Randomize;
  for i := 0 to anzFluegeli do begin
    with FluegeliWerte[i] do begin
      Matrix.Identity;
      Matrix.Scale(1 / 140);
      Matrix.Translate(rnd, rnd, rnd);

      Matrix.RotateC(Pi * rnd);
      Matrix.RotateA(Pi * rnd);

      for j := 0 to 2 do begin
        ColorVorn[j] := RndFloat;
        ColorHinten[j] := RndFloat;
      end;
      ColorVorn[3] := 1.0;
      ColorHinten[3] := 1.0;
    end;
  end;
end;

procedure TForm1.BewegeFluegeli;
var
  i: integer;

  function rnd: single; inline;
  const
    Faktor = 100;
  begin
    Result := 0.5 / Faktor - RndFloat / Faktor;
  end;

begin
  for i := 0 to anzFluegeli do begin
    with FluegeliWerte[i] do begin
      Matrix.RotateC((0.01 + 1 * rnd) / 0.2);
      Matrix.RotateA((0.01 + 1.3 * rnd) / 0.2);
    end;
  end;
end;

procedure TForm1.InitScene;
begin
  Fluegeli := TFluegeli.Create;
  Fluegeli.WriteVertex;

  texBK := TTexturBuffer.Create;
  texBk.LoadTextures(Image1.Picture.Bitmap.RawImage);

  BK := TBackGround.Create(1);
  BK.WriteVertex;

  InitTFluegeliWerte;

  OpenGL.BkColor := vec4(0.1, 0.4, 0.1, 0.0);
  OpenGL.Camera.Translate(0, 0, -15);
  OpenGL.Camera.SetFrustum;
  OpenGL.Camera.Scale(2.0);
  OpenGL.Camera.MouseMoveStep := 0.01;

  Color := OpenGL.BkColorRGB;
end;

procedure TForm1.RenderScene;
var
  i: integer;
begin
  OpenGL.Clear;

  // Flügeli

  for i := 0 to anzFluegeli do begin
    with Fluegeliwerte[i] do begin
      FlugelMatrix.Identity;

      FlugelMatrix := ProMatrix * Matrix * FlugelMatrix;

      Fluegeli.Color1 := ColorVorn;
      Fluegeli.Color2 := ColorHinten;
      Opengl.Camera.ObjectMatrix := FlugelMatrix;
      Fluegeli.Draw;
    end;
  end;
  BewegeFluegeli;

  BK.Draw(texBK);

  OpenGL.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  FlugelMatrix.Identity;
  ProMatrix.Identity;

  OpenGL := TOpenGL.Create(Self);

  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  Fluegeli.Free;
  BK.Free;
  texBK.Free;

  OpenGL.Free;
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin
  OpenGL.Camera.ModifKey(Key);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  RenderScene;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  FormPaint(Sender);
end;

end.
