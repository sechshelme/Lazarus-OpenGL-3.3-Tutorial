unit Unit1;

{$mode objfpc}{$H+}

interface

// Achtung !, in den Pfaden darf sich kein Leezzeichen (#32) befinden !

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLIntf, EditBtn,
  IniFiles,
  Common, CreateHTMLTutorial, CreateWikiTutorial, CreateReadmeMD, SourceZip, WikiText;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonCreateReadmeMD: TButton;
    ButtonWikiText: TButton;
    ButtonCreateWiki: TButton;
    ButtonCreateHTML: TButton;
    ButtonShow: TButton;
    ButtonCopySource: TButton;
    ButtonSort1: TButton;
    ButtonSort2: TButton;
    ButtonSort5: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabelWikiPfad: TLabel;
    LabelTutorialPfad: TLabel;
    LabelHTMLPfad: TLabel;
    LabelTutorialName: TLabel;
    LabelReadmeMDPfad: TLabel;
    procedure ButtonCreateHTMLClick(Sender: TObject);
    procedure ButtonCreateReadmeMDClick(Sender: TObject);
    procedure ButtonCreateWikiClick(Sender: TObject);
    procedure ButtonShowClick(Sender: TObject);
    procedure ButtonCopySourceClick(Sender: TObject);
    procedure ButtonSort1Click(Sender: TObject);
    procedure ButtonWikiTextClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ReadSection(aktSektions: string; ini: TIniFile);
  public
  end;

var
  Form1: TForm1;

implementation

function GetDateiZeit(datei: string): string;
begin
  Result := '<font Color="#BBBBBB">&#xA0;&#xA0;&#xA0;&#xA0;' + DateToStr(FileDateToDateTime(FileAge(datei))) + '</font>';
end;


{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonCreateHTMLClick(Sender: TObject);
var
  s: string;
  i, k: integer;
  ct: TCreateHTMLTutorial;
  slKapitel, slDirectory: TStringList;
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
  slSubPage.Add('<b><h1>' + TutPara.Titel + '<br></h1></b>');

  slKapitel := FindAllDirectories(TutPara.TutPfad, False);
  slKapitel.Sort;

  for k := 0 to slKapitel.Count - 1 do begin
    s := HTMLTitelSplitt(slKapitel[k]);
    if Length(s) > 1 then begin      // Prüfen ob Ordner mit einer Ziffer beginnt.
      if (s[1] in ['0'..'9']) then begin
        slSubPage.Add('<b><h2>' + HTMLTitelSplitt(slKapitel[k]) + '<br></h2></b>');

        slDirectory := FindAllDirectories(slKapitel[k], False);
        slDirectory.Sort;
        for i := 0 to slDirectory.Count - 1 do begin
          slDirectory[i] := Copy(slDirectory[i], Length(TutPara.TutPfad) + 1);

          s := TutPara.TutPfad + slDirectory[i] + '/unit1.pas';
          if not FileExists(s) then begin
            s := TutPara.TutPfad + slDirectory[i] + '/Project1.pas';
            if not FileExists(s) then begin
              s := TutPara.TutPfad + slDirectory[i] + '/text.txt';
            end;
          end;

          if FileExists(s) then begin
            ct := TCreateHTMLTutorial.Create(slDirectory[i], HTMLTitelSplitt(slKapitel[k]));
            ct.AddSouceUnit1(s);
            slSubPage.Add(HTMLAddLink(slDirectory[i] + '/index.html', ct.getTitle) + GetDateiZeit(s) + '<br>');
            ct.Free;
          end;

        end;
        slDirectory.Free;
      end;
    end;
  end;
  slKapitel.Free;

  slSubPage.Add('<br><br>');
  slSubPage.Add('    <a href="./source.zip">Sourcen download (source.zip)</a><br>');
  slSubPage.Add('<br>');

  slSubPage.Add('  </body>');
  slSubPage.Add('</html>');

  ForceDirectories(TutPara.HTMLPfad);
  slSubPage.SaveToFile(TutPara.HTMLPfad + '/index.html');
  slSubPage.Free;
end;

procedure TForm1.ButtonCreateReadmeMDClick(Sender: TObject);
var
  s: string;
  i, k: integer;
  ct: TCreateReadmeMD;
  slKapitel, slDirectory: TStringList;
  //  slSubPage: TStringList;
begin
  //slSubPage := TStringList.Create;
  //slSubPage.Add('<!DOCTYPE html>');
  //
  //slSubPage.Add('<html>');
  //slSubPage.Add('  <head>');
  //slSubPage.Add('    <meta charset="utf-8">');
  //slSubPage.Add('    <title>Titel</title>');
  //
  //slSubPage.Add('  </head>');
  //slSubPage.Add('  <body bgcolor="#' + IntToHex(bgColor, 6) + '">');
  //slSubPage.Add('<b><h1>' + TutPara.Titel + '<br></h1></b>');

  slKapitel := FindAllDirectories(TutPara.TutPfad, False);
  slKapitel.Sort;

  for k := 0 to slKapitel.Count - 1 do begin
    s := HTMLTitelSplitt(slKapitel[k]);
    if Length(s) > 1 then begin      // Prüfen ob Ordner mit einer Ziffer beginnt.
      if (s[1] in ['0'..'9']) then begin
        //        slSubPage.Add('<b><h2>' + HTMLTitelSplitt(slKapitel[k]) + '<br></h2></b>');

        slDirectory := FindAllDirectories(slKapitel[k], False);
        slDirectory.Sort;
        for i := 0 to slDirectory.Count - 1 do begin
          slDirectory[i] := Copy(slDirectory[i], Length(TutPara.TutPfad) + 1);

          s := TutPara.TutPfad + slDirectory[i] + '/unit1.pas';
          if not FileExists(s) then begin
            s := TutPara.TutPfad + slDirectory[i] + '/Project1.pas';
            if not FileExists(s) then begin
              s := TutPara.TutPfad + slDirectory[i] + '/text.txt';
            end;
          end;

          if FileExists(s) then begin
            ct := TCreateReadmeMD.Create(slDirectory[i], HTMLTitelSplitt(slKapitel[k]));
            ct.AddSouceUnit1(s);
//            slSubPage.Add(HTMLAddLink(slDirectory[i] + '/index.html', ct.getTitle) + GetDateiZeit(s) + '<br>');
            ct.Free;
          end;

        end;
        slDirectory.Free;
      end;
    end;
  end;
  slKapitel.Free;

  //slSubPage.Add('<br><br>');
  //slSubPage.Add('    <a href="./source.zip">Sourcen download (source.zip)</a><br>');
  //slSubPage.Add('<br>');
  //
  //slSubPage.Add('  </body>');
  //slSubPage.Add('</html>');

  ForceDirectories(TutPara.ReadmeMDPfad);
  //slSubPage.SaveToFile(TutPara.HTMLPfad + '/index.html');
  //slSubPage.Free;
end;

procedure TForm1.ButtonCreateWikiClick(Sender: TObject);
var
  sd, s: string;
  i, k: integer;
  ct: TCreateWikiTutorial;
  slDescription, WikiSL, slKapitel, slDirectory: TStringList;
begin
  slKapitel := FindAllDirectories(TutPara.TutPfad, False);
  slKapitel.Sort;

  WikiSL := TStringList.Create;

  WikiSL.Add('=' + TutPara.Titel + '=');

  WikiSL.Add('==Einleitung==');
  WikiSL.Add('Hinweis: Die Sourcen auf GitHub sind aktueller als das Wiki.<br>');
  WikiSL.Add('Auch befinden sich Beispiele auf GitHub, welche im Wiki nicht dokumentiert sind.<br>');

  WikiSL.Add('==Download==');
  WikiSL.Add('* [https://github.com/sechshelme/Lazarus-OpenGL-3.3-Tutorial alle Sourcen (github)]<br>');
  //  WikiSL.Add('* [http://mathias1000.bplaced.net/Tutorial_HTML/OpenGL_3.3/source.zip alle Sourcen (HTML)]');

  WikiSL.Add('==Tutorial==');

  for k := 0 to slKapitel.Count - 1 do begin

    s := WikiTitelSplitt(slKapitel[k]);
    if Length(s) > 0 then begin
      if s[1] in ['0'..'9'] then begin

        WikiSL.Add('=== ' + Copy(s, 6) + ' ===');
        WikiSL.Add('{|{{Prettytable_B1}} width="100%"');
        WikiSL.Add('!width="15%"|Link');
        WikiSL.Add('!width="85%"|Beschreibung');

        slDirectory := FindAllDirectories(slKapitel[k], False);
        slDirectory.Sort;

        for i := 0 to slDirectory.Count - 1 do begin
          sd := slDirectory[i];
          slDirectory[i] := Copy(slDirectory[i], Length(TutPara.TutPfad) + 1);

          s := TutPara.TutPfad + slDirectory[i] + '/unit1.pas';
          if not FileExists(s) then begin
            s := TutPara.TutPfad + slDirectory[i] + '/Project1.pas';
            if not FileExists(s) then begin
              s := TutPara.TutPfad + slDirectory[i] + '/text.txt';
            end;
          end;

          if FileExists(s) then begin
            ct := TCreateWikiTutorial.Create(slDirectory[i], WikiTitelSplitt(slKapitel[k]));
            ct.AddSouceUnit1(s);
            WikiSL.Add('|-');
            WikiSL.Add('![[' + TutPara.Titel + ' - ' + ct.getKapitelAndTitle + '|' + Copy(ct.getTitle, 6) + ']]');
            WikiSL.Add('{{Level_2}} ');
            WikiSL.Add('|[[Image:' + TutPara.Titel + ' - ' + ct.getKapitelAndTitle + '.png|128px|right]] ');

            s := sd + '/description.txt';
            if FileExists(s) then begin
              slDescription := TStringList.Create;
              slDescription.LoadFromFile(s);
              WikiSL.Add(slDescription.Text);
              slDescription.Free;
            end else begin
              WikiSL.Add('Kommentar Kommentar Kommentar Kommentar Kommentar Kommentar Kommentar Kommentar Kommentar Kommentar Kommentar ');
            end;
            WikiSL.Add('* [https://github.com/sechshelme/Lazarus-OpenGL-3.3-Tutorial/tree/master/' + slDirectory[i] + ' source]');

            ct.Free;
          end;

        end;
        WikiSL.Add('|-');
        WikiSL.Add('|}');
        WikiSL.Add('[https://wiki.delphigl.com/index.php/Lazarus_-_OpenGL_3.3_Tutorial' + ' Inhaltsverzeichnis]');

        slDirectory.Free;
      end;
    end;
  end;
  slKapitel.Free;

  WikiSL.SaveToFile(TutPara.WikiPfad + 'wiki.txt');
  WikiSL.Free;

  ForceDirectories(TutPara.WikiPfad);
end;

procedure TForm1.ButtonShowClick(Sender: TObject);
begin
  OpenDocument(TutPara.HTMLPfad + '/index.html');
end;

procedure TForm1.ButtonCopySourceClick(Sender: TObject);
var
  z: TSourceZip;
begin
  z := TSourceZip.Create;
  z.kopieren;
  z.Free;
end;

procedure TForm1.ButtonSort1Click(Sender: TObject);
var
  mainSL, subSL: TStringList;
  step, i, j: integer;
  s, ns: string;
  ch: char;
begin
  step := TButton(Sender).Tag;

  mainSL := FindAllDirectories(TutPara.TutPfad, False);
  mainSL.Sort;


  for i := 0 to mainSL.Count - 1 do begin

    s := mainSL[i];
    ch := s[Length(TutPara.TutPfad) + 2];
    if ch in ['0'..'9'] then begin

      subSL := FindAllDirectories(mainSL[i], False);
      subSL.Sort;

      for j := 0 to subSL.Count - 1 do begin
        s := subSL[j];
        ch := s[Length(mainSL[i]) + 2];
        if ch in ['0'..'9'] then begin

          ns := Format('%.2d', [j * step]);

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

procedure TForm1.ButtonWikiTextClick(Sender: TObject);
begin
  WikiTextForm.ShowModal;
end;

procedure TForm1.ReadSection(aktSektions: string; ini: TIniFile);
begin
  with TutPara do begin
    Titel := ini.ReadString(aktSektions, 'Name', '');
    LabelTutorialName.Caption := Titel;

    TutPfad := ini.ReadString(aktSektions, 'TutPfad', '');
    LabelTutorialPfad.Caption := TutPfad;

    HTMLPfad := ini.ReadString(aktSektions, 'HTMLPfad', '');
    LabelHTMLPfad.Caption := HTMLPfad;

    WikiPfad := ini.ReadString(aktSektions, 'WikiPfad', '');
    LabelWikiPfad.Caption := WikiPfad;

    ReadmeMDPfad := ini.ReadString(aktSektions, 'ReadmeMDPfad', '');
    LabelReadmeMDPfad.Caption := ReadmeMDPfad;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ini: TIniFile;
  i: integer;
  slSections: TStringList;
  aktSektions: string;
begin
  chdir(ExtractFileDir(ParamStr(0)));

  ComboBox1.Clear;

  ini := TIniFile.Create(ConfigINIDatei);

  slSections := TStringList.Create;
  ini.ReadSections(slSections);

  for i := 0 to slSections.Count - 1 do begin
    if slSections[i] <> 'options' then begin
      ComboBox1.Items.Add(slSections[i]);
    end;
  end;
  aktSektions := ini.ReadString('options', 'current', '');
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(aktSektions);

  ReadSection(aktSektions, ini);

  slSections.Free;
  ini.Free;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ConfigINIDatei);
  ReadSection(ComboBox1.Caption, ini);

  ini.WriteString('options', 'current', ComboBox1.Caption);

  ini.Free;
end;

end.
