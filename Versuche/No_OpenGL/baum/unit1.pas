unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
    procedure DrawTree(x, y, a: single; nesting: integer);

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

const
  len = -10;

var
  ofsx, ofsy: single;

procedure TForm1.FormPaint(Sender: TObject);
begin
  ofsx := ClientWidth / 2;
  ofsy := ClientHeight div 8 * 7;
  DrawTree(0, 0, 0, 8);
end;

procedure TForm1.DrawTree(x, y, a: single; nesting: integer);
var
  i: integer;
begin
  Canvas.Pen.Color := byte($100-nesting*50) * $100;
  Canvas.Pen.Width:=nesting*2;

  Canvas.MoveTo(Round(ofsx + x), Round(ofsy + y));

  x := x + sin(a) * len*nesting * Random();
  y := y + cos(a) * len*nesting * Random();;
//  WriteLn('  x:', x: 8: 2, '  y:', y: 8: 2, '  a:', a: 8: 2);

  Canvas.LineTo(Round(ofsx + x), Round(ofsy + y));
  if nesting > 0 then begin
    for i := 0 to 1 do begin
      DrawTree(x, y, a + pi / random / 300, nesting - 1);
      DrawTree(x, y, a - pi / Random / 300, nesting - 1);
    end;
  end;
end;

end.
