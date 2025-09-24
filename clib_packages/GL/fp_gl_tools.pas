unit fp_GL_Tools;

interface

uses
  fp_glew;

type
  PShader = type Pointer;

function shader_new: PShader;
function shader_get_ID(shader: PShader): TGLint;
function shader_load_shaderobject(shader: PShader; shaderType: TGLenum; AShader: PChar): boolean;
function shader_link_program(shader: PShader): boolean;
function shader_get_errortext(shader: PShader): pchar;
procedure shader_use_program(shader: PShader);
function shader_uniform_location(shader: PShader; ch: PChar): TGLint;
function shader_uniform_blockindex(shader: PShader; ch: PChar): TGLuint;
function shader_attrib_location(shader: PShader; ch: PChar): TGLint;
procedure shader_unref(shader: PShader);

implementation

type
  TShaderPrivat = record
    FProgramObject: TGLint;
    error_text: string;
  end;
  PShaderPrivat = ^TShaderPrivat;

function shader_new: PShader;
var
  sh: PShaderPrivat absolute Result;
begin
  sh := GetMem(SizeOf(TShaderPrivat));
  sh^.FProgramObject := glCreateProgram(nil);
  sh^.error_text := '';
end;

function shader_get_ID(shader: PShader): TGLint;
var
  sh: PShaderPrivat absolute shader;
begin
  Result := sh^.FProgramObject;
end;

function shader_load_shaderobject(shader: PShader; shaderType: TGLenum;  AShader: PChar): boolean;
var
  sh: PShaderPrivat absolute shader;
  ShaderObject: TGLint;
  l: TGLint;

  ErrorStatus: TGLboolean;
  InfoLogLength: TGLsizei;
begin
  Result := True;
  ShaderObject := glCreateShader(shaderType);

  l := Length(AShader);
  glShaderSource(ShaderObject, 1, @AShader, @l);
  glCompileShader(ShaderObject);
  glAttachShader(sh^.FProgramObject, ShaderObject);

  // Check  Shader
  glGetShaderiv(ShaderObject, GL_COMPILE_STATUS, @ErrorStatus);
  glGetShaderiv(ShaderObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
  SetLength(sh^.error_text, InfoLogLength + 1);
  glGetShaderInfoLog(ShaderObject, InfoLogLength, nil, pchar(sh^.error_text));

  if ErrorStatus = GL_FALSE then begin
    Result := False;
  end;

  glDeleteShader(ShaderObject);
end;

function shader_link_program(shader: PShader): boolean;
var
  sh: PShaderPrivat absolute shader;
  ErrorStatus: TGLboolean;
  InfoLogLength: TGLsizei;
begin
  Result := True;
  glLinkProgram(sh^.FProgramObject);

  // Check  Link
  glGetProgramiv(sh^.FProgramObject, GL_LINK_STATUS, @ErrorStatus);

  if ErrorStatus = GL_FALSE then begin
    Result := False;
    glGetProgramiv(sh^.FProgramObject, GL_INFO_LOG_LENGTH, @InfoLogLength);
    SetLength(sh^.error_text, InfoLogLength + 1);
    glGetProgramInfoLog(sh^.FProgramObject, InfoLogLength, nil, pchar(sh^.error_text));
  end;
end;

function shader_get_errortext(shader: PShader): pchar;
var
  sh: PShaderPrivat absolute shader;
begin
  Result := pchar(sh^.error_text);
end;

procedure shader_use_program(shader: PShader);
var
  sh: PShaderPrivat absolute shader;
begin
  glUseProgram(sh^.FProgramObject);
end;

function shader_uniform_location(shader: PShader; ch: PChar): TGLint;
var
  sh: PShaderPrivat absolute shader;
begin
  Result := glGetUniformLocation(sh^.FProgramObject, ch);
end;

function shader_uniform_blockindex(shader: PShader; ch: PChar): TGLuint;
var
  sh: PShaderPrivat absolute shader;
begin
  Result := glGetUniformBlockIndex(sh^.FProgramObject, ch);
end;

function shader_attrib_location(shader: PShader; ch: PChar): TGLint;
var
  sh: PShaderPrivat absolute shader;
begin
  Result := glGetAttribLocation(sh^.FProgramObject, ch);
end;

procedure shader_unref(shader: PShader);
var
  sh: PShaderPrivat absolute shader;
begin
  glDeleteProgram(sh^.FProgramObject);
  sh^.error_text:='';
  Freemem(sh);
end;

end.
