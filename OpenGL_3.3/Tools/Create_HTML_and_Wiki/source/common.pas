unit Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  ConfigINIDatei = 'config.ini';
  INISektion_tut_pfad = 'tut_pfad';

var
  TutPara: record
    Titel, TutPfad, HTMLPfad, WikiPfad, ReadmeMDPfad: string;
  end;


implementation

end.

