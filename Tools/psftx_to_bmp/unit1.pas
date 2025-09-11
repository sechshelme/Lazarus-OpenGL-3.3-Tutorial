unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    PNG: TButton;
    procedure PNGClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

{$I-}

// https://www.zap.org.au/projects/console-fonts-distributed/psftx-opensuse-15.5/index.html

const
  SourcePath = 't.fnt';

procedure TForm1.PNGClick(Sender: TObject);
const
  ofs = 10;
  size = 22;
var
  sl: TStringList;
  i, y, x: integer;
  s: string;
  pic1, pic2: TPicture;
begin
  pic1 := TPicture.Create;
  pic2 := TPicture.Create;
  pic1.Bitmap.SetSize(8 * 256, 16);
  pic2.Bitmap.SetSize(9 * 256, 16);
  sl := TStringList.Create;
  sl.LoadFromFile(SourcePath+'.psftx');
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
          pic1.Bitmap.Canvas.Pixels[i * 8 + x, y] := $FFFFFF;
          pic2.Bitmap.Canvas.Pixels[i * 9 + x, y] := $FFFFFF;
          if (x = 7) and (i >= 166) and (i <= 223) then  begin
            pic2.Bitmap.Canvas.Pixels[i * 9 + x + 1, y] := $FFFFFF;
          end;
        end;
      end;
      WriteLn();
    end;
    WriteLn(#10);
  end;
  sl.Free;
  pic1.SaveToFile(SourcePath+'_8x16.png');
  pic2.SaveToFile(SourcePath+'_9x16.png');
  pic1.Free;
  pic2.Free;
end;

end.
