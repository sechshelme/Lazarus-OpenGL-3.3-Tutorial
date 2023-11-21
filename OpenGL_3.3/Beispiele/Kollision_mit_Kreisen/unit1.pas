unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, oglVector;

type

  { TForm1 }

  TForm1 = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Panel1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    function KollisionTest(ASelf: integer): boolean;
  private

  public

  end;

var
  Form1: TForm1;

type
  TKreis = record
    DirVector,
    PosVector: TVector2f;
    Radius: single;
    Color: TColor;
  end;

  TKreise = array[0..49] of TKreis;

var
  Kreise: TKreise;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const
  rad = 20;
var
  i: integer;
begin
  DoubleBuffered := True;
  Randomize;
  for i := 0 to Length(Kreise) - 1 do begin
    with Kreise[i] do begin
      DirVector[0] := Random * 3;
      DirVector[1] := Random * 3;
    end;
    Color := clWhite;
  end;
  for i := 0 to Length(Kreise) - 1 do begin
    with Kreise[i] do begin
      repeat
        Radius := Random(rad) + rad / 2;
        PosVector[0] := Random * Panel1.Width;
        PosVector[1] := Random * Panel1.Height;
      until KollisionTest(i) = False;
    end;
  end;
end;

procedure TForm1.Panel1Paint(Sender: TObject);
var
  i: integer;
begin
  Panel1.Canvas.Brush.Color := clBackground;
  Panel1.Canvas.Clear;
  for i := 0 to Length(Kreise) - 1 do begin
    with Kreise[i] do begin
      Panel1.Canvas.Brush.Color := Color;
      Panel1.Canvas.Ellipse(round(PosVector[0] - Radius), round(PosVector[1] - Radius), round(PosVector[0] + Radius), round(PosVector[1] + Radius));
    end;
  end;
end;

function TForm1.KollisionTest(ASelf: integer): boolean;
var
  i: integer;
  v: TVector2f;
begin
  Result := False;
  for i := 0 to Length(Kreise) - 1 do begin
    if i <> ASelf then begin
      if (Kreise[ASelf].PosVector - Kreise[i].PosVector).Length < Kreise[ASelf].Radius + Kreise[i].Radius then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
  posalt: TVector2f;
begin
  for i := 0 to Length(Kreise) - 1 do begin
    with Kreise[i] do begin
      Color := clWhite;
      posalt := PosVector;
      PosVector[0] += DirVector[0];
      PosVector[1] += DirVector[1];
      if (PosVector[0] < 0) or (PosVector[0] > Panel1.Width) then begin
        DirVector[0] *= -1;
        PosVector := posalt;
      end;
      if (PosVector[1] < 0) or (PosVector[1] > Panel1.Height) then begin
        DirVector[1] *= -1;
        PosVector := posalt;
      end;
      if KollisionTest(i) then begin
        DirVector[0] *= -1;
        DirVector[1] *= -1;
        PosVector := posalt;
        Color := clRed;
      end;
    end;
  end;
  Invalidate;
end;

end.
