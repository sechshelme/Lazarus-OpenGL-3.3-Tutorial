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
  slHeader: TStringList;
  i, j: integer;
begin
  Memo1.Clear;

    slHeader := TStringList.Create;
    slHeader.LoadFromFile('/home/tux/Schreibtisch/test/gl.pas');
    for j := 0 to slHeader.Count - 1 do begin
      if pos('__GLEW', slHeader[j]) > 0 then begin
        slHeader[j] := StringReplace(slHeader[j], '__GLEW', 'GLEW', []);
        Memo1.Lines.Add(slHeader[j]);
      end;
      if pos('__glew', slHeader[j]) > 0 then begin
        slHeader[j] := StringReplace(slHeader[j], '__glew', 'gl', []);
        Memo1.Lines.Add(slHeader[j]);
      end;
    end;
        slHeader.SaveToFile('/home/tux/Schreibtisch/test/gl2.pas');
    slHeader.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Height := 1000;
  Width := 1000;
end;

end.
