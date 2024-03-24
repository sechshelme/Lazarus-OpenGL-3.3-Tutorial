unit Unit1;

{$mode objfpc}{$H+}

//{$LinkLib 'GL'}


interface

uses
  //    SDL_pixels,
  //      gl,GLext,
//  oglGL,
//  oglGLext,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    slPasUnit: TStringList;
    procedure Clean(const path: string);
    procedure AddTitle(const title: string);
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
    '#define APIENTRY',
    '#define GLAPI extern');


  deletetString: array of string = (
    ' const ',
    'GLAPI',
    'GLAPIENTRY',
    'APIENTRY');

procedure TForm1.Clean(const path: string);
var
  slGL_C_include: TStringList;
  s: string;
  i, j, p: SizeInt;

begin
  Memo1.Clear;
  slGL_C_include := TStringList.Create;
  slGL_C_include.LoadFromFile(path);
  //  slGL_C_include.LoadFromFile('/home/tux/Schreibtisch/von_Git/mesa/mesa/include/GL/glext.h');

  for i := 0 to slGL_C_include.Count - 1 do begin
    s := slGL_C_include[i];

    if pos('APIENTRYP', s) > 0 then begin
      s := '//////' + s;
    end;


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
      s := StringReplace(s, deletetString[j], '', [rfReplaceAll]);
    end;

    s := StringReplace(s, ' end,', ' end_,', []);
    s := StringReplace(s, ' end)', ' end_)', []);
    s := StringReplace(s, ' program,', ' program_,', []);
    s := StringReplace(s, ' program)', ' program_)', []);
    s := StringReplace(s, ' array,', ' array_,', []);
    s := StringReplace(s, ' array)', ' array_)', []);
    s := StringReplace(s, ' unit,', ' unit_,', []);
    s := StringReplace(s, ' unit)', ' unit_)', []);
    s := StringReplace(s, ' object,', ' object_,', []);
    s := StringReplace(s, ' object)', ' object_)', []);
    s := StringReplace(s, ' in,', ' in_,', []);
    s := StringReplace(s, ' in)', ' in_)', []);
    s := StringReplace(s, ' packed,', ' packed_,', []);
    s := StringReplace(s, ' packed)', ' packed_)', []);
    s := StringReplace(s, '(const ', '( ', []);
    s := StringReplace(s, ',const ', ', ', []);
    s := StringReplace(s, '*const*', '**', []);


    slGL_C_include[i] := s;
    Memo1.Lines.Add(s);
  end;
  //    slGL_C_include.SaveToFile('temp.h');

  slPasUnit.AddStrings(slGL_C_include);
  slGL_C_include.Free;

end;

procedure TForm1.AddTitle(const title: string);
begin
  slPasUnit.Add('//////////////////////////////////////////////////////////////////////////');
  slPasUnit.Add('//');
  slPasUnit.Add('//    ' + title);
  slPasUnit.Add('//');
  slPasUnit.Add('//////////////////////////////////////////////////////////////////////////');
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  slPasUnit := TStringList.Create;

  AddTitle('gl.h');
  Clean('/home/tux/Schreibtisch/von_Git/mesa/mesa/include/GL/gl.h');
  slPasUnit.SaveToFile('oglGL.h');
  slPasUnit.Clear;

  AddTitle('glext.h');
  Clean('/home/tux/Schreibtisch/von_Git/mesa/mesa/include/GL/glext.h');
  slPasUnit.SaveToFile('oglGLext.h');
  slPasUnit.Clear;

  slPasUnit.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Height := 1000;
  Width := 1000;
end;

end.
