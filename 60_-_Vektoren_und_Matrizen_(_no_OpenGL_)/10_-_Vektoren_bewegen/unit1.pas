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
    procedure Timer1Timer(Sender: TObject);
  private
    RotMatrix,
    CameraMatrix: TMatrix2D;
    procedure DrawLine(p0, p1: TVector2f);

  public

  end;

var
  Form1: TForm1;

const
  Quad: array[0..7] of TVector2f = ((0, 0), (1, 0), (1, 0), (1, 1), (1, 1), (0, 1), (0, 1), (0, 0));

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  CameraMatrix.Identity;
  CameraMatrix.Scale(20);

  RotMatrix.Identity;

end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i: integer;
  p: TVector2f;
begin
  for i := 0 to Length(Quad) div 2 - 1 do begin
    DrawLine(Quad[i * 2 + 0], Quad[i * 2 + 1]);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  Step = 0.4;
begin
  RotMatrix.Rotate(Step);
  Invalidate;
end;

procedure TForm1.DrawLine(p0, p1: TVector2f);
const
  ofsx = 100;
  ofsy = 100;
var
  m: TMatrix2D;
begin
  m := CameraMatrix * RotMatrix;
  p0 := m.Vektor_Multi(vec3(p0, 1.0)).xy;
  Canvas.MoveTo(ofsx + round(p0.x), ofsy + round(p0.y));

  p1 := m.Vektor_Multi(vec3(p1, 1.0)).xy;
  Canvas.LineTo(ofsx + round(p1.x), ofsy + round(p1.y));
end;

end.
