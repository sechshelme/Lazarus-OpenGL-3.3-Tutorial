{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ogl_Package;

{$warn 5023 off : no warning about unused units}
interface

uses
  oglLighting, dglOpenGL, oglShader, oglTexturVAO, oglWaveFrontOBJ, 
  oglBackground, oglTexturKoerper, oglUnit, oglTextur, oglVAO, 
  oglColorKoerper, oglLinesVAO, oglVBO, oglDarstellung, oglKoerper, oglCamera, 
  oglMatrix, oglSteuerung, oglUBO, oglLightingShader, oglContext, oglLogForm, 
  oglVector, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('ogl_Package', @Register);
end.
