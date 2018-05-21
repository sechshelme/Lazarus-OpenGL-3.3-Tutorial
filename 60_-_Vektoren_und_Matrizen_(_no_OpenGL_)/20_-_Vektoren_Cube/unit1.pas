unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    ObjectMatrix,
    RotMatrix,
    WorldMatrix,
    FrustumMatrix: TMatrix;
    procedure DrawLine(p0, p1: TVector3f);

  public

  end;

var
  Form1: TForm1;

  ofsx,  ofsy : Integer;

const
  Cube: array[0..23] of TVector3f = (
    // unten
    (0, 0, 0), (1, 0, 0), (1, 0, 0), (1, 1, 0), (1, 1, 0), (0, 1, 0), (0, 1, 0), (0, 0, 0),
    // Säulen
    (0, 0, 0), (0, 0, 1), (0, 1, 0), (0, 1, 1), (1, 0, 0), (1, 0, 1), (1, 1, 0), (1, 1, 1),
    //oben
    (0, 0, 1), (1, 0, 1), (1, 0, 1), (1, 1, 1), (1, 1, 1), (0, 1, 1), (0, 1, 1), (0, 0, 1));

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FrustumMatrix.Frustum(-1, 1, -1, 1, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200);
  WorldMatrix.Scale(5.0);

  RotMatrix.Identity;

  ObjectMatrix.Identity;
  ObjectMatrix.Translate(-0.5, -0.5, -0.5);
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i: integer;
  p: TVector2f;
begin
  Canvas.Pen.Color := clYellow;
  Canvas.Line(ofsx, 0, ofsx, ofsy*2);
  Canvas.Line(0, ofsy, ofsx*2, ofsy);
  Canvas.Pen.Color := clBlack;

  for i := 0 to Length(Cube) div 2 - 1 do begin
    DrawLine(Cube[i * 2 + 0], Cube[i * 2 + 1]);
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  ofsx:=ClientWidth div 2;
  ofsy:=ClientHeight div 2;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  StepB = 0.023;
  StepC = 0.014;
begin
  RotMatrix.RotateC(StepC);
  RotMatrix.RotateB(StepB);
  Invalidate;
end;

procedure TForm1.DrawLine(p0, p1: TVector3f);
const
  scale = 200;
var
  m: TMatrix;
  p: TVector4f;

var
  x, y, z: integer;
const
  d = 2.7;
  s = 2;

begin
  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        m.Identity;
        m.Translate(x * d, y * d, z * d);                 // Matrix verschieben.

//        m := FrustumMatrix * WorldMatrix * RotMatrix * ObjectMatrix;
        m := FrustumMatrix * WorldMatrix * RotMatrix * m;

        p := m.Vektor_Multi(vec4(p0, 1.0));
        Canvas.MoveTo(ofsx + round(p.x / p.w * scale), ofsy + round(p.y / p.w * scale));

        p := m.Vektor_Multi(vec4(p1, 1.0));
        Canvas.LineTo(ofsx + round(p.x / p.w * scale), ofsy + round(p.y / p.w * scale));
      end;
    end;
  end;

end;

end.
