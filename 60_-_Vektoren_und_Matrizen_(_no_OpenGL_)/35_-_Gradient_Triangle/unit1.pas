unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  dglOpenGL, oglVector, oglMatrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    procedure LineX(x0, x1, y: single; col0, col1: TVector4f);
    procedure Triangle(a, b, c: TVector4f; colA, colB, colC: TVector4f);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  Color := clBlack;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to 0 do begin
    Triangle(
      vec4(Random * ClientWidth, Random * ClientHeight, 0.0, 1.0),
      vec4(Random * ClientWidth, Random * ClientHeight, 0.0, 1.0),
      vec4(Random * ClientWidth, Random * ClientHeight, 0.0, 1.0),
      vec4(Random, Random, Random, 1.0),
      vec4(Random, Random, Random, 1.0),
      vec4(Random, Random, Random, 1.0));
  end;
//
//  Triangle(
//    vec4(550, 50, 0.0, 1.0),
//    vec4(550, 250, 0.0, 1.0),
//    vec4(50, 251, 0.0, 1.0),
//    vec4(Random, Random, Random, 1.0),
//    vec4(Random, Random, Random, 1.0),
//    vec4(Random, Random, Random, 1.0));
//

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Invalidate;
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
  WriteLn('x0: ', x0: 10: 2, '    x0: ', trunc(x0): 10, '     x1: ', x1: 10: 2, ' x1: ', trunc(x1): 10);

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

  for y := trunc(a.y) to trunc(a.y+ len_part) do begin
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

end.
