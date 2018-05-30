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
    Matrix,
    ObjectMatrix,
    RotMatrix,
    WorldMatrix,
    FrustumMatrix: TMatrix;
    procedure DrawTriangle(p, c: Tmat3x3);
    procedure LineX(x0, x1, y: single; col0, col1: TVector4f);
    procedure Triangle(a, b, c: TVector4f; colA, colB, colC: TVector4f);
  public

  end;

var
  Form1: TForm1;

  scale,
  ofsx, ofsy: integer;

type
  TCube = array[0..11] of Tmat3x3;


const
  CubeVertex: TCube =
    (((-0.5, 0.5, 0.5), (-0.5, -0.5, 0.5), (0.5, -0.5, 0.5)), ((-0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, 0.5, 0.5)),
    ((0.5, 0.5, 0.5), (0.5, -0.5, 0.5), (0.5, -0.5, -0.5)), ((0.5, 0.5, 0.5), (0.5, -0.5, -0.5), (0.5, 0.5, -0.5)),
    ((0.5, 0.5, -0.5), (0.5, -0.5, -0.5), (-0.5, -0.5, -0.5)), ((0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, 0.5, -0.5)),
    ((-0.5, 0.5, -0.5), (-0.5, -0.5, -0.5), (-0.5, -0.5, 0.5)), ((-0.5, 0.5, -0.5), (-0.5, -0.5, 0.5), (-0.5, 0.5, 0.5)),
    // oben
    ((0.5, 0.5, 0.5), (0.5, 0.5, -0.5), (-0.5, 0.5, -0.5)), ((0.5, 0.5, 0.5), (-0.5, 0.5, -0.5), (-0.5, 0.5, 0.5)),
    // unten
    ((-0.5, -0.5, 0.5), (-0.5, -0.5, -0.5), (0.5, -0.5, -0.5)), ((-0.5, -0.5, 0.5), (0.5, -0.5, -0.5), (0.5, -0.5, 0.5)));
  CubeColor: TCube =
    (((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.0, 0.0)), ((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.0, 0.0)),
    ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 1.0, 0.0)), ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 1.0, 0.0)),
    ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0)), ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 1.0)),
    ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 1.0, 1.0)), ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 1.0, 1.0)),
    // oben
    ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 1.0, 0.0)), ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 1.0, 0.0)),
    // unten
    ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 1.0)), ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.0, 1.0)));

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FrustumMatrix.Frustum(-1, 1, -1, 1, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -200);
  WorldMatrix.Scale(10.0);

  RotMatrix.Identity;

  ObjectMatrix.Identity;
  ObjectMatrix.Translate(-0.5, -0.5, -0.5);
end;

procedure TForm1.LineX(x0, x1, y: single; col0, col1: TVector4f);
var
  x,
  len: single;
  cdif,
  c: TVector4f;

begin
  if x0 > x1 then begin
    SwapglFloat(x0, x1);
    SwapVertex4f(col0, col1);
  end;

  len := x1 - x0;
  cdif := col1 - col0;
  x := x0;

  repeat
    c := col0 + cdif / (len / (x - x0));
    c.w := 0;  // Alpha-Kanal
    Canvas.Pixels[trunc(x), trunc(y)] := c.ToInt;

    x := x + 1.0
  until x > x1;
  Canvas.Pixels[trunc(x1), trunc(y)] := c.ToInt;
end;

procedure TForm1.Triangle(a, b, c: TVector4f; colA, colB, colC: TVector4f);
var
  y: integer;
  len_part, len_tot,
  x1, x2, x3: single;        { x-Werte für Scanline-Algorithmus     }
  m1, m2, m3: single;        { Increments für die x-Werte           }
  addc_part, addc_tot,
  c0, c1: TVector4f;

begin
  //colA:=vec4(1,0,0,0);
  //colB:=vec4(0,1,0,0);
  //colC:=vec4(0,0,1,0);

  if (a.y > b.y) then begin
    SwapglFloat(a[1], b[1]);
    SwapglFloat(a[0], b[0]);
    SwapVertex4f(colA, colB);
  end;
  if (b.y > c.y) then begin
    SwapglFloat(b[1], c[1]);
    SwapglFloat(b[0], c[0]);
    SwapVertex4f(colB, colC);
  end;
  if (a.y > b.y) then begin
    SwapglFloat(a[1], b[1]);
    SwapglFloat(a[0], b[0]);
    SwapVertex4f(colA, colB);
  end;

  x1 := a.x;                                    { x-Wert Linie A -> B   }
  x2 := b.x;                                    { x-Wert Linie B -> c0   }
  x3 := a.x;                                    { x-Wert Linie A -> c0   }

  m1 := (b.x - a.x) / (b.y - a.y);                      { Increments   A -> B   }
  m2 := (b.x - c.x) / (b.y - c.y);                      { Increments   B -> c0   }
  m3 := (c.x - a.x) / (c.y - a.y);                      { Increments   A -> c0   }

  len_tot := c.y - a.y;

  // erste Teilfläche
  len_part := b.y - a.y;

  addc_part := (colB - colA) / len_part;
  c0 := colA;

  addc_tot := (colC - colA) / len_tot;
  c1 := colA;

  for y := trunc(a.y) to trunc(a.y + len_part) do begin
    LineX(x1, x3, y, c0, c1);
    x1 := x1 + m1;
    x3 := x3 + m3;

    c0 := c0 + addc_part;
    c1 := c1 + addc_tot;
  end;

  // zweite Teilfläche
  len_part := c.y - b.y;

  addc_part := (colC - colB) / len_part;
  c0 := colB;

  for y := trunc(b.y) to trunc(b.y + len_part) do begin
    LineX(x2, x3, y, c0, c1);
    x2 := x2 + m2;
    x3 := x3 + m3;

    c0 := c0 + addc_part;
    c1 := c1 + addc_tot;
  end;
end;


procedure TForm1.DrawTriangle(p, c: Tmat3x3);
var
  v0, v1, v2: TVector4f;

begin
  v0 := Matrix * vec4(p[0], 1.0);
  v0.x := v0.x / v0.w * scale + ofsx;
  v0.y := v0.y / v0.w * scale + ofsy;

  v1 := Matrix * vec4(p[1], 1.0);
  v1.x := v1.x / v1.w * scale + ofsx;
  v1.y := v1.y / v1.w * scale + ofsy;

  v2 := Matrix * vec4(p[2], 1.0);
  v2.x := v2.x / v2.w * scale + ofsx;
  v2.y := v2.y / v2.w * scale + ofsy;


  //Canvas.MoveTo(trunc(v0.x), trunc(v0.y));
  //Canvas.LineTo(trunc(v1.x), trunc(v1.y));
  //Canvas.LineTo(trunc(v2.x), trunc(v2.y));
  //Canvas.LineTo(trunc(v0.x), trunc(v0.y));

  Triangle(v0, v1, v2, vec4(c[0], 1.0), vec4(c[1], 1.0), vec4(c[2], 1.0));
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i: integer;
  TempMatrix: TMatrix;
var
  x, y, z: integer;
const
  d = 2.7;
  s = 1;

begin
  Canvas.Pen.Color := clYellow;
  Canvas.Line(ofsx, 0, ofsx, ofsy * 2);
  Canvas.Line(0, ofsy, ofsx * 2, ofsy);
  Canvas.Pen.Color := clBlack;

  TempMatrix := FrustumMatrix * WorldMatrix * RotMatrix;

  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.
        Matrix := TempMatrix * Matrix;

        for i := 0 to Length(CubeVertex) - 1 do begin
          DrawTriangle(CubeVertex[i], CubeColor[i]);
        end;
      end;
    end;
  end;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  scale := ClientHeight div 2;
  ofsx := ClientWidth div 2;
  ofsy := ClientHeight div 2;
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

end.
