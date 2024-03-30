unit oglShader;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
//  gl, glext;
  oglGL,  oglGLext;

type
  GLenum = TGLenum;
  GLint = TGLint;
  GLuint = TGLuint;

  TShader = class(TObject)
  private
    FProgramObject: TGLint;
    function Split(AShader: ansistring): TStringArray;
  public
    property ID: TGLint read FProgramObject;

    constructor Create(const AShader: array of ansistring);
    constructor Create;
    destructor Destroy; override;
    procedure LoadShaderObject(shaderType: GLenum; const AShader: ansistring);
    procedure LinkProgram;
    procedure UseProgram;

    function UniformLocation(ch: PGLChar): GLint;
    function UniformBlockIndex(ch: PGLChar): GLuint;
    function AttribLocation(ch: PGLChar): GLint;
    function ShaderVersion: string;
  end;


  // ---- Hilfsfunktionen ----

function ResourceToStr(Resource: string): ansistring;


implementation

function ResourceToStr(Resource: string): ansistring;
var
  rs: TResourceStream;
  pc10: PChar = nil;
begin
  rs := TResourceStream.Create(HINSTANCE, Resource, pc10);
  SetLength(Result, rs.Size);
  rs.Read(PChar(Result)^, rs.Size);
  rs.Free;
end;

function ShadercodeToStr(code: GLint): string;
begin
  case code of
    GL_VERTEX_SHADER: begin
      Result := 'Vertex-Shader';
    end;
    GL_FRAGMENT_SHADER: begin
      Result := 'Fragment-Shader';
    end;
    GL_GEOMETRY_SHADER: begin
      Result := 'Geometrie-Shader';
    end;
    GL_TESS_CONTROL_SHADER: begin
      Result := 'Tessellation-Control-Shader';
    end;
    GL_TESS_EVALUATION_SHADER: begin
      Result := 'Tessellation-Evaluation-Shader';
    end;
    else begin
      Result := 'Shader-Code: ' + IntToStr(code);
    end;
  end;
end;

{ TShader }

function TShader.Split(AShader: ansistring): TStringArray;
const
  Key: array[0..2] of string = ('$vertex', '$geometrie', '$fragment');
var
  spos: array[0..3] of integer;
  i: integer;
begin
  for i := 0 to Length(Key) - 1 do begin
    spos[i] := Pos(Key[i], AShader);
  end;
  spos[3] := Length(AShader) + 1;

  if spos[1] <> 0 then begin
    SetLength(Result, 3);
    Result[0] := Copy(AShader, spos[0] + Length(Key[0]), spos[1] - spos[0] - Length(Key[0]));
    Result[1] := Copy(AShader, spos[1] + Length(Key[1]), spos[2] - spos[1] - Length(Key[1]));
    Result[2] := Copy(AShader, spos[2] + Length(Key[2]), spos[3] - spos[2] - Length(Key[2]));
  end else begin
    SetLength(Result, 2);
    Result[0] := Copy(AShader, spos[0] + Length(Key[0]), spos[2] - spos[0] - Length(Key[0]));
    Result[1] := Copy(AShader, spos[2] + Length(Key[2]), spos[3] - spos[2] - Length(Key[2]));
  end;
end;

constructor TShader.Create;
begin
  inherited Create;
  FProgramObject := glCreateProgram();
end;

(*
=== Beispiel für Shadererzeugung ===

Shader := TShader.Create;
Shader.LoadShaderObjectFromFile(GL_VERTEX_SHADER, 'Vertexshader.glsl');
Shader.LoadShaderObjectFromFile(GL_GEOMETRY_SHADER, 'Geometrieshader.glsl');
Shader.LoadShaderObjectFromFile(GL_FRAGMENT_SHADER, 'Fragmentshader.glsl');
Shader.LinkProgram;
Shader.UseProgram;
 *)

constructor TShader.Create(const AShader: array of ansistring);
var
  sa: TStringArray = nil;
begin
  Create;
  case Length(AShader) of
    1: begin
      sa := Split(AShader[0]);
    end;
    2: begin
      SetLength(sa, Length(AShader));
      sa[0] := AShader[0];
      sa[1] := AShader[1];
    end;
    else begin
      WriteLn('Ungültige Anzahl Shader-Objecte: ' + IntToStr(Length(AShader)));
    end;
  end;
  if Length(sa) = 2 then begin
    LoadShaderObject(GL_VERTEX_SHADER, sa[0]);
    LoadShaderObject(GL_FRAGMENT_SHADER, sa[1]);
  end else if Length(sa) = 3 then begin
    LoadShaderObject(GL_VERTEX_SHADER, sa[0]);
    LoadShaderObject(GL_GEOMETRY_SHADER, sa[1]);
    LoadShaderObject(GL_FRAGMENT_SHADER, sa[2]);
  end;
  LinkProgram;
end;

procedure TShader.LoadShaderObject(shaderType: GLenum; const AShader: ansistring);
var
  ShaderObject: TGLint;
  pc: array of char = nil;
  l: GLint;

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
    WriteLn('FEHLER in ' + ShadercodeToStr(shaderType) + '!', AShader + LineEnding + PChar(pc) + LineEnding);
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

function TShader.UniformLocation(ch: PGLChar): GLint;
begin
  Result := glGetUniformLocation(FProgramObject, ch);
  if Result = -1 then begin
    WriteLn('Uniform Fehler: ' + ch + ' code: ' + IntToStr(Result));
  end;
end;

function TShader.UniformBlockIndex(ch: PGLChar): GLuint;
begin
  Result := glGetUniformBlockIndex(FProgramObject, ch);
  if Result = GL_INVALID_INDEX then begin
    WriteLn('UniformBlock Fehler: ' + ch + ' code: ' + IntToStr(Result));
  end;
end;

function TShader.AttribLocation(ch: PGLChar): GLint;
begin
  Result := glGetAttribLocation(FProgramObject, ch);
  if Result = -1 then begin
    WriteLn('Attrib Fehler: ' + ch + ' code: ' + IntToStr(Result));
  end;
end;

procedure TShader.UseProgram;
const
  ID_alt: GLuint = 0;
begin
  if FProgramObject <> ID_alt then begin
    ID_alt := FProgramObject;
    glUseProgram(FProgramObject);
  end;
end;

function TShader.ShaderVersion: string;
begin
  Result := 'Shader Version: ' + PChar(glGetString(GL_SHADING_LANGUAGE_VERSION));
end;

end.
