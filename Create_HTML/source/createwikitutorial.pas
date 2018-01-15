unit CreateWikiTutorial;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, FileUtil, StdCtrls, ResWort, Global;

const
  bgColor = $DDDDFF;

  ResWortColor = '0000BB';
  DefineColor = '008800';
  ComentColor = 'FFFF00';
  BKColor = 'BBBBFF';
  FontColor = '000000';
  StringColor = 'FF0000';
  NumberColor = '0077BB';
  TestColor = 'EEEEEE';

type

  { TCreateWikiTutorial }

  TCreateWikiTutorial = class(TObject)
  private
    slCode, slMatrix, slWiki: TStringList;
    fFolder, fKapitel: string;

    procedure CutBlock(sl: TStrings; Block: string);
    procedure Test_bold_Title(sl: TStrings);
    procedure createMatrix(sl: TStrings);
  public
    constructor Create(const Datei, Kapitel: string);
    destructor Destroy; override;

    function getTitle: string;
    function getKapitelAndTitle: string;

    procedure AddSouceUnit1(const datei: string);

    procedure AddPascalCode(datei: string);
    procedure AddTextCode(const datei: string);
    procedure AddGLSLCode(const datei: string);
  end;

function WikiTitelSplitt(s: string): string;
function WikiAddLink(const Link, detail: string): string;

implementation

function WikiAddLink(const Link, detail: string): string;
begin
  Result := '* [' + Link + ' ' + Detail + ']';
  //  Result := '<a href="' + Link + '">' + Detail + '</a>';
end;

function WikiTitelSplitt(s: string): string;
begin
  Result := StringReplace(s, '_', ' ', [rfReplaceAll]);
  Result := ExtractFileName(Result);
end;

{ TCreateWikiTutorial }

constructor TCreateWikiTutorial.Create(const Datei, Kapitel: string);
begin
  inherited Create;
  fFolder := Datei;
  fKapitel := Kapitel;

  slWiki := TStringList.Create;
  slCode := TStringList.Create;
  slCode.SkipLastLineBreak := True;
  slMatrix := TStringList.Create;
  slMatrix.SkipLastLineBreak := True;
end;

destructor TCreateWikiTutorial.Destroy;
var
  sl2: TStringList;
begin
  ForceDirectories(TutPara.WikiPfad + fFolder + DirectorySeparator);

  CopyFile(TutPara.TutPfad + fFolder + '/image.png', TutPara.WikiPfad + fFolder + '/' + getKapitelAndTitle + '.png');
  //  CopyFile(TutPara.TutPfad + fFolder + '/description.txt', TutPara.WikiPfad + fFolder + '/' + getKapitelAndTitle + '.txt');

  sl2 := TStringList.Create;

  sl2.Add('[[Image:' + TutPara.Titel + ' - ' + getKapitelAndTitle + '.png|200px]]<br><br>');
  sl2.Add('=' + getKapitelAndTitle + ' =');
  sl2.Add('== Einleitung ==');

  Test_bold_Title(slWiki);

  sl2.Add(slWiki.Text);


  sl2.Text := StringReplace(sl2.Text, '<b>', #39#39#39, [rfReplaceAll]);
  sl2.Text := StringReplace(sl2.Text, '</b>', #39#39#39, [rfReplaceAll]);

  sl2.Text := StringReplace(sl2.Text, '<hr>', '<br>', [rfReplaceAll]);

  sl2.Add('<br>Autor: [[Mathias]]');
  sl2.Add('== Siehe auch ==');
  sl2.Add('* Übersichtseite [[' + TutPara.Titel + ']]');

  sl2.SaveToFile(TutPara.WikiPfad + fFolder + DirectorySeparator + 'wiki.txt');

  sl2.Free;
  slWiki.Free;
  slCode.Free;
  slMatrix.Free;
  inherited Destroy;
end;

function TCreateWikiTutorial.getTitle: string;
begin
  Result := WIKITitelSplitt(fFolder);
end;

function TCreateWikiTutorial.getKapitelAndTitle: string;
begin
  Result := Copy(fKapitel, 6) + ' - ' + Copy(getTitle, 6);
end;

procedure TCreateWikiTutorial.CutBlock(sl: TStrings; Block: string);
var
  slTemp: TStringList;
  i: integer;
  isBlock: boolean;
begin
  slTemp := TStringList.Create;
  slTemp.Assign(sl);
  sl.Clear;

  isBlock := False;
  for i := 0 to slTemp.Count - 1 do begin
    if isBlock and (Pos('//' + Block + '-', slTemp[i]) > 0) then begin
      Break;
    end;
    if isBlock then begin
      sl.Add(slTemp[i]);
    end;

    if Pos('//' + Block + '+', slTemp[i]) > 0 then begin
      isBlock := True;
    end;
  end;

  slTemp.Free;
end;

procedure TCreateWikiTutorial.Test_bold_Title(sl: TStrings);
var
  i: integer;
begin
  for i := 0 to sl.Count - 1 do begin
    if Pos('<b>', sl[i]) = 1 then begin
      if Pos('</b><br>', sl[i]) = Length(sl[i]) - 7 then begin
        sl[i] := StringReplace(sl[i], '<b>', '==', [rfReplaceAll]);
        sl[i] := StringReplace(sl[i], '</b>', '==', [rfReplaceAll]);
        sl[i] := StringReplace(sl[i], '<br>', '', [rfReplaceAll]);
      end;
    end;
  end;

end;


procedure TCreateWikiTutorial.createMatrix(sl: TStrings);
var
  i, l: integer;
  slTemp: TStringList;
  s: string;
begin
  slTemp := TStringList.Create;
  slTemp.Add('{| class="wikitable"');
  for i := 0 to sl.Count - 1 do begin
    s := sl[i];

    for l := Length(s) - 1 downto 2 do begin
      if s[l]='|' then Insert('|', s, l);
    end;
    Delete(s, Length(s), 1);

    s:=StringReplace(s, '| ', '| style="width:3em;height:3em;text-align:center"| ',[rfReplaceAll] );

    slTemp.Add(s);
    slTemp.Add('|-');
  end;
  slTemp.Add('|}');
  sl.Text := slTemp.Text;
  slTemp.Free;
end;

procedure TCreateWikiTutorial.AddPascalCode(datei: string);
var
  sl: TStringList;
  p: integer;
  block: string;
begin
  p := Pos(' ', datei);
  block := '';
  if p > 0 then begin
    block := Copy(datei, p + 1);
    datei := Copy(datei, 0, p - 1);
  end;

  sl := TStringList.Create;
  sl.LoadFromFile(datei);
  sl.SkipLastLineBreak := False;

  // Zeilen auserhalb Block entfernen.
  if block <> '' then begin
    CutBlock(sl, block);
  end;

  slWiki.Add('<syntaxhighlight lang="pascal">' + sl.Text + '</syntaxhighlight>');

  sl.Free;
end;

procedure TCreateWikiTutorial.AddTextCode(const datei: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  sl.LoadFromFile(datei);
  sl.SkipLastLineBreak := False;

  slWiki.Add('<syntaxhighlight>' + sl.Text + '</syntaxhighlight>');

  sl.Free;
end;

procedure TCreateWikiTutorial.AddGLSLCode(const datei: string);
var
  slGLSL: TStringList;
begin
  slGLSL := TStringList.Create;
  slGLSL.LoadFromFile(datei);
  slGLSL.SkipLastLineBreak := False;

  slWiki.Add('<syntaxhighlight lang="glsl">' + slGLSL.Text + '</syntaxhighlight>');

  slGLSL.Free;
end;


procedure TCreateWikiTutorial.AddSouceUnit1(const datei: string);
var
  slUnit: TStringList;
  i, p: integer;
  isText, isCode, isRemove, isTable, isMatrix: boolean;
begin
  slUnit := TStringList.Create;
  slUnit.LoadFromFile(datei);

  isText := False;
  isCode := False;
  isRemove := False;
  isTable := False;
  isMatrix := False;

  for i := 0 to slUnit.Count - 1 do begin
    if Pos('//includeglsl ', slUnit[i]) > 0 then begin
      AddGLSLCode(TutPara.TutPfad + fFolder + '/' + Copy(slUnit[i], 15));
    end else if Pos('//includepascal ', slUnit[i]) > 0 then begin
      AddPascalCode(TutPara.TutPfad + fFolder + '/' + Copy(slUnit[i], 17));
    end else if Pos('//includetext ', slUnit[i]) > 0 then begin
      AddTextCode(TutPara.TutPfad + fFolder + '/' + Copy(slUnit[i], 15));
    end else if Pos('//image ', slUnit[i]) > 0 then begin

      //      slWiki.Add('[[Image:' + getKapitelAndTitle + '.png|200px]]<br><br>');

      //      slWiki.Add('<img src="' + Copy(slUnit[i], 9) + '" alt="Selfhtml"><br><br>');
    end else if Pos('//lineal', slUnit[i]) > 0 then begin
      slWiki.Add('<hr><br>');
    end else if Pos('//link ', slUnit[i]) > 0 then begin
      p := Pos(' ', Copy(slUnit[i], 8));
      slWiki.Add(WikiAddLink(Copy(slUnit[i], 8, p), Copy(slUnit[i], 8 + p)));
    end else if Pos('//remove+', slUnit[i]) > 0 then begin
      isRemove := True;
    end else if Pos('//remove-', slUnit[i]) > 0 then begin
      isRemove := False;
      // Pascal Code
    end else if Pos('//code+', slUnit[i]) > 0 then begin
      isCode := True;
      slCode.Clear;
    end else if Pos('//code-', slUnit[i]) > 0 then begin
      isCode := False;
      //      TagPascal(slCode);
      slWiki.Add('<syntaxhighlight lang="pascal">' + slCode.Text + '</syntaxhighlight>');
      // Text Code ( Keine Systaxhiglight )
    end else if Pos('//codetext+', slUnit[i]) > 0 then begin
      isCode := True;
      slCode.Clear;
    end else if Pos('//codetext-', slUnit[i]) > 0 then begin
      isCode := False;
      slWiki.Add('<syntaxhighlight lang="text">' + slCode.Text + '</syntaxhighlight>');
    end else if Pos('(*', slUnit[i]) > 0 then begin
      isText := True;
    end else if Pos('*)', slUnit[i]) > 0 then begin
      isText := False;
    end else if Pos('{|', slUnit[i]) > 0 then begin // Wiki-Tabelle
      slWiki.Add(slUnit[i]);
      isTable := True;
    end else if Pos('|}', slUnit[i]) > 0 then begin
      slWiki.Add(slUnit[i]);
      isTable := False;
    end else if Pos('//matrix+', slUnit[i]) > 0 then begin // Matrix
      isMatrix := True;
      slMatrix.Clear;
    end else if Pos('//matrix-', slUnit[i]) > 0 then begin
      isMatrix := False;
      createMatrix(slMatrix);
      slWiki.Add(slMatrix.Text);
    end else if isCode then begin
      if not isRemove then begin
        slCode.Add(slUnit[i]);
      end;
    end else if isMatrix then begin
      if not isRemove then begin
        slMatrix.Add(slUnit[i]);
      end;
    end else if isText then begin
      if isTable then begin
        slWiki.Add(slUnit[i]);
      end else begin
        slWiki.Add(slUnit[i] + '<br>');
      end;
    end;
  end;

  slUnit.Free;
end;

end.
