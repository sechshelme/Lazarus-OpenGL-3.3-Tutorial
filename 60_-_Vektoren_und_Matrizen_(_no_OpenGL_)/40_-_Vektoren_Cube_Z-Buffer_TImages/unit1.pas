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
    procedure Triangle(v0, v1, v2: TVector4f; col0, col1, col2: TVector4f);
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
  DoubleBuffered := True;
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
  if (x < 0) or (y < 0) or (x > ClientWidth) or (y > ClientHeight) then begin
    Exit;
  end; // y<0 ??
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

procedure TForm1.Triangle(v0, v1, v2: TVector4f; col0, col1, col2: TVector4f);
var
  y: integer;
  dif,

  addx_0, addx_1, addx_2,
  x0, x1, x2: single;

  addz_0, addz_1, addz_2,
  z0, z1, z2: single;

  addc_0, addc_1, addc_2,
  c0, c1, c2: TVector4f;

begin
  //col0 := vec4(1, 0, 0, 0);
  //col1 := vec4(0, 1, 0, 0);
  //col2 := vec4(0, 0, 1, 0);

  v0 := Matrix * v0;
  v1 := Matrix * v1;
  v2 := Matrix * v2;


  v0.x := v0.x / v0.w * scale + ofsx;
  v0.y := v0.y / v0.w * scale + ofsy;

  v1.x := v1.x / v1.w * scale + ofsx;
  v1.y := v1.y / v1.w * scale + ofsy;

  v2.x := v2.x / v2.w * scale + ofsx;
  v2.y := v2.y / v2.w * scale + ofsy;

  if (v0.y > v1.y) then begin
    SwapVertex4f(v0, v1);
    SwapVertex4f(col0, col1);
  end;
  if (v1.y > v2.y) then begin
    SwapVertex4f(v1, v2);
    SwapVertex4f(col1, col2);
  end;
  if (v0.y > v1.y) then begin
    SwapVertex4f(v0, v1);
    SwapVertex4f(col0, col1);
  end;

  dif := v1.y - v0.y;
  addx_0 := (v1.x - v0.x) / dif;
  x0 := v0.x;
  addz_0 := (v1.z - v0.z) / dif;
  z0 := v0.z;
  addc_0 := (col1 - col0) / dif;
  c0 := col0;

  dif := v1.y - v2.y;
  addx_1 := (v1.x - v2.x) / dif;
  x1 := v1.x;
  addz_1 := (v1.z - v2.z) / dif;
  z1 := v1.z;
  addc_1 := (col1 - col2) / dif;
  c1 := col1;

  dif := v2.y - v0.y;
  addx_2 := (v2.x - v0.x) / dif;
  x2 := v0.x;
  addz_2 := (v2.z - v0.z) / dif;
  z2 := v0.z;
  addc_2 := (col2 - col0) / dif;
  c2 := col0;


  // erste Teilfläche
  for y := trunc(v0.y) to trunc(v1.y) - 1 do begin
    LineX(x0, x2, y, z0, z2, c0, c2);
    x0 += addx_0;
    x2 += addx_2;

    c0 += addc_0;
    c2 += addc_2;

    z0 += addz_0;
    z2 += addz_2;
  end;

  // zweite Teilfläche
  for y := trunc(v1.y) to trunc(v2.y) - 1 do begin
    LineX(x1, x2, y, z1, z2, c1, c2);
    x1 += addx_1;
    x2 += addx_2;

    c1 += addc_1;
    c2 += addc_2;

    z1 += addz_1;
    z2 += addz_2;
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
//  WriteLn(bit.PixelFormat);
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
  p: PByte;
begin
  RotMatrix.RotateC(StepC);
  RotMatrix.RotateB(StepB);

  p := bit.RawImage.Data;
  bit.BeginUpdate();
  FillDWord(p^, bit.RawImage.DataSize div 4, vec3(1.0, 0.0, 0.0).ToInt);
  DrawScene;
  bit.EndUpdate();

  Invalidate;
end;

end.
