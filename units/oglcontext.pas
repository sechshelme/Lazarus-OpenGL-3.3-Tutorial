unit oglContext;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls,
  {$ifdef GLES32}
  oglglad_GLES32,
  {$else}
  oglglad_gl,
  {$endif}
  OpenGLContext;

type
//  TContext = class(TCustomOpenGLControl)
    TContext = class(TOpenGLControl)
  public
    constructor Create(TheOwner: TWinControl; AAutoResize: boolean = True; AMajorVersion: integer = 3; AMinorVersion: integer = 3);
  end;

implementation

constructor TContext.Create(TheOwner: TWinControl; AAutoResize: boolean; AMajorVersion: integer; AMinorVersion: integer);
begin
  inherited Create(TheOwner);
  AutoResizeViewport := AAutoResize;
  OpenGLMajorVersion := AMajorVersion;
  OpenGLMinorVersion := AMinorVersion;
  StencilBits := 8;
  Align := alClient;
  //  MultiSampling:=4;
  Parent := TheOwner;

  MakeCurrent;
  Load_GLADE;

  //InitOpenGL;
  //
  //ReadExtensions;
  //ReadOpenGLCore;
  //ReadImplementationProperties;
end;

end.
