unit CreateTutorial;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, FileUtil, StdCtrls, ResWort;

const
  HTMLPfad = '../../html/';
  TutPfad = '../../Tutorial/';
  bgColor = $DDDDFF;

  ResWortColor = '0000BB';
  DefineColor = '008800';
  ComentColor = 'FFFF00';
  BKColor = 'BBBBFF';
  FontColor = '000000';
  stringColor = 'FF0000';
  NumberColor = '0077BB';


type

  { TCreateTutorial }

  TCreateTutorial = class(TObject)
  private
    slCode, slHTML: TStringList;
    fFolder, fKapitel: string;

    procedure TagPascal(CodeSL: TStrings);
    procedure TagGLSL(glslCodeSL: TStrings);
    function TagResWort(const s: string; const ResWort: string): string;
    function TagNumberAndString(const s: string): string;
  public
    constructor Create(const Datei, Kapitel: string);
    destructor Destroy; override;

    function getTitle: string;

    procedure AddSouceUnit1(datei: string);

    procedure AddTextCode(datei: string);
    procedure AddGLSLCode(datei: string);
  end;

function TitelSplitt(s: string): string;
function AddLink(const Link, detail: string): string;

implementation

function AddLink(const Link, detail: string): string;
begin
  Result := '<a href="' + Link + '">' + Detail + '</a>';
end;

function TitelSplitt(s: string): string;
begin
  Result := StringReplace(s, '_', ' ', [rfReplaceAll]);
  Result := ExtractFileName(Result);
end;

{ TCreateTutorial }

constructor TCreateTutorial.Create(const Datei, Kapitel: string);
begin
  inherited Create;
  fFolder := Datei;
  fKapitel := Kapitel;

  slHTML := TStringList.Create;
  slCode := TStringList.Create;
  slCode.SkipLastLineBreak := True;
end;

destructor TCreateTutorial.Destroy;
var
  sl2: TStringList;
begin
  sl2 := TStringList.Create;

  sl2.Add('<!DOCTYPE html>');
  sl2.Add('<html>');
  sl2.Add('  <head>');
  sl2.Add('    <meta charset="utf-8">');
  sl2.Add('    <title>' + getTitle + '</title>');
  sl2.Add('    <style>');
  sl2.Add('      pre {background-color:#' + BKColor + '; color:#' + FontColor + '; font-family: Fixedsys,Courier,monospace; padding:10px;}');
  sl2.Add('    </style>');
  sl2.Add('  </head>');
  sl2.Add('  <body bgcolor="#' + IntToHex(bgColor, 6) + '">');
  sl2.Add('    <b><h1>' + fKapitel + '</h1></b>');
  sl2.Add('    <b><h2>' + getTitle + '</h2></b>');

  sl2.Add(slHTML.Text);

  sl2.Add('    <br><br><br>');
  sl2.Add('<h2>' + AddLink('../../index.html', 'zurück') + '</h2>');
  sl2.Add('  </body>');
  sl2.Add('</html>');

  ForceDirectories(HTMLPfad + fFolder + DirectorySeparator);
  CopyFile(TutPfad + fFolder + '/image.png', HTMLPfad + fFolder + '/image.png');
  sl2.SaveToFile(HTMLPfad + fFolder + DirectorySeparator + 'index.html');

  sl2.Free;
  slHTML.Free;
  slCode.Free;
  inherited Destroy;
end;

function TCreateTutorial.TagResWort(const s: string; const ResWort: string): string;
var
  TagLeft, TagRight: string;
  TagSize: integer;

  function TestLeft(const s: string; p: integer): boolean;
  begin
    Result := True;
    if p > 0 then begin
      if s[p - 1] in ['0'..'9', 'A'..'Z', 'a'..'z', '_'] then begin
        Result := False;
      end;
    end;
  end;

  function TestRight(const s: string; const rw: string; p: integer): boolean;
  var
    l: integer;
  begin
    Result := True;
    l := Length(s);
    if p + Length(rw) < l then begin
      if s[p + Length(rw)] in ['0'..'9', 'A'..'Z', 'a'..'z', '_'] then begin
        Result := False;
      end;
    end;
  end;

var
  PosNeu, PosAlt, PosKom: integer;
begin
  Result := s;
  TagLeft := '<b><font color="' + ResWortColor + '">';
  TagRight := '</font></b>';
  TagSize := Length(TagLeft) + Length(TagRight);
  PosAlt := 0;
  repeat
    PosKom := Pos('//', Result);
    PosNeu := Pos(UpCase(ResWort), copy(UpCase(Result), PosAlt + 1));

    if PosNeu > 0 then begin
      if (PosKom = 0) or (PosNeu + PosAlt < PosKom) then begin
        if TestLeft(Result, PosNeu + PosAlt) then begin
          if TestRight(Result, ResWort, PosNeu + PosAlt) then begin

            Insert(TagRight, Result, PosNeu + PosAlt + Length(ResWort));
            Insert(TagLeft, Result, PosNeu + PosAlt);

            PosAlt := PosAlt + TagSize;
          end;
        end;
      end;
      PosAlt := PosAlt + PosNeu + Length(ResWort);
    end;

  until PosNeu = 0;
end;

function TCreateTutorial.TagNumberAndString(const s: string): string;
var
  p,
  ComentPos: integer;   // Position Kommentar
  isString,             // String wird getagt
  isNumber,             // Zahl wird getagt
  isNoNumber: boolean;  // Kein Zahlenwert, Zahl ist in Variablen-Bezeichner
begin
  Result := s;
  p := 1;
  isString := False;
  isNumber := False;
  if Length(Result) > 1 then begin
    repeat
      if Result[p] = #39 then begin
        isString := not isString;
        if isString then begin
          Insert('<font color="#' + stringColor + '">', Result, p);
          Inc(p, 22);
        end else begin
          Insert('</font>', Result, p + 1);
          Inc(p, 7);
        end;
      end;

      if not isString then begin

        if Result[p] in ['A'..'Z', 'a'..'z', '_'] then begin
          if not isNumber then begin
            isNoNumber := True;
          end;
        end;

        if not (Result[p] in ['0'..'9', '$', 'A'..'Z', 'a'..'z', '_']) then begin
          isNoNumber := False;
        end;

        if not isNoNumber then begin
          if Result[p] in ['0'..'9', '$'] then begin
            if not isNumber then begin
              isNumber := True;
              Insert('<font color="#' + NumberColor + '">', Result, p);
              Inc(p, 22);
            end;
          end else begin
            if isNumber then begin
              isNumber := False;
              Insert('</font>', Result, p);
              Inc(p, 7);
            end;
          end;

        end;
      end;

      Inc(p);
      ComentPos := Pos('//', Result);
    until (p > Length(Result)) or ((p >= ComentPos) and (ComentPos <> 0));
  end;
  if isString or isNumber then begin
    Result := Result + '</font>';
  end;
end;

procedure TCreateTutorial.TagPascal(CodeSL: TStrings);
var
  i, p, j: integer;
  s: string;
begin
  for i := 0 to CodeSL.Count - 1 do begin
    CodeSL[i] := TagNumberAndString(CodeSL[i]);

    for j := 0 to Length(res_Wort_FPC) - 1 do begin
      CodeSL[i] := TagResWort(CodeSL[i], res_Wort_FPC[j]);
    end;

    p := Pos('//', CodeSL[i]);
    if p > 0 then begin
      s := CodeSL[i];
      Insert('<i><font color="#' + ComentColor + '">', s, p);
      s := s + '</font></i>';
      CodeSL[i] := s;
    end;

  end;
end;

procedure TCreateTutorial.TagGLSL(glslCodeSL: TStrings);
var
  i, p, j: integer;
  s: string;
begin
  for i := 0 to glslCodeSL.Count - 1 do begin

    glslCodeSL[i] := TagNumberAndString(glslCodeSL[i]);

    for j := 0 to Length(res_Wort_glsl) - 1 do begin
      glslCodeSL[i] := TagResWort(glslCodeSL[i], res_Wort_glsl[j]);
    end;

    p := Pos('#', glslCodeSL[i]);
    if p = 1 then begin
      s := glslCodeSL[i];

      Insert('</font></b>', s, Pos(' ', s));
      Insert('<b><font color="#' + DefineColor + '">', s, p);

      glslCodeSL[i] := s;
    end;
    p := Pos('//', glslCodeSL[i]);
    if p > 0 then begin
      s := glslCodeSL[i];
      Insert('<i><font color="#' + ComentColor + '">', s, p);
      s := s + '</font></i>';
      glslCodeSL[i] := s;
    end;
  end;
end;

function TCreateTutorial.getTitle: string;
begin
  Result := TitelSplitt(fFolder);
end;

procedure TCreateTutorial.AddTextCode(datei: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  sl.LoadFromFile(datei);
  sl.SkipLastLineBreak := False;

  slHTML.Add('<pre><code>' + sl.Text + '</pre></code>');

  sl.Free;
end;

procedure TCreateTutorial.AddGLSLCode(datei: string);
var
  slGLSL: TStringList;
begin
  slGLSL := TStringList.Create;
  slGLSL.LoadFromFile(datei);
  slGLSL.SkipLastLineBreak := False;

  TagGLSL(slGLSL);

  slHTML.Add('<pre><code>' + slGLSL.Text + '</pre></code>');

  slGLSL.Free;
end;

procedure TCreateTutorial.AddSouceUnit1(datei: string);
var
  slUnit: TStringList;
  i, p: integer;
  isText, isCode, isRemove: boolean;
begin
  slUnit := TStringList.Create;
  slUnit.LoadFromFile(datei);

  isText := False;
  isCode := False;
  isRemove := False;

  for i := 0 to slUnit.Count - 1 do begin
    if Pos('//includeglsl ', slUnit[i]) > 0 then begin
      AddGLSLCode(TutPfad + fFolder + '/' + Copy(slUnit[i], 15));
    end else if Pos('//includetext ', slUnit[i]) > 0 then begin
      AddTextCode(TutPfad + fFolder + '/' + Copy(slUnit[i], 15));
    end else if Pos('//image ', slUnit[i]) > 0 then begin
      slHTML.Add('<img src="' + Copy(slUnit[i], 9) + '" alt="Selfhtml"><br><br>');
    end else if Pos('//lineal', slUnit[i]) > 0 then begin
      slHTML.Add('<hr><br>');
    end else if Pos('//link ', slUnit[i]) > 0 then begin
      p := Pos(' ', Copy(slUnit[i], 8));
      slHTML.Add(AddLink(Copy(slUnit[i], 8, p), Copy(slUnit[i], 8 + p)));
    end else if Pos('//remove+', slUnit[i]) > 0 then begin
      isRemove := True;
    end else if Pos('//remove-', slUnit[i]) > 0 then begin
      isRemove := False;
    end else if Pos('//code+', slUnit[i]) > 0 then begin
      isCode := True;
      slCode.Clear;
    end else if Pos('//code-', slUnit[i]) > 0 then begin
      isCode := False;
      TagPascal(slCode);
      slHTML.Add('<pre><code>' + slCode.Text + '</pre></code>');
    end else if Pos('(*', slUnit[i]) > 0 then begin
      isText := True;
    end else if Pos('*)', slUnit[i]) > 0 then begin
      isText := False;
    end else if isCode then begin
      if not isRemove then begin
        slCode.Add(slUnit[i]);
      end;
    end else if isText then begin
      slHTML.Add(slUnit[i] + '<br>');
    end;
  end;

  slUnit.Free;
end;

end.
