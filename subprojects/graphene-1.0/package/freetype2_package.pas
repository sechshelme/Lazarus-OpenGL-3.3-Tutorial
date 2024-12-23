{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit FreeType2_Package;

{$warn 5023 off : no warning about unused units}
interface

uses
  FreeType2, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('FreeType2_Package', @Register);
end.
