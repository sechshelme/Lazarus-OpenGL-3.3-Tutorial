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
    procedure Create_Readme(source: string);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Create_Readme(source: string);
var
  sl, sl2: TStringList;
  s: string;
  i: integer;
begin
  sl := FindAllFiles(source, 'image.png');

  sl2 := TStringList.Create;
  for i := 1 to sl.Count - 1 do begin  // Der erste nicht
    s := sl[i];
    if Pos('HTML', s) = 0 then begin
      s := StringReplace(s, 'image.png', 'readme.md', [rfIgnoreCase, rfReplaceAll]);
      sl2.Clear;
      sl2.Add('<img src="image.png">');
      sl2.SaveToFile(s);
      Memo1.Lines.Add(s);
    end;
  end;
  sl.Free;
  sl2.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
//  Create_Readme('/n4800/DATEN/Programmierung/Lazarus/Tutorials/FreeVision');
//  Create_Readme('/n4800/DATEN/Programmierung/Lazarus/Tutorials/OpenGL_3.3');
  Create_Readme('/n4800/DATEN/Programmierung/mit_GIT/Lazarus/Tutorial/FreeVision');
  Create_Readme('/n4800/DATEN/Programmierung/mit_GIT/Lazarus/Tutorial/OpenGL_3.3');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.ReadOnly := True;
end;

end.
