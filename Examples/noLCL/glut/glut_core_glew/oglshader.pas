unit oglShader;

{$mode objfpc}{$H+}

interface

uses
  fp_glew;

type
  TShader = class(TObject)
  private
    FProgramObject: TGLint;
  public
    property ID: TGLint read FProgramObject;

    constructor Create;
    destructor Destroy; override;
    procedure LoadShaderObject(shaderType: TGLenum; const AShader: ansistring);
    procedure LinkProgram;
    procedure UseProgram;
  end;

implementation

{ TShader }

constructor TShader.Create;
begin
  inherited Create;
  FProgramObject := glCreateProgram(nil);
end;

procedure TShader.LoadShaderObject(shaderType: TGLenum; const AShader: ansistring);
var
  ShaderObject: TGLint;
  pc: array of char = nil;
  l: TGLint;

  ErrorStatus: TGLboolean;
  InfoLogLength: TGLsizei;
begin
  ShaderObject := glCreateShader(shaderType);

  l := Length(AShader);
  glShaderSource(ShaderObject, 1, @AShader, @l);
  glCompileShader(ShaderObject);
  glAttachShader(FProgramObject, ShaderObject);

  // Check  Shader
  glGetShaderiv(ShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  glGetShaderiv(ShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
  SetLength(pc, InfoLogLength + 1);
  glGetShaderInfoLog(ShaderObject, InfoLogLength, nil, PChar(pc));

  if ErrorStatus = GL_FALSE then begin
    WriteLn('FEHLER: ',PChar( pc));
  end;

  glDeleteShader(ShaderObject);
end;

procedure TShader.LinkProgram;
var
  pc: array of char = nil;
  ErrorStatus: TGLboolean;
  InfoLogLength: TGLsizei;
begin
  glLinkProgram(FProgramObject);

  // Check  Link
  glGetProgramiv(FProgramObject, GL_LINK_STATUS, @ErrorStatus);

  if ErrorStatus = GL_FALSE then begin
    glGetProgramiv(FProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(pc, InfoLogLength + 1);
    glGetProgramInfoLog(FProgramObject, InfoLogLength, nil, PChar(pc));
    WriteLn('SHADER LINK:', PChar(pc));
  end;
end;

destructor TShader.Destroy;
begin
  glDeleteProgram(FProgramObject);
end;

procedure TShader.UseProgram;
const
  ID_alt: TGLuint = 0;
begin
  if FProgramObject <> ID_alt then begin
    ID_alt := FProgramObject;
    glUseProgram(FProgramObject);
  end;
end;

end.
