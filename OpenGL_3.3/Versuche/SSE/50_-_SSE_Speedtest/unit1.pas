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
  StdCtrls; //, oglVector,oglMatrix;

type
  TVector4f = array[0..3] of single;
  Tmat4x4 = array[0..3, 0..3] of single;
  TMatrix=Tmat4x4;

  { TForm1 }

  TForm1 = class(TForm)
    Button4x4: TButton;
    procedure Button4x4Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}

{ TForm1 }


//operator * (const mat0, mat1: Tmat4x4) Res: Tmat4x4;
//var
//  i, k: integer;
//begin
//  for i := 0 to 3 do begin
//    Res[i, 0] := 0.0;
//    Res[i, 1] := 0.0;
//    Res[i, 2] := 0.0;
//    Res[i, 3] := 0.0;
//    for k := 0 to 3 do begin
//      Res[i, 0] += mat1[i, k] * mat0[k, 0];
//      Res[i, 1] += mat1[i, k] * mat0[k, 1];
//      Res[i, 2] += mat1[i, k] * mat0[k, 2];
//      Res[i, 3] += mat1[i, k] * mat0[k, 3];
//    end;
//  end;
//end;

{$asmmode intel}

function VectorMultiplySSE(const mat: Tmat4x4; const vec: TVector4f): TVector4f; assembler;
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


//operator * (const M0, M1: Tmat4x4) Res: Tmat4x4; assembler; nostackframe; register;
//asm
//         Movups  Xmm4, [M0 + $00]
//         Movups  Xmm5, [M0 + $10]
//         Movups  Xmm6, [M0 + $20]
//         Movups  Xmm7, [M0 + $30]
//
//         Xor     rcx, rcx
//         @loop:
//         Movss   Xmm0, [M1 + $00 + rcx]
//         Shufps  Xmm0, Xmm0, 00000000b
//         Mulps   Xmm0, Xmm4
//
//         Movss   Xmm2, [M1 + $04 + rcx]
//         Shufps  Xmm2, Xmm2, 00000000b
//         Mulps   Xmm2, Xmm5
//         Addps   Xmm0, Xmm2
//
//         Movss   Xmm2, [M1 + $08 + rcx]
//         Shufps  Xmm2, Xmm2, 00000000b
//         Mulps   Xmm2, Xmm6
//         Addps   Xmm0, Xmm2
//
//         Movss   Xmm2, [M1 + $0C + rcx]
//         Shufps  Xmm2, Xmm2, 00000000b
//         Mulps   Xmm2, Xmm7
//         Addps   Xmm0, Xmm2
//
//         Movups  [Res + rcx], Xmm0
//
//         Add     rcx, $10
//         Cmp     rcx, $30
//         Jbe     @loop
//end;
//
//
//function MatrixMultiplySSE(const M0, M1: Tmat4x4): Tmat4x4; assembler; nostackframe; register;
//asm
//         Movups  Xmm4, [M0 + $00]
//         Movups  Xmm5, [M0 + $10]
//         Movups  Xmm6, [M0 + $20]
//         Movups  Xmm7, [M0 + $30]
//
//         Xor     ecx, ecx
//         @loop:
//         Movss   Xmm0, [M1 + $00 + ecx]
//         Shufps  Xmm0, Xmm0, 00000000b
//         Mulps   Xmm0, Xmm4
//
//         Movss   Xmm2, [M1 + $04 + ecx]
//         Shufps  Xmm2, Xmm2, 00000000b
//         Mulps   Xmm2, Xmm5
//         Addps   Xmm0, Xmm2
//
//         Movss   Xmm2, [M1 + $08 + ecx]
//         Shufps  Xmm2, Xmm2, 00000000b
//         Mulps   Xmm2, Xmm6
//         Addps   Xmm0, Xmm2
//
//         Movss   Xmm2, [M1 + $0C + ecx]
//         Shufps  Xmm2, Xmm2, 00000000b
//         Mulps   Xmm2, Xmm7
//         Addps   Xmm0, Xmm2
//
//         Movups  [Result + ecx], Xmm0
//
//         Add     ecx, $10
//         Cmp     ecx, $30
//         Jbe     @loop
//end;

function MatrixMultiplySSE(const M0, M1: TMatrix): TMatrix; assembler; nostackframe; register;
asm
         Movups Xmm4, [M0 + $00]
         Movups Xmm5, [M0 + $10]
         Movups Xmm6, [M0 + $20]
         Movups Xmm7, [M0 + $30]

         // Spalte 0
         Movups Xmm2, [M1 + $00]

         Pshufd Xmm0, Xmm2, 00000000b
         Mulps  Xmm0, Xmm4

         Pshufd Xmm1, Xmm2, 01010101b
         Mulps  Xmm1, Xmm5
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 10101010b
         Mulps  Xmm1, Xmm6
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 11111111b
         Mulps  Xmm1, Xmm7
         Addps  Xmm0, Xmm1

         Movups [Result + $00], Xmm0

         // Spalte 1
         Movups Xmm2, [M1 + $10]

         Pshufd Xmm0, Xmm2, 00000000b
         Mulps  Xmm0, Xmm4

         Pshufd Xmm1, Xmm2, 01010101b
         Mulps  Xmm1, Xmm5
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 10101010b
         Mulps  Xmm1, Xmm6
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 11111111b
         Mulps  Xmm1, Xmm7
         Addps  Xmm0, Xmm1

         Movups   [Result + $10], Xmm0

         // Spalte 2
         Movups  Xmm2, [M1 + $20]

         Pshufd Xmm0, Xmm2, 00000000b
         Mulps  Xmm0, Xmm4

         Pshufd Xmm1, Xmm2, 01010101b
         Mulps  Xmm1, Xmm5
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 10101010b
         Mulps  Xmm1, Xmm6
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 11111111b
         Mulps  Xmm1, Xmm7
         Addps  Xmm0, Xmm1

         Movups [Result + $20], Xmm0

         // Spalte 3
         Movups Xmm2, [M1 + $30]

         Pshufd Xmm0, Xmm2, 00000000b
         Mulps  Xmm0, Xmm4

         Pshufd Xmm1, Xmm2, 01010101b
         Mulps  Xmm1, Xmm5
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 10101010b
         Mulps  Xmm1, Xmm6
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 11111111b
         Mulps  Xmm1, Xmm7
         Addps  Xmm0, Xmm1

         Movups [Result + $30], Xmm0
end;

operator * (const M0, M1: Tmat4x4) Res: Tmat4x4; assembler; nostackframe; register;
asm
         Movups Xmm4, [M0 + $00]
         Movups Xmm5, [M0 + $10]
         Movups Xmm6, [M0 + $20]
         Movups Xmm7, [M0 + $30]

         // Spalte 0
         Movups Xmm2, [M1 + $00]

         Pshufd Xmm0, Xmm2, 00000000b
         Mulps  Xmm0, Xmm4

         Pshufd Xmm1, Xmm2, 01010101b
         Mulps  Xmm1, Xmm5
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 10101010b
         Mulps  Xmm1, Xmm6
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 11111111b
         Mulps  Xmm1, Xmm7
         Addps  Xmm0, Xmm1

         Movups [Result + $00], Xmm0

         // Spalte 1
         Movups Xmm2, [M1 + $10]

         Pshufd Xmm0, Xmm2, 00000000b
         Mulps  Xmm0, Xmm4

         Pshufd Xmm1, Xmm2, 01010101b
         Mulps  Xmm1, Xmm5
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 10101010b
         Mulps  Xmm1, Xmm6
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 11111111b
         Mulps  Xmm1, Xmm7
         Addps  Xmm0, Xmm1

         Movups   [Result + $10], Xmm0

         // Spalte 2
         Movups  Xmm2, [M1 + $20]

         Pshufd Xmm0, Xmm2, 00000000b
         Mulps  Xmm0, Xmm4

         Pshufd Xmm1, Xmm2, 01010101b
         Mulps  Xmm1, Xmm5
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 10101010b
         Mulps  Xmm1, Xmm6
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 11111111b
         Mulps  Xmm1, Xmm7
         Addps  Xmm0, Xmm1

         Movups [Result + $20], Xmm0

         // Spalte 3
         Movups Xmm2, [M1 + $30]

         Pshufd Xmm0, Xmm2, 00000000b
         Mulps  Xmm0, Xmm4

         Pshufd Xmm1, Xmm2, 01010101b
         Mulps  Xmm1, Xmm5
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 10101010b
         Mulps  Xmm1, Xmm6
         Addps  Xmm0, Xmm1

         Pshufd Xmm1, Xmm2, 11111111b
         Mulps  Xmm1, Xmm7
         Addps  Xmm0, Xmm1

         Movups [Result + $30], Xmm0
end;


procedure TForm1.Button4x4Click(Sender: TObject);
var
  x, y, i: integer;
  ma, mb, mc, m0, m1: Tmat4x4;
  t: TTime;
const
  site = 20000001;

  procedure Ausgabe(m: Tmat4x4);
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

  // Operator
  t := now;
  for i := 0 to site do begin
    ma := m0 * m1;
  end;
  WriteLn('Operator SSE:   ', GetZeit(now - t));
  Ausgabe(ma);

  // Function
  t := now;
  for i := 0 to site do begin
    mc := MatrixMultiplySSE(m0, m1);
  end;
  WriteLn('SSE Funktion:    ', GetZeit(now - t));
  Ausgabe(mc);

  WriteLn();
  WriteLn();
  WriteLn();
end;

end.
