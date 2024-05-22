{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ogl_package_GLES32;

{$warn 5023 off : no warning about unused units}
interface

uses
  oglBackground, oglCamera, oglColorKoerper, oglDarstellung, oglFontTextur, 
  oglKoerper, oglLighting, oglLightingShader, oglLinesVAO, oglSteuerung, 
  oglTexturKoerper, oglTexturVAO, oglUBO, oglUnit, oglVAO, oglVBO, 
  oglWaveFrontOBJ, oglContext, oglDebug, oglglad_GLES32, oglMatrix, oglShader, 
  oglTextur, oglVector, oglVectors, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('ogl_package_GLES32', @Register);
end.
