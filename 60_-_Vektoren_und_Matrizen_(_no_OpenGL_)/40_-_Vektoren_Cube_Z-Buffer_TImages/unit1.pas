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
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    bit: TBitmap;
    Matrix,
    ObjectMatrix,
    RotMatrix,
    WorldMatrix,
    FrustumMatrix: TMatrix;
    procedure PutPixel(x, y: integer; col: TColor);
    procedure LineX(x0, x1, y, z0, z1: single; col0, col1: TVector4f);
    procedure Triangle(v0, v1, v2: TVector4f; colA, colB, colC: TVector4f);
    procedure DrawScene;
  public

  end;

var
  Form1: TForm1;

  scale,
  ofsx, ofsy: integer;
  zBuffer: array of single;

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
  //CubeColor: TCube =
  //  (((1.0, 0.5, 0.5), (1.0, 0.7, 0.5), (1.0, 0.5, 0.5)), ((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (1.0, 0.7, 0.0)),
  //  ((0.5, 1.0, 0.5), (0.5, 0.7, 0.5), (0.5, 1.0, 0.5)), ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.7, 0.0)),
  //  ((0.5, 0.0, 1.0), (0.5, 0.7, 1.0), (0.5, 0.5, 1.0)), ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.7, 1.0)),
  //  ((0.5, 1.0, 1.0), (0.5, 0.7, 1.0), (0.5, 1.0, 1.0)), ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 0.7, 1.0)),
  //  // oben
  //  ((1.0, 1.0, 0.5), (1.0, 0.7, 0.5), (1.0, 1.0, 0.5)), ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (1.0, 0.7, 0.0)),
  //  // unten
  //  ((1.0, 0.5, 1.0), (1.0, 0.7, 1.0), (1.0, 0.5, 1.0)), ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (1.0, 0.7, 1.0)));
CubeColor: TCube =
  (((1.0, 0.0, 0.0), (1.0, 0.7, 0.7), (1.0, 0.0, 0.0)), ((1.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.3, 0.0, 0.0)),
  ((0.0, 1.0, 0.0), (0.7, 1.0, 0.7), (0.0, 1.0, 0.0)), ((0.0, 1.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.3, 0.0)),
  ((0.0, 0.0, 1.0), (0.7, 0.7, 1.0), (0.0, 0.0, 1.0)), ((0.0, 0.0, 1.0), (0.0, 0.0, 1.0), (0.0, 0.0, 0.3)),
  ((0.0, 1.0, 1.0), (0.7, 1.0, 1.0), (0.0, 1.0, 1.0)), ((0.0, 1.0, 1.0), (0.0, 1.0, 1.0), (0.0, 0.3, 0.3)),
  // oben
  ((1.0, 1.0, 0.0), (1.0, 1.0, 0.7), (1.0, 1.0, 0.0)), ((1.0, 1.0, 0.0), (1.0, 1.0, 0.0), (0.3, 0.3, 0.0)),
  // unten
  ((1.0, 0.0, 1.0), (1.0, 0.7, 1.0), (1.0, 0.0, 1.0)), ((1.0, 0.0, 1.0), (1.0, 0.0, 1.0), (0.3, 0.0, 0.3)));

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  bit := TBitmap.Create;

  Color := clBlack;
  FrustumMatrix.Frustum(-1, 1, -1, 1, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -150);
  WorldMatrix.Scale(10.0);

  RotMatrix.Identity;

  ObjectMatrix.Identity;
  ObjectMatrix.Translate(-0.5, -0.5, -0.5);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Bit.Free;
end;

procedure TForm1.PutPixel(x, y: integer; col: TColor);
type
  PColor = ^TColor;
begin
  if (x < 0) or (y < 0) or (x > ClientWidth) or (y > ClientHeight) then Exit; // y<0 ??
  PColor(bit.RawImage.GetLineStart(y))[x] := col;
end;

procedure TForm1.LineX(x0, x1, y, z0, z1: single; col0, col1: TVector4f);
var
  ofs, i: integer;
  len: single;
  addc,
  c: TVector4f;
  addz,
  z: single;

begin
  if x0 > x1 then begin
    SwapglFloat(x0, x1);
    SwapVertex4f(col0, col1);
    SwapglFloat(z0, z1);
  end;

  len := x1 - x0;

  addc := (col1 - col0) / len;
  addc.w := 0.0;
  c := col0;
  c.w := 0.0;

  addz := (z1 - z0) / len;
  z := z0;

  for i := trunc(x0) to trunc(x1) do begin

    ofs := i + trunc(y) * ClientWidth;
    if (ofs >= 0) and (ofs < Length(zBuffer)) then begin

      if z < zBuffer[ofs] then begin
        PutPixel(i, trunc(y), c.ToInt);
        zBuffer[ofs] := z;
      end;

    end;

    c := c + addc;
    z := z + addz;
  end;
end;

procedure TForm1.Triangle(v0, v1, v2: TVector4f; colA, colB, colC: TVector4f);
var
  y: integer;
  len_part, len_tot,
  x1, x2, x3: single;        { x-Werte für Scanline-Algorithmus     }
  m1, m2, m3: single;        { Increments für die x-Werte           }

  addc_part, addc_tot,
  c0, c1: TVector4f;

  addz_part, addz_tot,
  z0, z1: single;

begin
  v0 := Matrix * v0;
  v0.x := v0.x / v0.w * scale + ofsx;
  v0.y := v0.y / v0.w * scale + ofsy;

  v1 := Matrix * v1;
  v1.x := v1.x / v1.w * scale + ofsx;
  v1.y := v1.y / v1.w * scale + ofsy;

  v2 := Matrix * v2;
  v2.x := v2.x / v2.w * scale + ofsx;
  v2.y := v2.y / v2.w * scale + ofsy;


  //colA:=vec4(1,0,0,0);
  //colB:=vec4(0,1,0,0);
  //colC:=vec4(0,0,1,0);

  if (v0.y > v1.y) then begin
    SwapVertex4f(v0, v1);
    SwapVertex4f(colA, colB);
  end;
  if (v1.y > v2.y) then begin
    SwapVertex4f(v1, v2);
    SwapVertex4f(colB, colC);
  end;
  if (v0.y > v1.y) then begin
    SwapVertex4f(v0, v1);
    SwapVertex4f(colA, colB);
  end;

  x1 := v0.x;                                    { x-Wert Linie v0 -> v1   }
  x2 := v1.x;                                    { x-Wert Linie v1 -> c0   }
  x3 := v0.x;                                    { x-Wert Linie v0 -> c0   }

  m1 := (v1.x - v0.x) / (v1.y - v0.y);                      { Increments   v0 -> v1   }
  m2 := (v1.x - v2.x) / (v1.y - v2.y);                      { Increments   v1 -> c0   }
  m3 := (v2.x - v0.x) / (v2.y - v0.y);                      { Increments   v0 -> c0   }

  len_tot := v2.y - v0.y;

  // erste Teilfläche
  len_part := v1.y - v0.y;

  addc_part := (colB - colA) / len_part;
  c0 := colA;
  addc_tot := (colC - colA) / len_tot;
  c1 := colA;

  addz_part := (v1.z - v0.z) / len_part;
  z0 := v0.z;
  addz_tot := (v2.z - v0.z) / len_tot;
  z1 := v0.z;

  for y := trunc(v0.y) to trunc(v0.y + len_part) - 1 do begin
    LineX(x1, x3, y, z0, z1, c0, c1);
    x1 := x1 + m1;
    x3 := x3 + m3;

    c0 := c0 + addc_part;
    c1 := c1 + addc_tot;

    z0 := z0 + addz_part;
    z1 := z1 + addz_tot;
  end;

  // zweite Teilfläche
  len_part := v2.y - v1.y;

  addc_part := (colC - colB) / len_part;
  c0 := colB;

  addz_part := (v2.z - v1.z) / len_part;
  z0 := v1.z;

  for y := trunc(v1.y) to trunc(v1.y + len_part) - 1 do begin
    LineX(x2, x3, y, z0, z1, c0, c1);
    x2 := x2 + m2;
    x3 := x3 + m3;

    c0 := c0 + addc_part;
    c1 := c1 + addc_tot;

    z0 := z0 + addz_part;
    z1 := z1 + addz_tot;
  end;
end;

procedure TForm1.DrawScene;
var
  i, x, y, z: integer;
  TempMatrix: TMatrix;
const
  d = 2.7;
  s = 1;
begin
  SetLength(zBuffer, ClientWidth * ClientHeight);
  for i := 0 to Length(zBuffer) - 1 do begin
    zBuffer[i] := 1000;
  end;

  TempMatrix := FrustumMatrix * WorldMatrix * RotMatrix;

  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);                 // Matrix verschieben.
        Matrix := TempMatrix * Matrix;

        for i := 0 to Length(CubeVertex) - 1 do begin
          Triangle(
            vec4(CubeVertex[i, 0], 1.0), vec4(CubeVertex[i, 1], 1.0), vec4(CubeVertex[i, 2], 1.0),
            vec4(CubeColor[i, 0], 1.0), vec4(CubeColor[i, 1], 1.0), vec4(CubeColor[i, 2], 1.0));
        end;
      end;
    end;
  end;

end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  Canvas.Draw(0, 0, bit);
  WriteLn(bit.PixelFormat);

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  with bit do begin
    Width := ClientWidth;
    Height := ClientHeight;
  end;

  scale := ClientHeight div 2;
  ofsx := ClientWidth div 2;
  ofsy := ClientHeight div 2;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  StepB = 0.023;
  StepC = 0.014;
var
  p:PByte;
begin
  RotMatrix.RotateC(StepC);
  RotMatrix.RotateB(StepB);

  p:=bit.RawImage.Data;
  bit.BeginUpdate();
  FillDWord(p^, bit.RawImage.DataSize div 4, vec3(1.0, 0.0 ,0.0).ToInt);
  DrawScene;
  bit.EndUpdate();

  Invalidate;
end;

end.
