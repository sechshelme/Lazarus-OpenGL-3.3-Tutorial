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
  //  Triangle(200, 60, 230, 10, 20, 90, clRed);
  //  Triangle(100, 100, 200, 100, 100, 100, clYellow);
  for i := 0 to 0 do begin
    Triangle(
      vec4(Random(ClientWidth), Random(ClientHeight), 0.0, 1.0),
      vec4(Random(ClientWidth), Random(ClientHeight), 0.0, 1.0),
      vec4(Random(ClientWidth), Random(ClientHeight), 0.0, 1.0),
      vec4(Random, Random, Random, 1.0),
      vec4(Random, Random, Random, 1.0),
      vec4(Random, Random, Random, 1.0));
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Invalidate;
end;

procedure TForm1.LineX(x0, x1, y: single; col0, col1: TVector4f);
var
  x: Integer;
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

  for x := 0 to trunc(len) do begin
    c := col0 + cdif / (len / x);
    c.w := 0;  // Alpha

    //    Canvas.Pixels[x + round(x0), round(y)] := c.ToInt;
    Canvas.Pixels[trunc(x + x0), trunc(y)] := c.ToInt;
  end;

  //x:=x0;
  //repeat
  //  c := col0 + cdif / (len / (x-x0));
  //  c.w := 0;  // Alpha
  //
  //  //    Canvas.Pixels[x + round(x0), round(y)] := c.ToInt;
  //
  //  Canvas.Pixels[trunc(x), round(y)] := c.ToInt;
  //  x:=x+1.0;
  //until x > x1;
  Canvas.Pixels[trunc(x1), round(y)] := c.ToInt;
end;

procedure TForm1.Triangle(a, b, c: TVector4f; colA, colB, colC: TVector4f);
var
  y: integer;
  len, len_tot,
  x1, x2, x3: single;        { x-Werte für Scanline-Algorithmus     }
  m1, m2, m3: single;        { Increments für die x-Werte           }
  cc0, cc1,
  cdif0, cdif1, c0, c1: TVector4f;

begin
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
  cdif1 := colC - colA;

  // erste Teilfläche
  len := b.y - 1 - a.y;
  cdif0 := colB - colA;

  for y := 0 to round(len) do begin
    c0 := colA + cdif0 / len * y;
    c1 := colA + cdif1 / len_tot * y;
    LineX(x1, x3, a.y + y, c0, c1); // horiz. Linie
    WriteLn(x3: 10: 1);
    x1 := x1 + m1;
    x3 := x3 + m3;

    //    WriteLn(x1:10:1, x3:10:1);
  end;

  // zweite Teilfläche
  len := c.y - b.y;
  cdif0 := colC - colB;
  for y := 0 to round(len) do begin
    c0 := colB + cdif0 / len * y;
    c1 := colA + cdif1 / len_tot * (y + (b.y - a.y));

    LineX(x2, x3, b.y + y, c0, c1); // horiz. Linie
    x2 := x2 + m2;
    x3 := x3 + m3;
  end;
end;

end.
