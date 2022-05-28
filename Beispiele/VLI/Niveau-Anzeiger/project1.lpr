program project1;

{$mode objfpc}{$H+}

uses
 {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
     {$ENDIF}   {$ENDIF}
  Forms, ExtCtrls,
  Interfaces,
  HauptFenster,
  AnzeigerOptionen;

{$R *.res}

begin
  Application.Title := 'Niveau-Anzeiger';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(THauptForm, HauptForm);
  Application.CreateForm(TAnzeigerOptionenForm, AnzeigerOptionenForm);
  Application.Run;
end.
