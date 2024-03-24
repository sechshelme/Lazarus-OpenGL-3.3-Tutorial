unit Unit1;

{$mode objfpc}{$H+}

 //{$LinkLib 'GL'}


interface

uses
  //    SDL_pixels,
//  temp,
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

const
  checkList: array of string = (
  'extern "C"',
  '}',
  'typedef void (APIENTRYP',
    '#define GLAPI extern',
    '#define APIENTRYP APIENTRY *',
    '#define GLAPIENTRYP GLAPIENTRY *');

  deletetString: array of string = (
    'GLAPI',
    'GLAPIENTRY',
    'APIENTRY');

procedure TForm1.Button1Click(Sender: TObject);
var
  slGL_C_include: TStringList;
  s: string;
  i, j, p: SizeInt;

begin

  Memo1.Clear;
  slGL_C_include := TStringList.Create;
  slGL_C_include.LoadFromFile('/home/tux/Schreibtisch/von_Git/mesa/mesa/include/GL/gl.h');
  //  slGL_C_include.LoadFromFile('/home/tux/Schreibtisch/von_Git/mesa/mesa/include/GL/glext.h');

  for i := 0 to slGL_C_include.Count - 1 do begin
    s := slGL_C_include[i];
    if pos('#', s) > 0 then begin
      if pos('#define', s) = 0 then  begin
        s := '//////' + s;
//        WriteLn(s);
      end;
    end;
    for j := 0 to Length(checkList) - 1 do begin
      if pos(checkList[j], s) = 1 then  begin
        s := '//////' + s;
//        WriteLn(s);
      end;
    end;

    for j := 0 to Length(deletetString) - 1 do begin
        s:=StringReplace(s, deletetString[j],'',[]);
    end;


    slGL_C_include[i] := s;
  end;
  slGL_C_include.SaveToFile('temp.h');
  slGL_C_include.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Height := 1000;
  Width := 1000;
end;

end.
