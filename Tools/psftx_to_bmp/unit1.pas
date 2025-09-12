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

procedure ClearSL(sl: TStringList);
var
  i: integer;
begin
  for i := sl.Count - 1 downto 0 do begin
    if pos('    U+', sl[i]) = 1 then begin
      sl.Delete(i);
    end else if pos('GLYPH', sl[i]) = 1 then  begin
      sl.Delete(i);
    end else if pos('ENDGLYPH', sl[i]) = 1 then  begin
      sl.Delete(i);
    end else if pos('PSFTX FONT', sl[i]) = 1 then  begin
      sl.Delete(i);
    end else if pos('#', sl[i]) = 1 then  begin
      sl.Delete(i);
    end else if sl[i] = '' then  begin
      sl.Delete(i);
    end;
  end;
end;

function GetRowSL(sl: TStringList): integer;
var
  s: string;
  e: integer;
begin
  if pos('# Size: ', sl[1]) = 1 then begin
    s := copy(sl[1], 14, 3);
    val(s, Result, e);
    if e <> 0 then begin
      Result := 0;
    end;
    WriteLn(s);
  end else begin
    Result := 0;
  end;
end;

procedure Convert(const path: string);
var
  sl: TStringList;
  i, y, x, row: integer;
  s: string;
  pic8, pic9: TPicture;

begin
  sl := TStringList.Create;
  sl.LoadFromFile(Path + '.psftx');
  row := GetRowSL(sl);
  if row > 0 then begin
    WriteLn(row);
    ClearSL(sl);
    //  sl.SaveToFile('test.txt');
    pic8 := TPicture.Create;
    pic9 := TPicture.Create;
    pic8.Bitmap.SetSize(8 * 256, 16);
    pic9.Bitmap.SetSize(9 * 256, 16);
    for i := 0 to 255 do begin
      WriteLn('Glyph: ', i);
      for y := 0 to 15 do begin
        s := sl[i * row + y];
        for x := 0 to 7 do begin
          if s[x + 2] = '.' then begin
            Write(' ');
          end else begin
            Write('X');
            pic8.Bitmap.Canvas.Pixels[i * 8 + x, y] := $FFFFFF;
            pic9.Bitmap.Canvas.Pixels[i * 9 + x, y] := $FFFFFF;
            if (x = 7) and (i >= 166) and (i <= 223) then  begin
              pic9.Bitmap.Canvas.Pixels[i * 9 + x + 1, y] := $FFFFFF;
            end;
          end;
        end;
        WriteLn();
      end;
      WriteLn(#10);
    end;
    pic8.SaveToFile(Path + '_8x16.png');
    pic9.SaveToFile(Path + '_9x16.png');
    pic8.Free;
    pic9.Free;
  end;
  sl.Free;
end;

procedure TForm1.PNGClick(Sender: TObject);
begin
  Convert('t.fnt');
  Convert('cp865-8x16.psfu');
end;

end.
