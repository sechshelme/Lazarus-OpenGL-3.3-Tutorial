unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

{$I-}

procedure TForm1.Button1Click(Sender: TObject);
const
  ofs = 10;
  size = 22;
var
  sl: TStringList;
  i, y, x: integer;
  s: string;
  bit: TBitmap;
begin
  bit := TBitmap.Create;
  bit.SetSize(8 * 256, 16);
  sl := TStringList.Create;
  sl.LoadFromFile('t.fnt.psftx');
  for i := 0 to 255 do begin
    for y := 0 to 15 do begin
      s := sl[ofs + i * size + y];
      for x := 0 to 7 do begin
        if s[x + 2] = '.' then begin
          Canvas.Pixels[i * 8 + x, y] := clWhite;
          Write(' ');
        end else begin
          Write('X');
          Canvas.Pixels[i * 8 + x, y] := clBlack;
          Bit.Canvas.Pixels[i * 8 + x, y] := $FFFFFF;
        end;
      end;
      WriteLn();
    end;
    WriteLn(#10);
  end;
  sl.Free;
  bit.SaveToFile('t.fnt.bmp');
  bit.Free;
end;

end.
