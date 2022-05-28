{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit VLI_OpenGL;

{$warn 5023 off : no warning about unused units}
interface

uses
  VLIAnzeigeschiene, VLIArmaflex, VLIFluegeli, VLIFlansch, VLISchwimmer, 
  VLIStandRohr, VLIStutzen, VLIBasis, VLIWasser, VLIDichtung, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('VLI_OpenGL', @Register);
end.
