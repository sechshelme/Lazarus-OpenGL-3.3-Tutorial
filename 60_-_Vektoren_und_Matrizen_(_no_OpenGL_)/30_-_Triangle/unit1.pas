unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
    procedure Triangle(ax, ay, bx, by, cx, cy, col: TColor);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormPaint(Sender: TObject);
begin
  Triangle(200, 60, 230, 10, 20, 90, clRed);

  Triangle(100, 100, 200, 100, 100, 100, clYellow);

end;

procedure TForm1.Triangle(ax, ay, bx, by, cx, cy, col: TColor);
var
  y: integer;       { Schleifenvariable für die Scanzeile  }
  h: integer;
  x1, x2, x3: single;        { x-Werte für Scanline-Algorithmus     }
  m1, m2, m3: single;        { Increments für die x-Werte           }
begin
  if (ay > by) then begin
    h := ay;
    ay := by;
    by := h;               { vertausche A und B    }
    h := ax;
    ax := bx;
    bx := h;
  end;
  if (by > cy) then begin
    h := by;
    by := cy;
    cy := h;               { vertausche B und C    }
    h := bx;
    bx := cx;
    cx := h;
  end;
  if (ay > by) then begin
    h := ay;
    ay := by;
    by := h;               { vertausche A und B    }
    h := ax;
    ax := bx;
    bx := h;
  end;


  x1 := ax;                                    { x-Wert Linie A -> B   }
  x2 := bx;                                    { x-Wert Linie B -> C   }
  x3 := ax;                                    { x-Wert Linie A -> C   }

  m1 := (bx - ax) / (by - ay);                      { Increments   A -> B   }
  m2 := (bx - cx) / (by - cy);                      { Increments   B -> C   }
  m3 := (cx - ax) / (cy - ay);                      { Increments   A -> C   }

  Canvas.Pen.Color := col;

  for y := ay to by - 1 do                        { erste Teilfläche      } begin
    Canvas.Line(round(x1), y, round(x3), y); { horiz. Linie          }
    x1 := x1 + m1;
    x3 := x3 + m3;
  end;

  for y := by to cy do                          { zweite Teilfläche     } begin
    Canvas.Line(round(x2), y, round(x3), y); { horiz. Linie          }
    x2 := x2 + m2;
    x3 := x3 + m3;
  end;
end;

end.
