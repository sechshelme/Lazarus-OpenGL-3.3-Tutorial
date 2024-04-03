{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ogl_Package;

{$warn 5023 off : no warning about unused units}
interface

uses
  oglShader, oglTextur, oglMatrix, oglContext, oglDebug, oglVector, 
  oglVectors, oglBackground, oglCamera, oglColorKoerper, oglDarstellung, 
  oglKoerper, oglLighting, oglLightingShader, oglLinesVAO, oglSteuerung, 
  oglTexturKoerper, oglTexturVAO, oglUBO, oglUnit, oglVAO, oglVBO, 
  oglWaveFrontOBJ, oglglad_gl, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('ogl_Package', @Register);
end.
