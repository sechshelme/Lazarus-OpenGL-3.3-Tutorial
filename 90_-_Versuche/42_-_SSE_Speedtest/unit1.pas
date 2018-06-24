unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FrameBuffer: TBitmap;
    Matrix,
    ObjectMatrix,
    RotMatrix,
    WorldMatrix,
    FrustumMatrix: TMatrix;
    procedure PutPixel(x, y: integer; col: TVector3f);
    procedure LineX(x0, x1, y, z0, z1: single; col0, col1: TVector3f);
    procedure Triangle(v0, v1, v2: TVector4f; col0, col1, col2: TVector3f);
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


{$asmmode intel}


function VectorMultiplySSE(const mat: TMatrix; const vec: TVector4f): TVector4f; assembler;
asm
         Movups  Xmm4, [mat + $00]
         Movups  Xmm5, [mat + $10]
         Movups  Xmm6, [mat + $20]
         Movups  Xmm7, [mat + $30]
         Movups  Xmm2, [vec]

         // Zeile 0
         Pshufd  Xmm0, Xmm2, 00000000b
         Mulps   Xmm0, Xmm4

         // Zeile 1
         Pshufd  Xmm1, Xmm2, 01010101b
         Mulps   Xmm1, Xmm5
         Addps   Xmm0, Xmm1

         // Zeile 2
         Pshufd  Xmm1, Xmm2, 10101010b
         Mulps   Xmm1, Xmm6
         Addps   Xmm0, Xmm1

         // Zeile 3
         Pshufd  Xmm1, Xmm2, 11111111b
         Mulps   Xmm1, Xmm7
         Addps   Xmm0, Xmm1

         Movups  [Result], Xmm0
end;

function MatrixMultiplySSE(const M0, M1: TMatrix): TMatrix; assembler;
asm
         Movups  Xmm4, [M0 + $00]
         Movups  Xmm5, [M0 + $10]
         Movups  Xmm6, [M0 + $20]
         Movups  Xmm7, [M0 + $30]

         // Spalte 0
         Movss   Xmm0, [M1 + $00]
         Shufps  Xmm0, Xmm0, 00000000b
         Mulps   Xmm0, Xmm4

         Movss   Xmm2, [M1 + $04]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm5
         Addps   Xmm0, Xmm2

         Movss   Xmm2, [M1 + $08]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm6
         Addps   Xmm0, Xmm2

         Movss   Xmm2, [M1 + $0C]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm7
         Addps   Xmm0, Xmm2

         Movups  [Result + $00], Xmm0

         // Spalte 1
         Movss   Xmm0, [M1 + $10]
         Shufps  Xmm0, Xmm0, 00000000b
         Mulps   Xmm0, Xmm4

         Movss   Xmm2, [M1 + $14]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm5
         Addps   Xmm0, Xmm2

         Movss   Xmm2, [M1 + $18]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm6
         Addps   Xmm0, Xmm2

         Movss   Xmm2, [M1 + $1C]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm7
         Addps   Xmm0, Xmm2

         Movups   [Result + $10], Xmm0

         // Spalte 2
         Movss   Xmm0, [M1 + $20]
         Shufps  Xmm0, Xmm0, 00000000b
         Mulps   Xmm0, Xmm4

         Movss   Xmm2, [M1 + $24]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm5
         Addps   Xmm0, Xmm2

         Movss   Xmm2, [M1 + $28]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm6
         Addps   Xmm0, Xmm2

         Movss   Xmm2, [M1 + $2C]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm7
         Addps   Xmm0, Xmm2

         Movups  [Result + $20], Xmm0

         // Spalte 3
         Movss   Xmm0, [M1 + $30]
         Shufps  Xmm0, Xmm0, 00000000b
         Mulps   Xmm0, Xmm4

         Movss   Xmm2, [M1 + $34]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm5
         Addps   Xmm0, Xmm2

         Movss   Xmm2, [M1 + $38]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm6
         Addps   Xmm0, Xmm2

         Movss   Xmm2, [M1 + $3C]
         Shufps  Xmm2, Xmm2, 00000000b
         Mulps   Xmm2, Xmm7
         Addps   Xmm0, Xmm2

         Movups  [Result + $30], Xmm0
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  FrameBuffer := TBitmap.Create;

  Color := clBlack;
  FrustumMatrix.Frustum(-1, 1, -1, 1, 2.5, 1000.0);

  WorldMatrix.Identity;
  WorldMatrix.Translate(0.0, 0.0, -150);
  WorldMatrix.Scale(10.0);

  RotMatrix.Identity;

  ObjectMatrix.Identity;
  ObjectMatrix.Translate(-0.5, -0.5, -0.5);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
  m, m0, m1: Tmat4x4;
  t: TTime;
const
  site = 20000001;


  procedure Ausgabe;
  var
    i: integer;
  begin
    for i := 0 to 3 do begin
      WriteLn(m0[i, 0]: 4: 2, '  ', m0[i, 1]: 4: 2, '  ', m0[i, 2]: 4: 2, '  ', m0[i, 3]: 4: 2);
    end;
    WriteLn();
  end;

  function GetZeit(z: TTime): string;
  begin
    str(z * 24 * 60 * 60: 10: 4, Result);
  end;

begin
  m0.Identity;
  m1.Identity;
  m1.RotateC(3.5);

  t := now;
  for i := 0 to site do begin
    m0 := m0 * m1;
  end;
  WriteLn('FPU:   ', GetZeit(now - t));
  Ausgabe;


  m0.Identity;
  m1.Identity;
  m1.RotateC(3.5);

  t := now;
  for i := 0 to site do begin
    m0 := MatrixMultiplySSE(m0, m1);
  end;
  WriteLn('SSE:    ', GetZeit(now - t));
  Ausgabe;

  WriteLn();
  WriteLn();
  WriteLn();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FrameBuffer.Free;
end;

procedure TForm1.PutPixel(x, y: integer; col: TVector3f);
var
  p: PByte;
  tc: TColor;
begin
  tc := col.ToInt;

  p := FrameBuffer.RawImage.GetLineStart(y);
  Inc(p, x * (FrameBuffer.RawImage.Description.BitsPerPixel div 8));
  p^ := tc shr 16;
  Inc(p);
  p^ := tc shr 8;
  Inc(p);
  p^ := tc;
end;

procedure TForm1.LineX(x0, x1, y, z0, z1: single; col0, col1: TVector3f);
var
  ofs, i, iy: integer;
  dif, addz, z: single;
  addc, c: TVector3f;

begin
  if (y < 0.0) or (y >= ClientHeight) then begin
    Exit;
  end;

  if x0 > x1 then begin
    SwapglFloat(x0, x1);
    SwapVertex3f(col0, col1);
    SwapglFloat(z0, z1);
  end;

  dif := x1 - x0;

  addz := (z1 - z0) / dif;
  z := z0;

  addc := (col1 - col0) / dif;
  c := col0;

  if x0 < 0.0 then begin
    c += addc * -x0;
    z += addz * -x0;
    x0 := 0.0;
  end;
  if x1 > ClientWidth then begin
    x1 := ClientWidth;
  end;

  iy := trunc(y);

  for i := trunc(x0) to trunc(x1) do begin

    ofs := i + iy * ClientWidth;

    if z < zBuffer[ofs] then begin
      PutPixel(i, iy, c);
      zBuffer[ofs] := z;
    end;

    c += addc;
    z += addz;
  end;
end;

procedure TForm1.Triangle(v0, v1, v2: TVector4f; col0, col1, col2: TVector3f);

var
  y: integer;
  dif,

  addx_0, addx_1, addx_2,
  x0, x1, x2: single;

  addz_0, addz_1, addz_2,
  z0, z1, z2: single;

  addc_0, addc_1, addc_2,
  c0, c1, c2: TVector3f;

begin
  //  VectorMultiplySSE(Matrix, v0, v0);
  //  VectorMultiplySSE(Matrix, v1, v1);
  //  VectorMultiplySSE(Matrix, v2, v2);

  v0 := VectorMultiplySSE(Matrix, v0);
  v1 := VectorMultiplySSE(Matrix, v1);
  v2 := VectorMultiplySSE(Matrix, v2);


  //    v0 := Matrix * v0;
  //v1 := Matrix * v1;
  //v2 := Matrix * v2;

  v0.x := v0.x / v0.w * scale + ofsx;
  v0.y := v0.y / v0.w * scale + ofsy;

  v1.x := v1.x / v1.w * scale + ofsx;
  v1.y := v1.y / v1.w * scale + ofsy;

  v2.x := v2.x / v2.w * scale + ofsx;
  v2.y := v2.y / v2.w * scale + ofsy;

  if (v0.y > v1.y) then begin
    SwapVertex4f(v0, v1);
    SwapVertex3f(col0, col1);
  end;
  if (v1.y > v2.y) then begin
    SwapVertex4f(v1, v2);
    SwapVertex3f(col1, col2);
  end;
  if (v0.y > v1.y) then begin
    SwapVertex4f(v0, v1);
    SwapVertex3f(col0, col1);
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


  // erstes Teildreieck
  for y := trunc(v0.y) to trunc(v1.y) - 1 do begin
    LineX(x0, x2, y, z0, z2, c0, c2);
    x0 += addx_0;
    x2 += addx_2;

    c0 += addc_0;
    c2 += addc_2;

    z0 += addz_0;
    z2 += addz_2;
  end;

  // zweites Teildreieck
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
  p: PByte;
  TempMatrix: TMatrix;
const
  d = 2.7;
  s = 3;
begin
  WriteLn(FrameBuffer.PixelFormat);
  WriteLn(FrameBuffer.RawImage.Description.BitsPerPixel);

  p := FrameBuffer.RawImage.Data;
  FillChar(p^, FrameBuffer.RawImage.DataSize, $00);

  SetLength(zBuffer, ClientWidth * ClientHeight);
  for i := 0 to Length(zBuffer) - 1 do begin
    zBuffer[i] := 1000;
  end;

  // TempMatrix := FrustumMatrix * WorldMatrix * RotMatrix;
  TempMatrix := MatrixMultiplySSE(WorldMatrix, RotMatrix);
  TempMatrix := MatrixMultiplySSE(FrustumMatrix, TempMatrix);

  for x := -s to s do begin
    for y := -s to s do begin
      for z := -s to s do begin
        Matrix.Identity;
        Matrix.Translate(x * d, y * d, z * d);

        //        Matrix := TempMatrix * Matrix;
        Matrix := MatrixMultiplySSE(TempMatrix, Matrix);

        for i := 0 to Length(CubeVertex) - 1 do begin
          Triangle(
            vec4(CubeVertex[i, 0], 1.0), vec4(CubeVertex[i, 1], 1.0), vec4(CubeVertex[i, 2], 1.0),
            CubeColor[i, 0], CubeColor[i, 1], CubeColor[i, 2]);
        end;
      end;
    end;
  end;

end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  Canvas.Draw(0, 0, FrameBuffer);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  with FrameBuffer do begin
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
begin
  RotMatrix.RotateC(StepC / 4);
  RotMatrix.RotateB(StepB / 4);

  FrameBuffer.BeginUpdate();
  DrawScene;
  FrameBuffer.EndUpdate();

  Invalidate;
end;

end.
