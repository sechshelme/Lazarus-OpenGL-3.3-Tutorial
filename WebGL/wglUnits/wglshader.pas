unit wglShader;

{$mode ObjFPC}

interface

uses
  Types, SysUtils,
  BrowserConsole, WebGL, JS,
  wglCommon, wglMatrix;

type
  TShader = class
  private
    FProgramObject: TJSWebGLProgram;
    function GetShader(e: GLenum): string;
  public
    property ID: TJSWebGLProgram read FProgramObject;

    constructor Create;
    destructor Destroy; override;

    procedure LoadShaderObject(shaderType: GLenum; const AShader: string);
    procedure LinkProgram;
    procedure UseProgram;

    function AttribLocation(Name: string): GLint;
    function UniformLocation(Name: string): TJSWebGLUniformLocation;
  end;


implementation

constructor TShader.Create;
begin
  FProgramObject := gl.createProgram;
end;

destructor TShader.Destroy;
begin
  gl.DeleteProgram(FProgramObject);
  inherited Destroy;
end;

procedure TShader.LoadShaderObject(shaderType: GLenum; const AShader: string);
var
  ShaderObject: TJSWebGLShader;
begin
  ShaderObject := gl.createShader(shaderType);
  if ShaderObject = nil then begin
    Writeln('create shader failed');
  end;
  gl.shaderSource(ShaderObject, AShader);
  gl.compileShader(ShaderObject);
  if not gl.getShaderParameter(ShaderObject, gl.COMPILE_STATUS) then begin
    Writeln('Fehler in ', GetShader(shaderType), ': ', gl.getShaderInfoLog(ShaderObject));
  end;

  gl.attachShader(FProgramObject, ShaderObject);
end;

function TShader.GetShader(e: GLenum): string;
begin
  case e of
    gl.VERTEX_SHADER: begin
      Result := 'VERTEX_SHADER';
    end;
    gl.FRAGMENT_SHADER: begin
      Result := 'gFRAGMENT_SHADER';
    end;
  end;
end;

procedure TShader.LinkProgram;
begin
  gl.linkProgram(FProgramObject);
  if not gl.getProgramParameter(FProgramObject, gl.LINK_STATUS) then begin
    Writeln(gl.getProgramInfoLog(FProgramObject));
    gl.deleteProgram(FProgramObject);
  end;
end;

procedure TShader.UseProgram;
begin
  gl.useProgram(FProgramObject);
end;

function TShader.UniformLocation(Name: string): TJSWebGLUniformLocation;
begin
  Result := gl.getUniformLocation(FProgramObject, Name);
end;

function TShader.AttribLocation(Name: string): GLint;
begin
  Result := gl.getAttribLocation(FProgramObject, Name);
end;

end.
