unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Convert: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure ConvertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    SourcePath, DestPath: string;
    procedure Form1DropFiles(Sender: TObject; const FileNames: array of string);
    procedure Delete_Const(sl: TStringList);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  TSource = record
    libs,
    units: string;
  end;
  TSources = array of TSource;

const
  Sources: TSources = (

  (libs: 'libgraphene'; units: 'ctypes, graphene'),

    (libs: ''; units: ''));


procedure TForm1.Form1DropFiles(Sender: TObject; const FileNames: array of string);
begin
  SourcePath := FileNames[0];
  WriteLn('pfad: ', SourcePath);
  if ExtractFileExt(SourcePath) <> '.pp' then begin
    WriteLn('Keine "*.pp" Datei !');
    SourcePath := '';
  end else begin
    Label1.Caption := SourcePath;
    DestPath := ChangeFileExt(SourcePath, '.pas');
    Memo1.Lines.LoadFromFile(SourcePath);
    Memo1.SelStart := 20000;
  end;
end;

procedure TForm1.Delete_Const(sl: TStringList);
var
  deleteString: TStringArray = (
    ('(* Const before type ignored *)'),
    ('(* Const before declarator ignored *)'));
  j, i: integer;
begin
  for j := 0 to Length(deleteString) - 1 do begin
    for i := sl.Count - 1 downto 0 do begin
      if sl[i] = deleteString[j] then begin
        SL.Delete(i);
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  top := 10;
  Left := 10;
  Width := 1200;
  Height := 800;
  AllowDropFiles := True;
  OnDropFiles := @Form1DropFiles;

  for i := 0 to Length(Sources) - 1 do begin
    ListBox1.Items.Add(Sources[i].libs);
  end;

  ListBox1.ItemIndex := ListBox1.Count - 2;
end;

procedure TForm1.ConvertClick(Sender: TObject);
var
  sl: TStringList;
  p, i, j, macCount: integer;
  libs, units: string;

  procedure DeleteLines(p, Count: integer);
  var
    i: integer;
  begin
    for i := 0 to Count - 1 do begin
      sl.Delete(p);
    end;
  end;

begin
  if not FileExists(SourcePath) then begin
    WriteLn('Datei nicht gefunden !');
    Exit;
  end;
  sl := TStringList.Create;
  sl.LoadFromFile(SourcePath);

  sl.Delete(0);
  sl.Insert(1, '');

  repeat
    sl.Delete(4);
  until sl[4] = '{$IFDEF FPC}';

  libs := Sources[ListBox1.ItemIndex].libs;
  units := Sources[ListBox1.ItemIndex].units;

  sl.Text := StringReplace(sl.Text, 'external;', 'external ' + libs + ';', [rfReplaceAll]);
  sl.Insert(4, 'uses' + #10 + '  ' + units + ';' + #10);


  Delete_Const(sl);
  Memo1.Lines := sl;
  Memo1.SelStart := 290000;

  sl.SaveToFile(DestPath);
  sl.Free;
end;

end.
