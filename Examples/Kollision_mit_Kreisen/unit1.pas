unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type
  TVector2f = array[0..1] of single;

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    function CollisiosTest(ASelf: integer): boolean;
  end;

var
  Form1: TForm1;

type
  TCircle = record
    DirVector,
    PosVector: TVector2f;
    Radius: single;
    Color: TColor;
  end;

  TCircles = array[0..49] of TCircle;

var
  Kreise: TCircles;

implementation

{$R *.lfm}

function Vec2_sub(const v0, v1: TVector2f): TVector2f;
begin
  Result[0] := v0[0] - v1[0];
  Result[1] := v0[1] - v1[1];
end;

function Vec2_Length(const self: TVector2f): single;
begin
  Result := sqrt(sqr(Self[0]) + sqr(Self[1]));
end;



{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const
  rad = 20;
var
  i: integer;
begin
  ClientWidth := 640;
  ClientHeight := 400;
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
        PosVector[0] := Random * ClientWidth;
        PosVector[1] := Random * ClientHeight;
      until CollisiosTest(i) = False;
    end;
  end;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i: integer;
begin
  Color := $401020;
  for i := 0 to Length(Kreise) - 1 do begin
    with Kreise[i] do begin
      Canvas.Brush.Color := Color;
      Canvas.Ellipse(round(PosVector[0] - Radius), round(PosVector[1] - Radius), round(PosVector[0] + Radius), round(PosVector[1] + Radius));
    end;
  end;
end;

function TForm1.CollisiosTest(ASelf: integer): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to Length(Kreise) - 1 do begin
    if i <> ASelf then begin
      if Vec2_Length(Vec2_sub(Kreise[ASelf].PosVector, Kreise[i].PosVector)) < Kreise[ASelf].Radius + Kreise[i].Radius then begin
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
      posalt := PosVector;
      PosVector[0] += DirVector[0];
      PosVector[1] += DirVector[1];
      if (PosVector[0] < 0) or (PosVector[0] > ClientWidth) then begin
        DirVector[0] *= -1;
        PosVector := posalt;
      end;
      if (PosVector[1] < 0) or (PosVector[1] > ClientHeight) then begin
        DirVector[1] *= -1;
        PosVector := posalt;
      end;
      if CollisiosTest(i) then begin
        DirVector[0] *= -1;
        DirVector[1] *= -1;
        PosVector := posalt;
        Color := clRed;
      end else begin
        Color := clYellow;
      end;;
    end;
  end;
  Invalidate;
end;

end.
