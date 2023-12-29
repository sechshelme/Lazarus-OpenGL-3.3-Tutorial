unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics,
  Forms,
  Dialogs,
  ExtCtrls, FileUtil, LazUTF8,
  Buttons, StdCtrls, OpenGLContext,
  oglVector, oglMatrix, oglShader,
  oglColorKoerper,
  oglUnit,
  oglSteuerung, oglTextur,
  oglTexturKoerper,
  oglKoerper,
  oglBackGround, oglFontTextur, BGRABitmapTypes, types, Controls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    FontDialog1: TFontDialog;
    OpenDialog1: TOpenDialog;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private   { private declarations }
    OpenGL: TOpenGL;

    Cube: TTexturBox;

    texBackGround: TTexturBuffer;
    FontQuad: TFontTextur;
    Titel: TFontTextur;

    RotText: TFontTextur;
    RotTextMatrix: TMatrix;

    MyBackGround: TBackGround;

    FontMatrix: TMatrix;


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
  texBackGround.LoadTextures('Wald.jpg');

  Cube := TTexturBox.Create(0);
  Cube.Color := vec4(1.0, 0.0, 0.0, 1.0);
  Cube.WriteVertex;

  FontQuad := TFontTextur.Create(True);
  FontQuad.Font.Name := 'Arial';
  FontQuad.Font.Quality := fqNonAntialiased;
  FontQuad.Font.Size := 12;
  FontQuad.Font.Color := $FFFF;
  FontQuad.gradient := True;
  //    FontQuad.Font.Name := 'Consolas';
  FontQuad.WriteVertex;

  Titel := TFontTextur.Create(False);
  //  Titel.StaticObject := True;
  //Titel.Font.Name := 'Arial';
  //Titel.Font.Quality := fqNonAntialiased;
  //Titel.Font.Size := 24;
  //Titel.Font.Color := $FF;
  Titel.SetBKColor(BGRA($00, $FF, $00, $80));
  Titel.SetGradientColor(BGRA($FF, $00, $00), BGRA($00, $00, $FF));

  Titel.Font.Style := [fsBold];
  Titel.gradient := True;
  Titel.WriteVertex;

  RotText := TFontTextur.Create(True);

  RotText.Font.Name := 'Arial';
  RotText.Font.Quality := fqNonAntialiased;
  RotText.Font.Size := 24;
  RotText.Font.Color := $FF;
  RotText.SetBKColor(BGRA($00, $00, $00, $00));
  RotText.Font.Style := [fsBold];
  RotText.WriteVertex;

  MyBackGround := TBackGround.Create(1);
  //  MyBackGround.SetTexCoord(3, 4);
  MyBackGround.WriteVertex;


  OpenGL.Camera.Scale(20);

  //  FontMatrix.Translate(-10.5, 0.0, 0.0);
  FontMatrix.RotateC(Pi / 60);

  OpenGL.AlphaBlending(True);
  //  TMaterialShader.LightParams.position := vec4(0, -5, -5, -5.0);
end;

procedure TForm1.RenderScene;
const
  Zaehler: integer = 0;
var
  m: TMatrix;
begin
  OpenGL.Clear;

  with  OpenGL.Camera do begin
    m := ObjectMatrix;

    // MyBackGround;

    MyBackGround.Draw(texBackGround);

    // Text-Ausgabe

    Inc(Zaehler);
    //    FontQuad.Draw('Hello World! ' + IntToStr(Zaehler));

    // Text

    ObjectMatrix := ObjectMatrix * FontMatrix;

    FontQuad.Draw(Edit1.Text);

    // Statische Text

    ObjectMatrix.Identity;
    Enabled := False;
    ObjectMatrix.Translate(-1.0, -1.0, -0.9999);
    ObjectMatrix.Scale(0.2);

    //    Titel.Draw(UTF8ToConsole('OpenGL 3.3'));
    Titel.Draw(Edit1.Text);
    Enabled := True;

    ObjectMatrix := m;

    // Cube

    ObjectMatrix.RotateA(Pi / 8);
    ObjectMatrix.RotateB(Pi / 8);
    ObjectMatrix.Translate(1.0, 0.0, 0.0);
    Cube.Draw();

    // Rottext

    ObjectMatrix := m;
    //    ObjectMatrix.Translate(3.0, 0.0, 0.0);
    ObjectMatrix.Scale(0.4);
    ObjectMatrix := ObjectMatrix * RotTextMatrix;
    RotText.Draw(IntToStr(Zaehler));

    ObjectMatrix := m;
    //    ObjectMatrix.Translate(3.0, 0.0, 0.0);
    ObjectMatrix.Scale(0.4);

    ObjectMatrix.RotateA(Pi);
    ObjectMatrix := ObjectMatrix * RotTextMatrix;
    RotText.Draw(IntToStr(Zaehler));

    ObjectMatrix := m;
  end;

  OpenGL.SwapBuffers;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGL := TOpenGL.Create(Self);
  FontMatrix.Identity;
  RotTextMatrix.Identity;
  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenGL.Free;

  Cube.Free;
  FontQuad.Free;
  Titel.Free;

  RotText.Free;

  texBackGround.Free;
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin
  OpenGL.Camera.ModifKey(Key);
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
begin
  if WheelDelta < 0 then begin
    OpenGL.Camera.Scale(1.1);
  end else begin
    OpenGL.Camera.Scale(0.9);
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
  OpenGL.Camera.Perspective(30, ClientWidth / ClientHeight, 0.01, 700, -50.0, 0.2);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  FontQuad.Font.Size := FontQuad.Font.Size + 1;
  FontQuad.WriteVertex;
  Caption := IntToStr(FontQuad.Font.Size);
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  FontQuad.Font.Size := FontQuad.Font.Size - 1;
  FontQuad.WriteVertex;
  Caption := IntToStr(FontQuad.Font.Size);
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  //  TMaterialShader.LightParams.Position := vec4(-5 + Random(10), -5 + Random(10), -5 + Random(10), 0.0);
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  if FontDialog1.Execute then begin
    FontQuad.Font.Assign(FontDialog1.Font);
    FontQuad.Font.Quality := fqNonAntialiased;
    FontQuad.WriteVertex;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  //  OpenGL.Camera.ObjectMatrix.RotateC(Pi / 350);
  FontMatrix.RotateC(Pi / 350);
  RotTextMatrix.RotateB(Pi / 100);
  RenderScene;
end;

end.
