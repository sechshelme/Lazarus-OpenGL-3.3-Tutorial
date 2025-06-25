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
  i: integer;
  p1, p2, p3: SizeInt;
  sold, snew, stype: string;
begin
  Memo1.Clear;

  slHeader := TStringList.Create;
  slHeader.LoadFromFile('/home/tux/Schreibtisch/test/gl.pas');
  for i := 0 to slHeader.Count - 1 do begin
    p1 := pos('__GLEW', slHeader[i]);
    if p1 > 0 then begin
      p2 := pos(':', slHeader[i]);
      p3 := pos(';', slHeader[i]);
      sold := copy(slHeader[i], p1, p2 - p1);
      snew := copy(slHeader[i], p1 + 2, p2 - p1 - 2);
      stype := copy(slHeader[i], p2 + 2, p3 - p2 - 2);
      //      WriteLn('*', sold, '*', snew, '***', stype, '*');
      slHeader[i] := slHeader[i] + #10' ' + snew + ': ' + stype + ' absolute ' + sold + ';'#10;
      Memo1.Lines.Add(slHeader[i]);
    end;

    p1 := pos('__glew', slHeader[i]);
    if p1 > 0 then begin
      p2 := pos(':', slHeader[i]);
      p3 := pos(';', slHeader[i]);
      sold := copy(slHeader[i], p1, p2 - p1);
      snew := copy(slHeader[i], p1 + 6, p2 - p1 - 6);
      stype := copy(slHeader[i], p2 + 2, p3 - p2 - 2);
            WriteLn('*', sold, '*', snew, '***', stype, '*');
      slHeader[i] := slHeader[i] + #10'  gl' + snew + ': ' + stype + ' absolute ' + sold + ';'#10;
      Memo1.Lines.Add(slHeader[i]);
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
