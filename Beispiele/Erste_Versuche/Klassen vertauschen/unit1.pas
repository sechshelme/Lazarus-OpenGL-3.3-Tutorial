unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Forms,
  ExtCtrls,
  SysUtils,
  Buttons,
  OpenGLContext,
  dglOpenGL,
  oglUnit,
 oglVector, oglMatrix,
  oglVAO, oglKoerper,
  Controls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private   { private declarations }
    OpenGL: TOpenGL;

    Cylinder: array[0..2] of TCylinder;

//    Matrix: TMatrix;
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
  Cylinder[0] := TCylinder.Create;
  Cylinder[0].Sektoren := 3;
  Cylinder[0].Color := vec4(1, 1, 0, 1);
  Cylinder[0].WriteVertex;

  Cylinder[1] := TCylinder.Create;
  Cylinder[1].Sektoren := 4;
  Cylinder[1].Color := vec4(1, 0, 1, 1);
  Cylinder[1].WriteVertex;

  Cylinder[2] := TCylinder.Create;
  Cylinder[2].Sektoren := 6;
  Cylinder[2].Color := vec4(0, 1, 1, 1);
  Cylinder[2].WriteVertex;

  OpenGL.Camera.Scale(0.15);
end;

procedure TForm1.RenderScene;
var
  m: TMatrix;
begin
  OpenGL.Clear;

  with OpenGL.Camera do begin
    m := ObjectMatrix;
    ObjectMatrix.RotateC(Pi / 2);
    ObjectMatrix.Translate(-4, 0, 0);
    Cylinder[0].Draw;

    ObjectMatrix := m;

    Cylinder[1].Draw;

    ObjectMatrix.RotateC(-Pi / 2);
    ObjectMatrix.Translate(4, 0, 0);
    Cylinder[2].Draw;

    ObjectMatrix := m;
    OpenGL.SwapBuffers;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenGL := TOpenGL.Create(Self);

  InitScene;
  Timer1.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  OpenGL.Free;
  for i := 0 to Length(Cylinder) - 1 do begin
    FreeAndNil(Cylinder[i]);
  end;
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: char); inline;
begin
  OpenGL.Camera.ModifKey(Key);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  OpenGL.Resize(ClientWidth, ClientHeight);
end;

procedure TForm1.SpeedButtonClick(Sender: TObject);

  procedure SwapCylinder(var C1, C2: TCylinder); inline;
  var
    dummy: TCylinder;
  begin
    dummy := C1;
    C1 := C2;
    C2 := dummy;
  end;

begin
  case TSpeedButton(Sender).Name of
    'SpeedButton1': begin
      SwapCylinder(Cylinder[0], Cylinder[1]);
    end;
    'SpeedButton2': begin
      SwapCylinder(Cylinder[1], Cylinder[2]);
    end;
    'SpeedButton3': begin
      SwapCylinder(Cylinder[0], Cylinder[2]);
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with OpenGL.Camera do begin
    ObjectMatrix.RotateB(Pi / 200);
    ObjectMatrix.RotateC(Pi / 220);
    RenderScene;
  end;
end;

end.
