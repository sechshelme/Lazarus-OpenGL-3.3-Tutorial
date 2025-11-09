unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    PNG: TButton;
    procedure PNGClick(Sender: TObject);
  private
    procedure ClearSL(sl: TStringList);
    function GetSize(sl: TStringList; cols, rows: PInteger): boolean;
    procedure Convert(const datei: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

{$I-}

// https://www.zap.org.au/projects/console-fonts-distributed/psftx-opensuse-15.5/index.html

const
  srcPath = '/home/tux/Schreibtisch/fonts/psftx';
  desPath = '/home/tux/Schreibtisch/fonts/png';

procedure TForm1.ClearSL(sl: TStringList);
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

function TForm1.GetSize(sl: TStringList; cols, rows: PInteger): boolean;
var
  srow, scol: string;
  e: integer;
  sa: TAnsiStringArray;
begin
  rows^ := 0;
  cols^ := 0;
  Result := False;
  if pos('# Size: ', sl[1]) = 1 then begin
    Result := True;
    sa := sl[1].Split(' ');
    scol := sa[4];
    srow := sa[6];
    val(srow, rows^, e);
    if e <> 0 then begin
      Result := False;
    end;
    val(scol, cols^, e);
    if e <> 0 then begin
      Result := False;
    end;
  end;
end;

procedure TForm1.Convert(const datei: string);
var
  sl: TStringList;
  i, y, x, row, col: integer;
  s: string;
  pic8, pic9: TPicture;
begin
  WriteLn('Datei: ', datei);
  sl := TStringList.Create;
  sl.LoadFromFile(srcPath + '/' + datei + '.psftx');
  if GetSize(sl, @col, @row) then begin
    WriteLn('size: ', col, 'x', row);
    ClearSL(sl);
    sl.SaveToFile('test.txt');
    pic8 := TPicture.Create;
    pic9 := TPicture.Create;
    pic8.Bitmap.SetSize((col + 0) * 256, row);
    pic9.Bitmap.SetSize((col + 1) * 256, row);
    for i := 0 to 255 do begin
      for y := 0 to row - 1 do begin
        s := sl[i * row + y];
        for x := 0 to col - 1 do begin
          if s[x + 2] <> '.' then begin
            pic8.Bitmap.Canvas.Pixels[i * (col + 0) + x, y] := $FFFFFF;
            pic9.Bitmap.Canvas.Pixels[i * (col + 1) + x, y] := $FFFFFF;
            if (x = (col - 1)) and (i >= 166) and (i <= 223) then  begin
              pic9.Bitmap.Canvas.Pixels[i * (col + 1) + x + 1, y] := $FFFFFF;
            end;
          end;
        end;
      end;
    end;
    pic8.SaveToFile(desPath + '/' + datei + '_8x16.png');
    pic9.SaveToFile(desPath + '/' + datei + '_9x16.png');
    pic8.Free;
    pic9.Free;
  end;
  sl.Free;
end;

procedure TForm1.PNGClick(Sender: TObject);
var
  slFiles: TStringList;
  i: integer;
  path: string;
begin
  slFiles := FindAllFiles(srcPath, '*.psftx', False);

  for i := 0 to slFiles.Count - 1 do begin
    path := ExtractFileName(slFiles[i]);
    Delete(path, Length(path) - 5, 60);
    Convert(path);
    Application.ProcessMessages;
  end;
  slFiles.Free;

  WriteLn('Ende');
end;

end.
