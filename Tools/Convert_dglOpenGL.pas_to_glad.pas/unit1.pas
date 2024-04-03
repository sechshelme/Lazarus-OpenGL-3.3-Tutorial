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

procedure TForm1.Button1Click(Sender: TObject);
var
  slFile, slHeader: TStringList;
  i, j: integer;
begin
  Memo1.Clear;
  slFile := FindAllFiles('/n4800/DATEN/Programmierung/mit_GIT/Lazarus/Tutorial/OpenGL_3.3', '*.pas;*.lpr');
  Memo1.Lines := slFile;

  for i := 0 to slFile.Count - 1 do begin
    slHeader := TStringList.Create;
    slHeader.LoadFromFile(slFile[i]);
    for j := 0 to slHeader.Count - 1 do begin
      slHeader[j] := StringReplace(slHeader[j], 'dglopengl', 'glad_gl', [rfReplaceAll]);

      if pos('glVertexAttribPointer', slHeader[j]) > 0 then begin
        slHeader[j] := StringReplace(slHeader[j], ' false, ', ' GL_FALSE, ', [rfIgnoreCase]);
        Memo1.Lines.Add(slHeader[j]);
      end;
      if pos('glUniformMatrix', slHeader[j]) > 0 then begin
        slHeader[j] := StringReplace(slHeader[j], ' false, ', ' GL_FALSE, ', [rfIgnoreCase]);
        Memo1.Lines.Add(slHeader[j]);
      end;
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
