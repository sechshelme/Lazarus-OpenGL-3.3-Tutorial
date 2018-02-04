unit oglContext;
{$include opts.inc}
{$mode objfpc}{$H+}

interface

uses
  {$IFDEF COREGL}
  glcorearb, dialogs,
  {$ELSE}
  dglOpenGL,
  {$ENDIF}
  Classes, SysUtils, Controls, OpenGLContext;

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
  Align := alClient;
  //  MultiSampling:=4;
  Parent := TheOwner;
  MakeCurrent;
  {$IFDEF COREGL}
  if not Load_GL_VERSION_3_3_CORE then begin
     writeln('Unable to load OpenGL 3.3 Core');
     showmessage('Unable to load OpenGL 3.3 Core');
  end;
  {$ELSE}
    InitOpenGL;
    //ReadExtensions;
    ReadOpenGLCore;
    ReadImplementationProperties;
  {$ENDIF}
end;

end.
