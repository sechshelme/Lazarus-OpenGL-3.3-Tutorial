unit SourceZip;

{$mode objfpc}{$H+}

interface

uses
  Classes, Controls, SysUtils, FileUtil, Dialogs,
  zipper, IniFiles,
  Common;

type

  { TSourceZip }

  TSourceZip = class(TObject)
  public
    procedure kopieren;
  end;

implementation

//uses
//  CreateHTMLTutorial;

{ TSourceZip }


procedure TSourceZip.kopieren;
var
  sl, slFiles,
  slSourceZip: TStringList;
  i, j: integer;
  unitPfad,
  pfadalt, s: string;
  zip: TZipper;
  iniDatei: TIniFile;
begin
  if TutPara.TutPfad = '' then begin
    ShowMessage('Kein Tutorial angegeben');
    Exit;
  end;

  if TutPara.HTMLPfad = '' then begin
    ShowMessage('Kein HTML-Pfad angegeben');
    Exit;
  end;

  // --- Tutorial in source-Ordner kopieren und überflüssiges löschen.

  CopyDirTree(TutPara.TutPfad, TutPara.HTMLPfad + 'source/', []);

  pfadalt := GetCurrentDir;
  chdir(TutPara.HTMLPfad);

  slSourceZip := FindAllFiles('source/');

  for i := 0 to slSourceZip.Count - 1 do begin
    s := slSourceZip[i];
    if ExtractFileName(s) = 'project1' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'Project1' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'project1.exe' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'Project1.exe' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'project1.deb' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'Project1.deb' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'description.txt' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'lib' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'backup' then begin
      DeleteDirectory(s, False);
    end;
  end;
  slSourceZip.Free;

  slSourceZip := FindAllDirectories('source/');
  for i := 0 to slSourceZip.Count - 1 do begin
    s := slSourceZip[i];
    if ExtractFileName(s) = 'backup' then begin
      DeleteDirectory(s, False);
    end;
  end;
  slSourceZip.Free;

  // --- Wenn Units in INI-File, dies suchen und in den source-Ordner kopieren.

  iniDatei := TIniFile.Create(TutPara.TutPfad + '/create_tut.ini');
  sl := TStringList.Create;
  iniDatei.ReadSection('units', sl);

  for i := 0 to sl.Count - 1 do begin
    unitPfad := iniDatei.ReadString('units', sl[i], '');

    slFiles := FindAllFiles(unitPfad, '', False);
    //    mkdir(TutPara.HTMLPfad + 'source/' + sl[i]);
    for j := 0 to slFiles.Count - 1 do begin
      CopyFile(slFiles[j], TutPara.HTMLPfad + 'source/' + sl[i] + '/' + ExtractFileName(slFiles[j]));
    end;

    slFiles.Free;
  end;

  sl.Free;
  iniDatei.Free;

  // --- Den source-Ordner ZIPen und anschliessend löschen.

  slSourceZip := FindAllFiles('source/');

  zip := TZipper.Create;
  zip.FileName := 'source.zip';
  zip.Entries.AddFileEntries(slSourceZip);
  zip.ZipAllFiles;
  zip.Free;

  DeleteDirectory('./source/', False);

  slSourceZip.Free;
  chdir(pfadalt);
end;

end.
