unit SourceZip;

{$mode objfpc}{$H+}

interface

uses
  Classes, Controls, SysUtils, FileUtil, Dialogs, zipper;

type

  { TSourceZip }

  TSourceZip = class(TObject)
  public
    procedure kopiere;
  end;

implementation

uses
  CreateTutorial;

{ TSourceZip }

procedure TSourceZip.kopiere;
var
  slSourceZip: TStringList;
  i: integer;
  pfadalt, s: string;
  zip: TZipper;
begin
  CopyDirTree(TutPfad, HTMLPfad + 'source/', []);

  pfadalt := GetCurrentDir;
  chdir(HTMLPfad);

  slSourceZip := FindAllFiles('source/');

  for i := 0 to slSourceZip.Count - 1 do begin
    s := slSourceZip[i];
    if ExtractFileName(s) = 'project1' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'project1.exe' then begin
      DeleteFile(s);
    end;
    if ExtractFileName(s) = 'project1.deb' then begin
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
