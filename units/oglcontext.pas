unit oglContext;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, dglOpenGL, OpenGLContext;

type
  TContext = class(TCustomOpenGLControl)
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
  StencilBits:=1;
  Align := alClient;
  //  MultiSampling:=4;
  Parent := TheOwner;

  InitOpenGL;
  MakeCurrent;

  ReadExtensions;
  ReadOpenGLCore;
  ReadImplementationProperties;
end;

end.
