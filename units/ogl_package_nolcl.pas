{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ogl_package_noLCL;

{$warn 5023 off : no warning about unused units}
interface

uses
  oglDebug, oglglad_GL, oglMatrix, oglShader, oglTextur, oglVector, 
  oglVectors, oglGLFW3, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('ogl_package_noLCL', @Register);
end.
