unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure Find_FT_EXPORT(var s: string);
begin
  if pos('FT_EXPORT(', s) > 0 then begin
    s:=StringReplace(s,'FT_EXPORT(','',[]);
    s:=StringReplace(s,')','',[]);
    WriteLn(s);
  end;
  if pos('FT_BASE(', s) > 0 then begin
    s:=StringReplace(s,'FT_BASE(','',[]);
    s:=StringReplace(s,')','',[]);
    WriteLn(s);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  slFile, slHeader: TStringList;
  i, j: integer;
  s: string;
begin
  Memo1.Clear;
  slFile := FindAllFiles('/n4800/DATEN/Programmierung/mit_GIT/Lazarus/Tutorial/SDL-3/Package_Tools/FreeType/include-C/freetype', '*.h');
  Memo1.Lines := slFile;

  for i := 0 to slFile.Count - 1 do begin
    slHeader := TStringList.Create;
    slHeader.LoadFromFile(slFile[i]);
    for j := 0 to slHeader.Count - 1 do begin
      slHeader[j] := StringReplace(slHeader[j], 'FT_BEGIN_HEADER', '', [rfReplaceAll]);
      slHeader[j] := StringReplace(slHeader[j], 'FT_END_HEADER', '', [rfReplaceAll]);
      s := slHeader[j];
      Find_FT_EXPORT(s);
      slHeader[j] := s;
    end;
    slHeader.SaveToFile(slFile[i]);
    slHeader.Free;
  end;

  slFile.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Height := 1000;
  Width := 1000;
end;

end.
