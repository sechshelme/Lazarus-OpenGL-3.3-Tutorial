unit Unit1;

{$mode objfpc}{$H+}

(*
-al
-CfAVX2
-CpCOREAVX2
-O3
-Sv
-OpCOREAVX2
-OoFASTMATH
*)

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, oglMatrix, oglVector;

type
  //  Tmat4x4 = array[0..3, 0..3] of single;
  Tmat8x8 = array[0..7, 0..7] of single;

  { TForm1 }

  TForm1 = class(TForm)
    Button8x8: TButton;
    Button4x4: TButton;
    procedure Button4x4Click(Sender: TObject);
    procedure Button8x8Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}

{ TForm1 }


operator * (const mat0, mat1: Tmat4x4) Res: Tmat4x4;
var
  i, k: integer;
begin
  for i := 0 to 3 do begin
    Res[i, 0] := 0.0;
    Res[i, 1] := 0.0;
    Res[i, 2] := 0.0;
    Res[i, 3] := 0.0;
    for k := 0 to 3 do begin
      Res[i, 0] += mat1[i, k] * mat0[k, 0];
      Res[i, 1] += mat1[i, k] * mat0[k, 1];
      Res[i, 2] += mat1[i, k] * mat0[k, 2];
      Res[i, 3] += mat1[i, k] * mat0[k, 3];
    end;
  end;
end;

operator * (const mat0, mat1: Tmat8x8) Res: Tmat8x8;
var
  i, j, k: integer;
begin
  for i := 0 to 7 do begin
    for j := 0 to 7 do begin
      Res[i, j] := 0.0;
      for k := 0 to 7 do begin
        Res[i, j] += mat1[i, k] * mat0[k, j];
      end;
    end;
  end;
end;

{$asmmode intel}

//function VectorMultiplySSE(const mat: Tmat4x4; const vec: TVector4f): TVector4f; assembler;
//asm
//         Movups  Xmm4, [mat + $00]
//         Movups  Xmm5, [mat + $10]
//         Movups  Xmm6, [mat + $20]
//         Movups  Xmm7, [mat + $30]
//         Movups  Xmm2, [vec]

//         // Zeile 0
//         Pshufd  Xmm0, Xmm2, 00000000b
//         Mulps   Xmm0, Xmm4

//         // Zeile 1
//         Pshufd  Xmm1, Xmm2, 01010101b
//         Mulps   Xmm1, Xmm5
//         Addps   Xmm0, Xmm1

//         // Zeile 2
//         Pshufd  Xmm1, Xmm2, 10101010b
//         Mulps   Xmm1, Xmm6
//         Addps   Xmm0, Xmm1

//         // Zeile 3
//         Pshufd  Xmm1, Xmm2, 11111111b
//         Mulps   Xmm1, Xmm7
//         Addps   Xmm0, Xmm1

//         Movups  [Result], Xmm0
//end;

function MatrixMultiplySSE(const M0, M1: Tmat4x4): Tmat4x4; assembler;nostackframe; register;
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


procedure TForm1.Button4x4Click(Sender: TObject);
var
  x, y, i: integer;
  m, m0, m1: Tmat4x4;
  t: TTime;
const
  site = 20000001;


  procedure Ausgabe;
  var
    i: integer;
  begin
    for i := 0 to 3 do begin
      WriteLn(m[i, 0]: 4: 2, '  ', m[i, 1]: 4: 2, '  ', m[i, 2]: 4: 2, '  ', m[i, 3]: 4: 2);
    end;
    WriteLn();
  end;

  function GetZeit(z: TTime): string;
  begin
    str(z * 24 * 60 * 60: 10: 4, Result);
  end;

begin
  for x := 0 to 3 do begin
    for y := 0 to 3 do begin
      m0[x, y] := x + y * 4;
      m1[x, y] := y + x * 4;
    end;
  end;

  t := now;
  for i := 0 to site do begin
    m := m0 * m1;
  end;
  WriteLn('FPU:   ', GetZeit(now - t));
  Ausgabe;

  t := now;
  for i := 0 to site do begin
    m := MatrixMultiplySSE(m0, m1);
  end;
  WriteLn('SSE:    ', GetZeit(now - t));
  Ausgabe;

  WriteLn();
  WriteLn();
  WriteLn();
end;


function MatrixMultiplySSE8x8(const M0, M1: Tmat8x8): Tmat8x8; assembler; nostackframe; register;
asm
         Vmovups  ymm4, [M0 + $00]
         Vmovups  ymm5, [M0 + $20]
         Vmovups  ymm6, [M0 + $40]
         Vmovups  ymm7, [M0 + $80]
         Vmovups  ymm8, [M0 + $A0]
         Vmovups  ymm9, [M0 + $C0]
         Vmovups  ymm10, [M0 + $E0]
         Vmovups  ymm11, [M0 + $100]

         // Spalte 0
         Vbroadcastss    ymm0, [M1 + $00]
         Vmulps   ymm0, ymm0, ymm4

         Vbroadcastss   ymm2, [M1 + $04]
         Vmulps   ymm2,ymm2, ymm5
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $08]
         Vmulps   ymm2,ymm2, ymm6
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $0C]
         Vmulps   ymm2,ymm2, ymm7
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $100]
         Vmulps   ymm2,ymm2, ymm8
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $104]
         Vmulps   ymm2,ymm2, ymm9
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $108]
         Vmulps   ymm2,ymm2, ymm10
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $10C]
         Vmulps   ymm2,ymm2, ymm11
         Vaddps   ymm0, ymm0, ymm2

         Vmovups  [Result + $00], ymm0

         // Spalte 1
         Vbroadcastss    ymm0, [M1 + $00+$200]
         Vmulps   ymm0, ymm0, ymm4

         Vbroadcastss   ymm2, [M1 + $04+$200]
         Vmulps   ymm2,ymm2, ymm5
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $08+$200]
         Vmulps   ymm2,ymm2, ymm6
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $0C+$200]
         Vmulps   ymm2,ymm2, ymm7
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $100+$200]
         Vmulps   ymm2,ymm2, ymm8
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $104+$200]
         Vmulps   ymm2,ymm2, ymm9
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $108+$200]
         Vmulps   ymm2,ymm2, ymm10
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $10C+$200]
         Vmulps   ymm2,ymm2, ymm11
         Vaddps   ymm0, ymm0, ymm2

         Vmovups  [Result + $20], ymm0

         // Spalte 2
         Vbroadcastss    ymm0, [M1 + $00+$400]
         Vmulps   ymm0, ymm0, ymm4

         Vbroadcastss   ymm2, [M1 + $04+$400]
         Vmulps   ymm2,ymm2, ymm5
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $08+$400]
         Vmulps   ymm2,ymm2, ymm6
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $0C+$400]
         Vmulps   ymm2,ymm2, ymm7
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $100+$400]
         Vmulps   ymm2,ymm2, ymm8
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $104+$400]
         Vmulps   ymm2,ymm2, ymm9
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $108+$400]
         Vmulps   ymm2,ymm2, ymm10
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $10C+$400]
         Vmulps   ymm2,ymm2, ymm11
         Vaddps   ymm0, ymm0, ymm2

         Vmovups  [Result + $40], ymm0

         // Spalte 3
         Vbroadcastss    ymm0, [M1 + $00+$600]
         Vmulps   ymm0, ymm0, ymm4

         Vbroadcastss   ymm2, [M1 + $04+$600]
         Vmulps   ymm2,ymm2, ymm5
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $08+$600]
         Vmulps   ymm2,ymm2, ymm6
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $0C+$600]
         Vmulps   ymm2,ymm2, ymm7
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $100+$600]
         Vmulps   ymm2,ymm2, ymm8
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $104+$600]
         Vmulps   ymm2,ymm2, ymm9
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $108+$600]
         Vmulps   ymm2,ymm2, ymm10
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $10C+$600]
         Vmulps   ymm2,ymm2, ymm11
         Vaddps   ymm0, ymm0, ymm2

         Vmovups  [Result + $60], ymm0

         // Spalte 4
         Vbroadcastss    ymm0, [M1 + $00+$800]
         Vmulps   ymm0, ymm0, ymm4

         Vbroadcastss   ymm2, [M1 + $04+$800]
         Vmulps   ymm2,ymm2, ymm5
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $08+$800]
         Vmulps   ymm2,ymm2, ymm6
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $0C+$800]
         Vmulps   ymm2,ymm2, ymm7
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $100+$800]
         Vmulps   ymm2,ymm2, ymm8
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $104+$800]
         Vmulps   ymm2,ymm2, ymm9
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $108+$800]
         Vmulps   ymm2,ymm2, ymm10
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $10C+$800]
         Vmulps   ymm2,ymm2, ymm11
         Vaddps   ymm0, ymm0, ymm2

         Vmovups  [Result + $80], ymm0

         // Spalte 5
         Vbroadcastss    ymm0, [M1 + $00+$A00]
         Vmulps   ymm0, ymm0, ymm4

         Vbroadcastss   ymm2, [M1 + $04+$A00]
         Vmulps   ymm2,ymm2, ymm5
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $08+$A00]
         Vmulps   ymm2,ymm2, ymm6
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $0C+$A00]
         Vmulps   ymm2,ymm2, ymm7
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $100+$A00]
         Vmulps   ymm2,ymm2, ymm8
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $104+$A00]
         Vmulps   ymm2,ymm2, ymm9
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $108+$A00]
         Vmulps   ymm2,ymm2, ymm10
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $10C+$A00]
         Vmulps   ymm2,ymm2, ymm11
         Vaddps   ymm0, ymm0, ymm2

         Vmovups  [Result + $A0], ymm0

         // Spalte 6
         Vbroadcastss    ymm0, [M1 + $00+$C00]
         Vmulps   ymm0, ymm0, ymm4

         Vbroadcastss   ymm2, [M1 + $04+$C00]
         Vmulps   ymm2,ymm2, ymm5
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $08+$C00]
         Vmulps   ymm2,ymm2, ymm6
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $0C+$C00]
         Vmulps   ymm2,ymm2, ymm7
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $100+$C00]
         Vmulps   ymm2,ymm2, ymm8
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $104+$C00]
         Vmulps   ymm2,ymm2, ymm9
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $108+$C00]
         Vmulps   ymm2,ymm2, ymm10
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $10C+$C00]
         Vmulps   ymm2,ymm2, ymm11
         Vaddps   ymm0, ymm0, ymm2

         Vmovups  [Result + $C0], ymm0

         // Spalte 7
         Vbroadcastss    ymm0, [M1 + $00+$E00]
         Vmulps   ymm0, ymm0, ymm4

         Vbroadcastss   ymm2, [M1 + $04+$E00]
         Vmulps   ymm2,ymm2, ymm5
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $08+$E00]
         Vmulps   ymm2,ymm2, ymm6
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $0C+$E00]
         Vmulps   ymm2,ymm2, ymm7
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $100+$E00]
         Vmulps   ymm2,ymm2, ymm8
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $104+$E00]
         Vmulps   ymm2,ymm2, ymm9
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $108+$E00]
         Vmulps   ymm2,ymm2, ymm10
         Vaddps   ymm0, ymm0, ymm2

         Vbroadcastss   ymm2, [M1 + $10C+$E00]
         Vmulps   ymm2,ymm2, ymm11
         Vaddps   ymm0, ymm0, ymm2

         Vmovups  [Result + $E0], ymm0


end;


procedure TForm1.Button8x8Click(Sender: TObject);
var
  x, y, i: integer;
  m, m0, m1: Tmat8x8;
  t: TTime;
const
  site = 2000001;


  procedure Ausgabe;
  var
    i: integer;
  begin
    for i := 0 to 3 do begin
      WriteLn(m[i, 0]: 4: 2, '  ', m[i, 1]: 4: 2, '  ', m[i, 2]: 4: 2, '  ', m[i, 3]: 4: 2, m[i, 4]: 4: 2, '  ', m[i, 5]: 4: 2,
        '  ', m[i, 6]: 4: 2, '  ', m[i, 7]: 4: 2);
    end;
    WriteLn();
  end;

  function GetZeit(z: TTime): string;
  begin
    str(z * 24 * 60 * 60: 10: 4, Result);
  end;

begin
  for x := 0 to 7 do begin
    for y := 0 to 7 do begin
      m0[x, y] := x + y * 8;
      m1[x, y] := y + x * 8;
    end;
  end;

  t := now;
  for i := 0 to site do begin
    m := m0 * m1;
  end;
  WriteLn('FPU:   ', GetZeit(now - t));
  Ausgabe;

  t := now;
  for i := 0 to site do begin
    m := MatrixMultiplySSE8x8(m0, m1);
  end;
  WriteLn('SSE:    ', GetZeit(now - t));
  Ausgabe;

  WriteLn();
  WriteLn();
  WriteLn();
end;

end.
