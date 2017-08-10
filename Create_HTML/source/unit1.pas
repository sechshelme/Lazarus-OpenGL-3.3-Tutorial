unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLIntf,

  CreateTutorial, SourceZip;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

function GetDateiZeit(datei: string): string;
begin
  //  Result:='<font Color="#BBBBBB">&#xA0;&#xA0;&#xA0;&#xA0;'+ DateTimeToStr(FileDateToDateTime(FileAge(datei)))+'</font>';
  Result := '<font Color="#BBBBBB">&#xA0;&#xA0;&#xA0;&#xA0;' + DateToStr(FileDateToDateTime(FileAge(datei))) + '</font>';
end;


{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
const
  Titel = 'Lazarus - OpenGL 3.3 Tutorial';
var
  s: string;
  i, k: integer;
  ct: TCreateTutorial;
  slKapitel,
  slDirectory: TStringList;
  slSubPage: TStringList;
begin
  slSubPage := TStringList.Create;
  slSubPage.Add('<!DOCTYPE html>');

  slSubPage.Add('<html>');
  slSubPage.Add('  <head>');
  slSubPage.Add('    <meta charset="utf-8">');
  slSubPage.Add('    <title>Titel</title>');

  slSubPage.Add('  </head>');
  slSubPage.Add('  <body bgcolor="#' + IntToHex(bgColor, 6) + '">');
  slSubPage.Add('<b><h1>' + Titel + '<br></h1></b>');

  slKapitel := FindAllDirectories(TutPfad, False);
  slKapitel.Sort;

  for k := 0 to slKapitel.Count - 1 do begin
    if ExtractFileName(slKapitel[k]) <> 'units' then begin

      slSubPage.Add('<b><h2>' + TitelSplitt(slKapitel[k]) + '<br></h2></b>');

      slDirectory := FindAllDirectories(slKapitel[k], False);
      slDirectory.Sort;
      for i := 0 to slDirectory.Count - 1 do begin
        slDirectory[i] := Copy(slDirectory[i], Length(TutPfad) + 1);
      end;

      for i := 0 to slDirectory.Count - 1 do begin
        s := TutPfad + slDirectory[i] + '/unit1.pas';
        if not FileExists(s) then begin
          s := TutPfad + slDirectory[i] + '/text.txt';
        end;

        if FileExists(s) then begin
          ct := TCreateTutorial.Create(slDirectory[i], TitelSplitt(slKapitel[k]));
          ct.AddSouceUnit1(s);
          slSubPage.Add(AddLink(slDirectory[i] + '/index.html', ct.getTitle) + GetDateiZeit(s) + '<br>');
          ct.Free;
        end;

      end;
      slDirectory.Free;
    end;
  end;
  slKapitel.Free;

  slSubPage.Add('<br><br>');
  slSubPage.Add('    <a href="./source.zip">Sourcen download (source.zip)</a><br>');
  slSubPage.Add('<br>');

  slSubPage.Add('  </body>');
  slSubPage.Add('</html>');

  ForceDirectories(HTMLPfad);
  slSubPage.SaveToFile(HTMLPfad + 'index.html');
  slSubPage.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenDocument(HTMLPfad + 'index.html');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  z: TSourceZip;
begin
  z := TSourceZip.Create;
  z.kopiere;
  z.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  mainSL, subSL: TStringList;
  step, i, j: integer;
  s, ns: string;
  ch: char;
begin
  step := TButton(Sender).Tag;

  mainSL := FindAllDirectories(TutPfad, False);
  mainSL.Sort;


  for i := 0 to mainSL.Count - 1 do begin

    s := mainSL[i];
    ch := s[Length(TutPfad) + 2];
    if ch in ['0'..'9'] then begin

      subSL := FindAllDirectories(mainSL[i], False);
      subSL.Sort;

      for j := 0 to subSL.Count - 1 do begin
        s := subSL[j];
        ch := s[Length(mainSL[i]) + 2];
        if ch in ['0'..'9'] then begin

          ns := Format('%.2d', [j * step]);
          //          WriteLn(mainSL[i], '     ', ns);
          s := subSL[j];
          s[Length(mainSL[i]) + 2] := ns[1];
          s[Length(mainSL[i]) + 3] := ns[2];

          WriteLn(s, '     ');
          RenameFile(subSL[j], s);
        end;

      end;

      subSL.Free;
    end;
  end;

  mainSL.Free;
end;

end.
