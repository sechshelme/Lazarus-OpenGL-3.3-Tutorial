unit Global;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  ConfigINIDatei = 'config.ini';
  INISektion_tut_pfad = 'tut_pfad';

var
  TutPara: record
    Titel, TutPfad, HTMLPfad, WikiPfad: string;
  end;


implementation

end.

